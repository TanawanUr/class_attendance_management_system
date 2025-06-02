const express = require("express");
const router = express.Router();
const line = require("@line/bot-sdk");
const pool = require("../db");

const client = new line.Client({
  channelAccessToken: process.env.LINE_ACCESS_TOKEN,
  channelSecret: process.env.LINE_CHANNEL_SECRET,
});

router.post("/", (req, res) => {
  Promise.all(req.body.events.map(handleEvent))
    .then((result) => res.json(result))
    .catch((err) => {
      console.error("LINE Webhook Error:", err);
      res.status(500).end();
    });
});

async function handleEvent(event) {
  if (event.type !== "message" || event.message.type !== "text") {
    return Promise.resolve(null);
  }

  const studentId = event.message.text.trim();
  const lineId = event.source.userId;

  try {
    const conn = await pool.getConnection();

    // ตรวจสอบรหัสนักเรียน
    const [students] = await conn.query(
      "SELECT full_name FROM students WHERE student_id = ?",
      [studentId]
    );

    if (students.length === 0) {
      await client.replyMessage(event.replyToken, {
        type: "text",
        text: `ไม่พบรหัสนักศึกษา : ${studentId} ในระบบ`,
      });
      conn.release();
      return;
    }

    const studentName = students[0].full_name;

    // บันทึก lineId ใน table parents
    await conn.query(
      `
      INSERT INTO parents (student_id, line_id)
      VALUES (?, ?)
      ON DUPLICATE KEY UPDATE line_id = VALUES(line_id)
    `,
      [studentId, lineId]
    );

    await client.replyMessage(event.replyToken, {
      type: "text",
      text: `เชื่อมโยง LINE กับรหัสนักศึกษา ${studentId} เรียบร้อยแล้ว`,
    });

    conn.release();
  } catch (err) {
    console.error("handleEvent error:", err);
    await client.replyMessage(event.replyToken, {
      type: "text",
      text: `เกิดข้อผิดพลาดในการเชื่อมโยงข้อมูล กรุณาลองใหม่ภายหลัง`,
    });
  }
}

module.exports = router;

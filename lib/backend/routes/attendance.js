const express = require("express");
const router = express.Router();
const pool = require("../db");
const authMiddleware = require("../middleware/auth");

// GET /attendance?class_id=xxx&date=2025-05-26&start_time=09:00&end_time=10:00
router.get("/", async (req, res) => {
  const { class_id, date, start_time, end_time } = req.query;

  if (!class_id || !date || !start_time || !end_time)
    return res.status(400).json({ error: "Missing parameters" });

  try {
    const conn = await pool.getConnection();

    const [sessionRows] = await conn.execute(
      `
      SELECT * FROM attendance_sessions 
      WHERE class_id = ? AND session_date = ? AND start_time = ? AND end_time = ?
    `,
      [class_id, date, start_time, end_time]
    );

    const attendanceSession = sessionRows[0];

    // ดึงนักเรียนทั้งหมดใน class นี้
    const [studentRows] = await conn.execute(
      `
      SELECT s.student_id, s.full_name
      FROM class_students cs
      JOIN students s ON cs.student_id = s.student_id
      WHERE cs.class_id = ?
    `,
      [class_id]
    );

    // ถ้ามี session แล้ว ดึงสถานะด้วย
    if (attendanceSession) {
      const [records] = await conn.execute(
        `
        SELECT student_id, status, marked_at
        FROM attendance_records
        WHERE attendance_id = ?
      `,
        [attendanceSession.attendance_id]
      );

      const recordsMap = Object.fromEntries(
        records.map((r) => [r.student_id, r])
      );

      const students = studentRows.map((s) => ({
        student_id: s.student_id,
        full_name: s.full_name,
        status: recordsMap[s.student_id]?.status || null,
        marked_at: recordsMap[s.student_id]?.marked_at || null,
      }));

      res.json({ attendance_id: attendanceSession.attendance_id, students });
    } else {
      res.json({
        attendance_id: null,
        students: studentRows.map((s) => ({
          student_id: s.student_id,
          full_name: s.full_name,
          status: null,
          marked_at: null,
        })),
      });
    }

    conn.release();
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal server error" });
  }
});

router.post("/mark", async (req, res) => {
  const { class_id, date, start_time, end_time, created_by, records } =
    req.body;

  if (!class_id || !date || !start_time || !end_time || !created_by || !records)
    return res.status(400).json({ error: "Missing required fields" });

  let conn;

  try {
    conn = await pool.getConnection();

    const [sessionRows] = await conn.execute(
      `
      SELECT * FROM attendance_sessions 
      WHERE class_id = ? AND session_date = ? AND start_time = ? AND end_time = ?
    `,
      [class_id, date, start_time, end_time]
    );

    let attendance_id = sessionRows[0]?.attendance_id;

    if (!attendance_id) {
      attendance_id = `att_${Date.now()}`;
      await conn.execute(
        `
        INSERT INTO attendance_sessions (attendance_id, class_id, session_date, start_time, end_time, created_by)
        VALUES (?, ?, ?, ?, ?, ?)
      `,
        [attendance_id, class_id, date, start_time, end_time, created_by]
      );
    }

    for (const { student_id, status } of records) {
      await conn.execute(
        `
        INSERT INTO attendance_records (attendance_id, student_id, status, marked_at)
        VALUES (?, ?, ?, NOW())
        ON DUPLICATE KEY UPDATE status = ?, marked_at = NOW()
      `,
        [attendance_id, student_id, status, status]
      );
    }

    res.json({ message: "Attendance saved", attendance_id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal server error" });
  } finally {
    if (conn) conn.release();
  }
});

router.get("/history", async (req, res) => {
  const { class_id, date, start_time, end_time } = req.query;

  if (!class_id || !date) {
    return res.status(400).json({ error: "class_id and date are required" });
  }

  try {
    const [attendanceRecords] = await pool.execute(
      `
      SELECT
        s.student_id,
        s.full_name AS student_name,
        ar.status,
        a.start_time,
        a.end_time,
        sub.subject_name
      FROM attendance_sessions a
      JOIN attendance_records ar ON ar.attendance_id = a.attendance_id
      JOIN students s ON s.student_id = ar.student_id
      JOIN classes c ON c.class_id = a.class_id
      JOIN subjects sub ON sub.subject_id = c.subject_id
      WHERE a.class_id = ?
        AND a.session_date = ?
        ${
          start_time && end_time
            ? "AND a.start_time = ? AND a.end_time = ?"
            : ""
        }
    `,
      start_time && end_time
        ? [class_id, date, start_time, end_time]
        : [class_id, date]
    );

    if (attendanceRecords.length === 0) {
      return res.status(404).json({ error: "No attendance records found" });
    }

    const subjectName = attendanceRecords[0].subject_name;
    const firstSession = attendanceRecords[0];

    res.json({
      class_id,
      date,
      start_time: firstSession.start_time,
      end_time: firstSession.end_time,
      subject_name: subjectName,
      attendance: attendanceRecords.map((record) => ({
        student_id: record.student_id,
        name: record.student_name,
        status: record.status,
      })),
    });
  } catch (err) {
    console.error("Error fetching attendance history:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

// GET /api/teacher/history-options
router.get("/history-options", authMiddleware, async (req, res) => {
  const userId = req.user.user_id;

  if (!userId) {
    return res
      .status(401)
      .json({ error: "Unauthorized: Missing user_id in token" });
  }

  try {
    const [rows] = await pool.query(
      `
      SELECT 
        s.subject_name,
        a.session_date,
        TIME_FORMAT(a.start_time, '%H:%i') AS start_time,
        TIME_FORMAT(a.end_time, '%H:%i') AS end_time,
        a.class_id
      FROM attendance_sessions a
      JOIN classes c ON a.class_id = c.class_id
      JOIN subjects s ON c.subject_id = s.subject_id
      WHERE c.user_id = ?
      ORDER BY s.subject_name, a.session_date, a.start_time
      `,
      [userId]
    );

    const subjects = new Set();
    const subjectDates = {};
    const dateTimes = {};

    for (const row of rows) {
      const { subject_name, session_date, start_time, end_time, class_id } =
        row;

      const dateObj = new Date(session_date);
      const formattedDate = dateObj.toISOString().split("T")[0]; // "2025-05-26"
      const timeLabel = `${start_time} - ${end_time}`;

      // เก็บ subject
      subjects.add(subject_name);

      // เก็บ subjectDates
      if (!subjectDates[subject_name]) {
        subjectDates[subject_name] = [];
      }
      if (!subjectDates[subject_name].includes(formattedDate)) {
        subjectDates[subject_name].push(formattedDate);
      }

      // เก็บ dateTimes
      if (!dateTimes[formattedDate]) {
        dateTimes[formattedDate] = [];
      }

      // ป้องกันซ้ำ
      if (!dateTimes[formattedDate].some((t) => t.label === timeLabel)) {
        dateTimes[formattedDate].push({
          label: timeLabel,
          start_time,
          end_time,
          class_id,
        });
      }
    }

    res.json({
      subjects: [...subjects],
      subjectDates,
      dateTimes,
    });
  } catch (err) {
    console.error("Error fetching history options:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

module.exports = router;

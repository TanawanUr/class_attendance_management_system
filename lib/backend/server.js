const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
require("dotenv").config();

const app = express();
app.use(cors());
app.use(bodyParser.json());

const loginRoutes = require("./routes/login");
app.use("/auth", loginRoutes);

const subjectsRoutes = require("./routes/subjects");
app.use("/subjects", subjectsRoutes);

const attendanceRoutes = require("./routes/attendance");
app.use("/attendance", attendanceRoutes);

const homeworkRoutes = require("./routes/homework");
app.use("/homework", homeworkRoutes);

const tuitionRoutes = require("./routes/tuition");
app.use("/tuition", tuitionRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

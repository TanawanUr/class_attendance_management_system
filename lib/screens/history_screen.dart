import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  final String selectedSubject;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;

  HistoryScreen({
    Key? key,
    this.selectedSubject = '',
    this.selectedDate,
    this.selectedTime,
  }) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String? selectedSubject;
  String? selectedDate;
  String? selectedTime;

  List<String> subjects = ['คณิตศาสตร์', 'วิทยาศาสตร์', 'ภาษาไทย'];
  Map<String, List<String>> subjectDates = {
    'คณิตศาสตร์': ['2025-05-01', '2025-05-08'],
    'วิทยาศาสตร์': ['2025-05-02'],
    'ภาษาไทย': ['2025-05-03'],
  };
  Map<String, List<String>> dateTimes = {
    '2025-05-01': ['09:00', '13:00'],
    '2025-05-08': ['10:00'],
    '2025-05-02': ['11:00'],
    '2025-05-03': ['08:30'],
  };

  Map<String, List<Map<String, dynamic>>> dummyAttendanceRecords = {
    'คณิตศาสตร์|2025-05-01|09:00': [
      {'id': '16440414001', 'name': 'สมชาย', 'status': 'มาเรียน'},
      {'id': '16440414002', 'name': 'สมหญิง', 'status': 'ลาป่วย'},
      {'id': '16440414003', 'name': 'ดำรง', 'status': 'ขาด'},
      {'id': '16440414004', 'name': 'อรพรรณ', 'status': 'ลากิจ'},
      {'id': '16440414005', 'name': 'บรรเจิด', 'status': 'มาเรียน'},
      {'id': '16440414006', 'name': 'อารีย์', 'status': 'สาย'},
      {'id': '16440414007', 'name': 'อรทัย', 'status': 'มาเรียน'},
      {'id': '16440414008', 'name': 'อรพรรณ', 'status': 'ลากิจ'},
      {'id': '16440414009', 'name': 'บรรเจิด', 'status': 'มาเรียน'},
      {'id': '16440414010', 'name': 'อารีย์', 'status': 'มาเรียน'},
    ],
    'คณิตศาสตร์|2025-05-01|13:00': [
      {'id': '004', 'name': 'อรพรรณ', 'status': 'มาเรียน'},
    ],
    'วิทยาศาสตร์|2025-05-02|11:00': [
      {'id': '005', 'name': 'บรรเจิด', 'status': 'มาเรียน'},
    ],
    'ภาษาไทย|2025-05-03|08:30': [
      {'id': '006', 'name': 'อารีย์', 'status': 'ขาด'},
    ],
  };

  final Map<String, Color> statusColors = {
    'มาเรียน': Color(0xff57BC40),
    'สาย': Color(0xffEAA31E),
    'ขาด': Color(0xffE94C30),
    'ลากิจ': Color(0xff33A4C3),
    'ลาป่วย': Color(0xffAE62E2),
  };

  List<Map<String, dynamic>> attendanceData = [];

  void fetchAttendanceData() {
    String key = '$selectedSubject|$selectedDate|$selectedTime';
    setState(() {
      attendanceData = dummyAttendanceRecords[key] ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    selectedSubject = widget.selectedSubject;
    selectedDate = widget.selectedDate?.toIso8601String().substring(0, 10);
    selectedTime = widget.selectedTime?.format(context);
    if (selectedSubject != null &&
        selectedDate != null &&
        selectedTime != null) {
      fetchAttendanceData();
    }
  }

  Map<String, int> getSummary(List<Map<String, dynamic>> data) {
    int present = 0;
    int late = 0;
    int absent = 0;
    int personal_leave = 0;
    int sick_leave = 0;

    for (var record in data) {
      switch (record['status']) {
        case 'มาเรียน':
          present++;
          break;
        case 'สาย':
          late++;
          break;
        case 'ขาด':
          absent++;
          break;
        case 'ลากิจ':
          personal_leave++;
          break;
        case 'ลาป่วย':
          sick_leave++;
          break;
      }
    }

    return {
      'present': present,
      'late': late,
      'absent': absent,
      'personal_leave': personal_leave,
      'sick_leave': sick_leave,
    };
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> summary = getSummary(attendanceData);

    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff00154C),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.elliptical(200, 100)),
            ),
            padding: const EdgeInsets.only(top: 90, bottom: 60),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  'ประวัติการเช็คชื่อ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                Positioned(
                  left: 5,
                  top: -15,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Subject Dropdown
                        Row(
                          children: [
                            Text('ชื่อวิชา : ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffEAEAEA),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  dropdownColor: Colors.white, 
                                  value: subjects.contains(selectedSubject)
                                      ? selectedSubject
                                      : null,
                                  hint: Text('เลือกวิชา'),
                                  items: subjects.map((subject) {
                                    return DropdownMenuItem(
                                      value: subject,
                                      child: Text(subject),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSubject = value;
                                      selectedDate = null;
                                      selectedTime = null;
                                      attendanceData = [];
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Date Dropdown
                        if (selectedSubject != null)
                          Row(
                            children: [
                              Text('วันที่ : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffEAEAEA),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    dropdownColor: Colors.white, 
                                    value: subjectDates[selectedSubject]
                                                ?.contains(selectedDate) ==
                                            true
                                        ? selectedDate
                                        : null,
                                    hint: Text('เลือกวันที่'),
                                    items: (subjectDates[selectedSubject] ?? [])
                                        .map((date) => DropdownMenuItem(
                                              value: date,
                                              child: Text(date),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedDate = value;
                                        selectedTime = null;
                                        attendanceData = [];
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                        const SizedBox(height: 12),

                        // Time Dropdown
                        if (selectedDate != null)
                          Row(
                            children: [
                              Text('เวลา : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffEAEAEA),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    dropdownColor: Colors.white, 
                                    value: dateTimes[selectedDate]
                                                ?.contains(selectedTime) ==
                                            true
                                        ? selectedTime
                                        : null,
                                    hint: Text('เลือกเวลา'),
                                    items: dateTimes[selectedDate]!
                                        .map((time) => DropdownMenuItem(
                                              value: time,
                                              child: Text(time),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTime = value;
                                        fetchAttendanceData();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),

                  // Summary Box
                  if (attendanceData.isNotEmpty)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'สรุปการเช็คชื่อ',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buildSummaryItem(
                                  'มาเรียน', summary['present'] ?? 0),
                              buildSummaryItem('สาย', summary['late'] ?? 0),
                              buildSummaryItem('ขาด', summary['absent'] ?? 0),
                              buildSummaryItem(
                                  'ลากิจ', summary['personal_leave'] ?? 0),
                              buildSummaryItem(
                                  'ลาป่วย', summary['sick_leave'] ?? 0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  
                  SizedBox(height: 20),

                  if (attendanceData.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                          children: [
                            Container(
                              color: Color(0xFF001B57),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              child: Row(
                                children: [
                                  _tableHeader('รหัสนักศึกษา', flex: 2),
                                  _tableHeader('ชื่อ–นามสกุล', flex: 3),
                                  _tableHeader('สถานะ', flex: 1),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 35),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: attendanceData.map((record) {
                                    final id = record['id']!;
                                    final name = record['name']!;
                                    final status = record['status'] ?? 'ไม่ทราบ';
                                
                                    return Container(
                                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(color: Colors.grey.shade300),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          _tableCell(id, flex: 2),
                                          _tableCell(name, flex: 3),
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 30,
                                              child: ElevatedButton(
                                                onPressed: (){}, 
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                  backgroundColor: statusColors[status] ?? Colors.grey.shade300,
                                                  foregroundColor: Colors.white,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                                child: Text(
                                                  status,
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableHeader(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _tableCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: AutoSizeText(
        text,
        style: TextStyle(fontSize: 16),
        maxLines: 1,
        minFontSize: 12,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildSummaryItem(String label, int count) {
    Color backgroundColor;

    switch (label) {
      case 'มาเรียน':
        backgroundColor = Color(0xff57BC40);
        break;
      case 'สาย':
        backgroundColor = Color(0xffEAA31E);
        break;
      case 'ขาด':
        backgroundColor = Color(0xffE94C30);
        break;
      case 'ลากิจ':
        backgroundColor = Color(0xff33A4C3);
        break;
      case 'ลาป่วย':
        backgroundColor = Color(0xffAE62E2);
        break;
      default:
        backgroundColor = Color(0xff00154C);
    }

    return Column(
      children: [
        Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: AutoSizeText(
              count.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

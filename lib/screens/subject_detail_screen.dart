import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SubjectDetailScreen extends StatefulWidget {
  final String subjectName;
  final String date;
  final String time;

  const SubjectDetailScreen({
    Key? key,
    required this.subjectName,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  String selectedStatus = 'เลือก';
  Map<String, String> selectedStatuses = {};

  final List<String> statusOptions = [
    'มาเรียน',
    'สาย',
    'ขาด',
    'ลากิจ',
    'ลาป่วย'
  ];

  final Map<String, Color> statusColors = {
    'มาเรียน': Color(0xff57BC40),
    'สาย': Color(0xffEAA31E),
    'ขาด': Color(0xffE94C30),
    'ลากิจ': Color(0xff33A4C3),
    'ลาป่วย': Color(0xffAE62E2),
  };

  final List<Map<String, String>> students = [
    {
      'id': '164404140076',
      'name': 'นายธนบดี สุธามา',
    },
    {
      'id': '164404140077',
      'name': 'นางสาวสมฤดี ใจดี',
    },
    {
      'id': '164404140078',
      'name': 'นายอาทิตย์ สว่างจิต',
    },
    {
      'id': '164404140079',
      'name': 'นางสาวอรอุมา สว่างจิต',
    },
    {
      'id': '164404140080',
      'name': 'นายพงศกร สุขใจ',
    },
    {
      'id': '164404140081',
      'name': 'นางสาวสุภาภรณ์ สุขใจ',
    },
    {
      'id': '164404140082',
      'name': 'นายอาทิตย์ สุขใจ',
    },
    {
      'id': '164404140083',
      'name': 'นางสาวอรอุมา สุขใจ',
    },
    {
      'id': '164404140084',
      'name': 'นายพงศกร สุขใจ',
    },
    {
      'id': '164404140085',
      'name': 'นางสาวสุภาภรณ์ สุขใจ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff00154C),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(200, 100),
              ),
            ),
            padding: const EdgeInsets.only(top: 90, bottom: 60),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  'เช็คชื่อนักศึกษา',
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
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
                Row(
                  children: [
                    Text(
                      'ชื่อวิชา : ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffEAEAEA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: AutoSizeText(
                          widget.subjectName,
                          style: TextStyle(fontSize: 18),
                          maxLines: 1,
                          minFontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'วันที่ : ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffEAEAEA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: AutoSizeText(
                          widget.date,
                          style: TextStyle(fontSize: 18),
                          maxLines: 1,
                          minFontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'เวลา : ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffEAEAEA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: AutoSizeText(
                          widget.time,
                          style: TextStyle(fontSize: 18),
                          maxLines: 1,
                          minFontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
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
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      child: Row(
                        children: [
                          _tableHeader('รหัสนักศึกษา', flex: 2),
                          _tableHeader('ชื่อ–นามสกุล', flex: 3),
                          _tableHeader('สถานะ', flex: 1, textAlignCenter: true),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 35),
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          final student = students[index];
                          final id = student['id']!;
                          final name = student['name']!;
                          final status = selectedStatuses[id] ?? 'เลือก';

                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                      onPressed: () => _showStatusDialogFor(id),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        backgroundColor: status == 'เลือก'
                                            ? Colors.grey.shade300
                                            : statusColors[status],
                                        foregroundColor: status == 'เลือก'
                                            ? Colors.black
                                            : Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        status,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showStatusDialogFor(String studentId) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Text(
                      'เลือก',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close, color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ...statusOptions.map((status) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: statusColors[status],
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedStatuses[studentId] = status;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(status, style: TextStyle(fontSize: 20)),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _tableHeader(String text, {int flex = 1, bool textAlignCenter = false}) {
  return Expanded(
    flex: flex,
    child: textAlignCenter
        ? Center(
            child: AutoSizeText(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 1,
              minFontSize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          )
        : AutoSizeText(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            maxLines: 1,
            minFontSize: 12,
            overflow: TextOverflow.ellipsis,
          ),
  );
}

Widget _tableCell(String text, {int flex = 1, bool textAlignCenter = false}) {
  return Expanded(
    flex: flex,
    child: textAlignCenter
        ? Center(
            child: AutoSizeText(
              text,
              style: TextStyle(fontSize: 16),
              maxLines: 1,
              minFontSize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          )
        : AutoSizeText(
            text,
            style: TextStyle(fontSize: 16),
            maxLines: 1,
            minFontSize: 12,
            overflow: TextOverflow.ellipsis,
          ),
  );
}

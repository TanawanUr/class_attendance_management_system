import 'package:auto_size_text/auto_size_text.dart';
import 'package:class_attendance_management_system/screens/assignment_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeworkDetailScreen extends StatefulWidget {
  final String subjectName;

  const HomeworkDetailScreen({
    Key? key,
    required this.subjectName,
  }) : super(key: key);

  @override
  State<HomeworkDetailScreen> createState() => _HomeworkDetailScreenState();
}

class _HomeworkDetailScreenState extends State<HomeworkDetailScreen> {
  final List<Map<String, String>> assignment = [
    {'assignmentTitle': 'สร้างโปรแกรมคิดเลข', 'dueDate': '2023-10-01'},
    {'assignmentTitle': 'สร้างโปรแกรมคำนวณ BMI', 'dueDate': '2023-10-15'},
    {
      'assignmentTitle': 'สร้างโปรแกรมจัดการข้อมูลนักเรียน',
      'dueDate': '2023-10-30'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateDialog(context);
        },
        backgroundColor: Color(0xffF9CA10),
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
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
                  'การบ้าน',
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
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
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
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          ),
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
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: Row(
                      children: [
                        _tableHeader('หัวข้อ', flex: 3),
                        _tableHeader('วันที่ส่ง - หมดเขต',
                            flex: 2, textAlignCenter: true),
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
                        children: assignment.map((task) {
                          final title = task['assignmentTitle']!;
                          final dueDate = task['dueDate']!;

                          return GestureDetector(
                            onTap: () {
                              // Navigate to the detail screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AssignmentDetailScreen(
                                    subjectName: widget.subjectName,
                                    title: title,
                                    dueDate: dueDate,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              child: Row(
                                children: [
                                  _tableCell(title, flex: 3),
                                  _tableCell(dueDate,
                                      flex: 2, textAlignCenter: true),
                                ],
                              ),
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

void showCreateDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Text(
                      'สร้างใหม่',
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
              const SizedBox(height: 20),
              Text(
                'หัวข้อ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'กรอกหัวข้อการบ้าน',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'กำหนดส่ง - หมดเขต',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextField(
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  // Handle picked date if needed
                },
                decoration: InputDecoration(
                  hintText: 'เลือกวันที่',
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF4C610),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'สร้าง',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

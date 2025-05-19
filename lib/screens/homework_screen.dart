import 'package:class_attendance_management_system/screens/homework_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeworkScreen extends StatefulWidget {

  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
    final List<Map<String, dynamic>> yearData = [
    {
      "year": "ปีที่ 1",
      "subjects": [
        "รหัสวิชา วงจรไฟฟ้า กลุ่มที่ 1",
        "รหัสวิชา วงจรไฟฟ้า กลุ่มที่ 2"
      ],
    },
    {
      "year": "ปีที่ 2",
      "subjects": [
        "รหัสวิชา วงจรไฟฟ้าขั้นสูง กลุ่มที่ 5",
        "รหัสวิชา วงจรไฟฟ้าขั้นสูง กลุ่มที่ 6"
      ],
    },
    {
      "year": "ปีที่ 3",
      "subjects": [
        "รหัสวิชา วงจรไฟฟ้าขั้นสูง กลุ่มที่ 5",
        "รหัสวิชา วงจรไฟฟ้าขั้นสูง กลุ่มที่ 6"
      ],
    },
    {
      "year": "ปีที่ 4",
      "subjects": [
        "รหัสวิชา วงจรไฟฟ้าขั้นสูง กลุ่มที่ 5",
        "รหัสวิชา วงจรไฟฟ้าขั้นสูง กลุ่มที่ 6"
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: yearData.length,
              itemBuilder: (context, index) {
                final year = yearData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.symmetric(horizontal: 16),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                year['year'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                height: 0.5,
                                color: Color(0xFFE0E0E0),
                              ),
                            ],
                          ),
                          children: [
                            ...year['subjects'].map<Widget>((subject) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0), // Move text back a bit
                                    child: ListTile(
                                      tileColor: Colors.white,
                                      title: Text(
                                        subject,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      dense: true,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeworkDetailScreen(subjectName: subject),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 24),
                                    height: 0.5,
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ],
                              );
                            }).toList(),
                            SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ]
      ),
    );
  }
}
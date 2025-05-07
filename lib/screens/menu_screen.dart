import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gridItems = [
      {'icon': Icons.login, 'label': 'เช็คชื่อนักศึกษา'},
      {'icon': Icons.person_add, 'label': 'ประวัติการเช็คชื่อ'},
      {'icon': Icons.settings, 'label': 'การบ้าน'},
      {'icon': Icons.info, 'label': 'สถานะการขาดเรียน'},
      {'icon': Icons.lock, 'label': 'ค่าเทอม'},
      // {'icon': Icons.phone, 'label': 'ติดต่อเรา'},
      // {'icon': Icons.help, 'label': 'ช่วยเหลือ'},
      // {'icon': Icons.map, 'label': 'แผนที่'},
      // {'icon': Icons.star, 'label': 'ให้คะแนน'},
      // {'icon': Icons.logout, 'label': 'ออกจากระบบ'},
    ];
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(200, 100),
              ),
              color: Color(0xff1E2383),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 90, bottom: 50),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'เมนู',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: gridItems.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final item = gridItems[index];
              return Column(
                children: [
                  Container(
                    width: 120,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(item['icon'], size: 40, color: Colors.black87),
                      onPressed: () {
                        // action for each button
                        print('${item['label']} tapped');
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item['label'],
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}

import 'package:class_attendance_management_system/screens/history_screen.dart';
import 'package:class_attendance_management_system/screens/homework_screen.dart';
import 'package:class_attendance_management_system/screens/select_subject_class_screen.dart';
import 'package:class_attendance_management_system/screens/tuition_screen.dart';
import 'package:flutter/material.dart';
import 'package:class_attendance_management_system/screens/login_screen.dart';
import 'package:class_attendance_management_system/screens/menu_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Color primaryBlue = const Color(0xFF00154C);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Kanit',
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          primary: primaryBlue,
          // background: Colors.white,
          surface: Colors.white, 
        ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/menu': (context) => MenuScreen(),
        '/select-subject-class': (context) => SelectSubjectClassScreen(),
        '/history': (context) => HistoryScreen(),
        '/homework': (context) => HomeworkScreen(),
        '/tuition': (context) => TuitionScreen(),
        // '/select-subject': (context) => SelectSubjectScreen(),
        // Add others...
      },
    );
  }
}
        // useMaterial3: true,

        
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

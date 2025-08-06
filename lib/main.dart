import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_quiz_app/data/existing_data.dart';
import 'package:flutter_quiz_app/views/login_screen.dart';
import 'package:flutter_quiz_app/views/nav_bar_category_selection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return NavBarCategorySelection(initialIndex: 0);
            } else {
              return LoginScreen();
            }
          }
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

// class UploadDataInFirebase extends StatelessWidget {
//   const UploadDataInFirebase({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               uploadQuestionsToFirebase();
//             },
//             child: const Text("Upload dsadasData"),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int totalQuestion;
  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestion,
  });

  //   Future<void> _updateUserScore() async {
  //   var user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return;
  //   try {
  //     var userRef = FirebaseFirestore.instance
  //         .collection("userData")
  //         .doc(user.uid);
  //     await FirebaseFirestore.instance.runTransaction((Transaction) async {
  //       var snapshot = await Transaction.get(userRef);
  //       if (!snapshot.exists) return;
  //       int existingScore = snapshot['score'] ?? 0;
  //       Transaction.update(userRef, {'score': existingScore + score});
  //     });
  //   } catch (e) {
  //     debugPrint('error updating score $e');
  //   }
  // }

  Future<void> updateUserScore() async{
    User? user = FirebaseAuth.instanceFor(app: app)
  }
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

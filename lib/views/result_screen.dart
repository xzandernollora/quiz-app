// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/views/nav_bar_category_selection.dart';
import 'package:flutter_quiz_app/widgets/animated_my_button.dart';

import 'package:lottie/lottie.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestion;
  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestion,
  });

  Future<void> updateUserScore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      DocumentReference userRef = FirebaseFirestore.instance
          .collection("userData")
          .doc(user.uid);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userRef);
        if (!snapshot.exists) {
          throw Exception("User does not exist");
        }
        int existingScore = snapshot['score'] ?? 0;
        transaction.update(userRef, {'score': existingScore + score});
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        title: Text("RESULT"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Column(
            children: [
              Stack(
                children: [
                  Lottie.network(
                    "https://lottie.host/6e45e369-facf-4a6e-83e2-e09dd2197702/F896HU5aHu.json",

                    height: 200,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                  Lottie.network(
                    "https://lottie.host/6b265d69-825b-4edf-aa04-5582fae770d6/oxxbxreQ8W.json",
                    height: 200,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                "Quiz Completed!",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Your score $score out of $totalQuestion",
                style: TextStyle(fontSize: 22),
              ),
              Text(
                "${(score / totalQuestion * 100).toStringAsFixed(2)}%",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AnimatedMyButton(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NavBarCategorySelection(initialIndex: 0),
                            ),
                            (router) => false,
                          );
                        },
                        buttontext: "New Quiz",
                        color: Colors.pinkAccent,
                      ),
                    ),
                    SizedBox(width: 16), // good gap, not too wide
                    Expanded(
                      child: AnimatedMyButton(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NavBarCategorySelection(initialIndex: 1),
                            ),
                            (router) => false,
                          );
                        },
                        buttontext: "Your Ranking",
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

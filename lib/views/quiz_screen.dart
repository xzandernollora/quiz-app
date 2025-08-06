import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/widgets/my_button.dart';

class QuizScreen extends StatefulWidget {
  final String categoryName;
  final Color containerColor;
  const QuizScreen({
    super.key,
    required this.categoryName,
    required this.containerColor,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> question = [];
  int currentIndex = 0, score = 0;
  int? selectedOption;
  bool hasAnswered = false, isLoading = true;
  @override
  void initState() {
    _fetchQuestions();
    super.initState();
  }

  Future<void> _fetchQuestions() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection("ListOfQuestions")
          .doc(widget.categoryName)
          .get();

      if (snapshot.exists) {
        var data = snapshot.data();
        if (data != null && data.containsKey("questions")) {
          var questionMap = data['questions'];

          if (questionMap is Map<String, dynamic>) {
            var fetchedQuestions = questionMap.entries.map((entry) {
              var q = entry.value;
              var optionsMap = q['options'] as Map<String, dynamic>;
              var optionList = optionsMap.entries.toList()
                ..sort((a, b) => int.parse(a.key).compareTo(int.parse(b.key)));
              var options = optionList.map((e) => e.value.toString()).toList();
              return {
                'questionText': q['questionText'] ?? "No Question",
                'options': options,
                'correctOptionKey':
                    int.tryParse(q['correctOptionKey'].toString()) ?? 0,
              };
            }).toList();
            fetchedQuestions.shuffle(Random());
            if (fetchedQuestions.length > 20) {
              fetchedQuestions = fetchedQuestions.sublist(0, 20);
            }
            setState(() => question = fetchedQuestions);
          }
        }
        ;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _checkAnswer(int index) {
    setState(() {
      hasAnswered = true;
      selectedOption = index;
      if (question[currentIndex]['correctOptionKey'] == index + 1) {
        score++;
      }
    });
  }

  Future<void> _nextQuestion() async {
    if (currentIndex < question.length - 1) {
      setState(() {
        currentIndex++;
        hasAnswered = false;
        selectedOption = null;
      });
    } else {
      await _updateUserScore();
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => ResultScreen()),
      // );
    }
  }

  Future<void> _updateUserScore() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      var userRef = FirebaseFirestore.instance
          .collection("userData")
          .doc(user.uid);
      await FirebaseFirestore.instance.runTransaction((Transaction) async {
        var snapshot = await Transaction.get(userRef);
        if (!snapshot.exists) return;
        int existingScore = snapshot['score'] ?? 0;
        Transaction.update(userRef, {'score': existingScore + score});
      });
    } catch (e) {
      debugPrint('error updating score $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (question.isEmpty) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: Center(child: Text("No Questions Available")),
      );
    }
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (currentIndex + 1) / question.length,
              backgroundColor: Colors.grey.shade300,
              color: widget.containerColor,
              minHeight: 8,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: widget.containerColor.withAlpha((0.1 * 255).toInt()),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                question[currentIndex]['questionText'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.containerColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return _buildOption(index);
                },
                separatorBuilder: (_, _) => SizedBox(height: 15),
                itemCount: question[currentIndex]['options'].length,
              ),
            ),
            if (hasAnswered)
              MyButton(
                onTap: _nextQuestion,
                buttontext: currentIndex == question.length - 1
                    ? "Finish"
                    : "Next",
              ),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(int index) {
    bool isCorrect = question[currentIndex]['correctOptionKey'] == index + 1;
    bool isSelected = selectedOption == index;
    Color bgColor = hasAnswered
        ? (isCorrect
              ? Colors.green.shade300
              : isSelected
              ? Colors.red.shade300
              : Colors.grey.shade200)
        : Colors.grey.shade200;
    Color textColor = hasAnswered && (isCorrect || isSelected)
        ? Colors.white
        : Colors.black;
    return InkWell(
      onTap: hasAnswered ? null : () => _checkAnswer(index),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          question[currentIndex]['options'][index],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      foregroundColor: Colors.white,
      title: Text(
        "${widget.categoryName} (${currentIndex + 1}/${question.length})",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: widget.containerColor,
    );
  }
}

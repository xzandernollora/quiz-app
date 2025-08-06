import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  Stream<List<Map<String, dynamic>>> getLeaderboardData() {
    return FirebaseFirestore.instance
        .collection('userData')
        .orderBy('score', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: getLeaderboardData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!;
          if (users.isEmpty) {
            return Center(child: Text("No users found"));
          }

          final topThree = users.take(3).toList();
          final remainingUser = users.skip(3).toList();

          return Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/Leaderboard.png",
                    width: double.infinity,
                    height: 450,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 70,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        "Leaderboard",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  if (topThree.isNotEmpty)
                    Positioned(
                      top: 88,
                      right: 45,
                      left: 52,
                      child: _buildTopUser(topThree[0], 1, context),
                    ),
                  if (topThree.length >= 2)
                    Positioned(
                      top: 165,
                      left: 54,
                      child: _buildTopUser(topThree[1], 2, context),
                    ),
                  if (topThree.length >= 3)
                    Positioned(
                      top: 185,
                      right: 40,
                      child: _buildTopUser(
                        topThree[2],
                        3,
                        context,
                      ), // fixed index
                    ),
                ],
              ),

              // 👇 Move the list OUTSIDE the Stack and wrap in Expanded
              Expanded(
                child: ListView.builder(
                  itemCount: remainingUser.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final user = remainingUser[index];
                    final rank = index + 4;
                    return _buildRegularUser(user, rank, context);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTopUser(
    Map<String, dynamic> user,
    int rank,
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Container(
            height: 30,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("🥰", style: TextStyle(fontSize: 19)),
                SizedBox(width: 5),
                Text(
                  "${user['score'] * 102}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3),
          CircleAvatar(
            radius: rank == 1 ? 40 : 30,
            backgroundImage: user['photoBase64'] != null
                ? MemoryImage(base64Decode(user['photoBase64']))
                : null,
            child: user['photoBase64'] == null
                ? Icon(Icons.person, size: 30)
                : null,
          ),
          SizedBox(height: 2),
          Text(
            user['name'],
            style: TextStyle(
              fontSize: rank == 1 ? 22 : 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegularUser(
    Map<String, dynamic> user,
    int rank,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Text(
            '$rank',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(width: 12),
          CircleAvatar(
            radius: 25,
            backgroundImage: user['photoBase64'] != null
                ? MemoryImage(base64Decode(user['photoBase64']))
                : null,
            child: user['photoBase64'] == null
                ? Icon(Icons.person, size: 24)
                : null,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              user['name'] ?? 'Unnamed',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${user['score'] * 102}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

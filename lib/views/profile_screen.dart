// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_quiz_app/widgets/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/views/login_screen.dart';
import 'package:flutter_quiz_app/widgets/my_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = true;
  Map<String, dynamic>? userData;

  Uint8List? profileImageBytes;
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (user == null) return;
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("userData")
          .doc(user!.uid)
          .get();

      if (documentSnapshot.exists) {
        setState(() {
          userData = documentSnapshot.data() as Map<String, dynamic>?;
          if (userData?['photoBase64'] != null) {
            profileImageBytes = base64Decode(userData!['photoBase64']);
          }
          isLoading = false;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateProfileImage(Uint8List imageBytes) async {
    if (user == null) return;
    try {
      String base64Image = base64Encode(imageBytes);

      await FirebaseFirestore.instance
          .collection("userData")
          .doc(user!.uid)
          .set({"photoBase64": base64Image}, SetOptions(merge: true));
      setState(() {
        profileImageBytes = imageBytes;
      });
      showSnackBAR(context, "Profile Image Updated successfully");
    } catch (e) {
      showSnackBAR(context, "Failed uploading Image $e");
    }
  }

  Future<void> pickImageFromGallery() async {
    final returnImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (returnImage == null) return;
    final imageBytes = await returnImage.readAsBytes();
    if (!mounted) return;

    await updateProfileImage(imageBytes);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userData == null
          ? Center(child: Text("No user data found"))
          : Padding(
              padding: EdgeInsetsGeometry.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: pickImageFromGallery,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      radius: 60,
                      backgroundImage: profileImageBytes != null
                          ? MemoryImage(profileImageBytes!) as ImageProvider
                          : NetworkImage(
                              "https://st.depositphotos.com/1779253/5140/v/450/depositphotos_51405259-stock-illustration-male-avatar-profile-picture-use.jpg",
                            ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 16,
                          child: Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    userData?['name'],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Score: ${userData?['score'] * 102}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 15),
                  Divider(),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: MyButton(onTap: signOut, buttontext: "SignOut"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

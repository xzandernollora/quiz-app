import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/service/auth_service.dart';
import 'package:flutter_quiz_app/views/nav_bar_category_selection.dart';
import 'package:flutter_quiz_app/views/signup_screen.dart';
import 'package:flutter_quiz_app/widgets/my_button.dart';
import 'package:flutter_quiz_app/widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  bool isPasswordHidden = true;
  final AuthService _authService = AuthService();

  void _login() async {
    setState(() {
      isLoading = true;
    });
    final result = await _authService.loginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    if (result == "success") {
      setState(() {
        isLoading = false;
      });
      Navigator.of(
        // ignore: use_build_context_synchronously
        context,
      ).pushReplacement(
        MaterialPageRoute(
          builder: (context) => NavBarCategorySelection(initialIndex: 0),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // ignore: use_build_context_synchronously
      showSnackBAR(context, "Login failed $result", isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(15),
          child: Column(
            children: [
              Image.asset("assets/loginscreenlogo.png"),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "New password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: isPasswordHidden,
              ),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      child: MyButton(onTap: _login, buttontext: "Login"),
                    ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  SignupScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                final slide = Tween<Offset>(
                                  begin: Offset(-1.0, 0.0),
                                  end: Offset.zero,
                                ).animate(animation);

                                final fade = Tween<double>(
                                  begin: 0.0,
                                  end: 1.0,
                                ).animate(animation);

                                return SlideTransition(
                                  position: slide,
                                  child: FadeTransition(
                                    opacity: fade,
                                    child: child,
                                  ),
                                );
                              },
                        ),
                      );
                    },
                    child: Text(
                      "Sign up here!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '/dashboard/dashboard.dart';
import 'package:provider/src/provider.dart';
import 'forgot_password.dart';
import "registration.dart";
import 'package:google_fonts/google_fonts.dart';
import 'account_handler.dart';
import 'profile.dart';

//login page that authenticates user with firestore database
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://freevector-images.s3.amazonaws.com/uploads/vector/preview/40529/White_Background_generated.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Form(
            key: _formKey,
            child: ListView(children: [
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Center(
                      child: Image.asset(
                        "images/ps.png",
                        width: 280,
                        height: 100,
                      ),
                    ),
                  ),
                  ListTile(
                      title: Text(" Login",
                          style: GoogleFonts.playfairDisplay(
                            fontStyle: FontStyle.normal,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      subtitle: const Text("  Please sign in to continue")),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Field';
                        }
                        if (value.contains("@") == false) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Email',
                          hintText: 'john.kennedy@ontariotechu.net'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 15, bottom: 0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Field';
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Password',
                          hintText: 'Enter password'),
                    ),
                  ),
                  Container(
                    alignment: const Alignment(0.9, 0.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ForgotPasswordPage()));
                      },
                      child: const Text(
                        'Forgot Password?',
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)),
                    child: ElevatedButton(
                      onPressed: () async {
                        bool verification = await AccountHandler.accountHandler
                            .loginCheck(emailController.text.toString(),
                                passwordController.text.toString());
                        if (_formKey.currentState!.validate()) {
                          if (verification == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Welcome')),
                            );
                            Profile currentProfile = await AccountHandler
                                .accountHandler
                                .getUser(emailController.text.toString());
                            context.read<AccountHandler>().setProfile =
                                currentProfile;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashboardPage(),
                                ));
                          } else if (verification == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Error: Incorrect Credentials')),
                            );
                          }
                        }
                      },
                      child: Text('Login',
                          style: GoogleFonts.playfairDisplay(
                            fontStyle: FontStyle.normal,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const Text(
                        'New User?',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => RegisterPage()));
                        },
                        child: const Text(
                          'Create Account',
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ]),
          )),
    );
  }
}

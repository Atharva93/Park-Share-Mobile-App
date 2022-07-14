import 'package:flutter/material.dart';
import 'profile.dart';
import 'account_handler.dart';
import '/Dashboard/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';

//Registers user and validates all inputs
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<Profile> profiles = [];

  TextEditingController emailController = TextEditingController();
  TextEditingController sidController = TextEditingController();
  TextEditingController pController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
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
                    Center(
                      child: Image.asset(
                        "images/ps.png",
                        width: 200,
                        height: 200,
                      ),
                    ),
                    ListTile(
                        title: Text(" Register",
                            style: GoogleFonts.playfairDisplay(
                              fontStyle: FontStyle.normal,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        subtitle:
                            Text("  Please fill out all fields continue")),
                    SizedBox(height: 20),
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
                          left: 20.0, right: 20.0, top: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Field';
                          }
                          if (value.length != 9) {
                            return 'Please enter 9 numerical digits';
                          }
                          return null;
                        },
                        controller: sidController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Student Number',
                            hintText: '100123456'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Field';
                          }
                          if (value.length != 10) {
                            return 'Please enter 10 numerical digits';
                          }
                          return null;
                        },
                        controller: pController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '4161234567'),
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
                        controller: fnameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'First Name',
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'John'),
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
                        controller: lnameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Last Name',
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Doe'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 15, bottom: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Field';
                          }

                          if (value.contains(
                                  RegExp(r'[A-Z]', caseSensitive: true)) ==
                              false) {
                            return 'Must contain a capital letter';
                          }

                          if (value.contains(
                                  RegExp(r'[a-z]', caseSensitive: true)) ==
                              false) {
                            return 'Must contain a lowercase letter';
                          }
                          if (value.length < 8) {
                            return 'Must be atleast 8 characters';
                          }
                          if (value.contains(RegExp(r'[0-9]')) == false) {
                            return 'Must contain atleast 1 number';
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
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool hasAccount =
                                await AccountHandler.accountHandler.hasAccount(
                                    emailController.text.toString(),
                                    sidController.text.toString());
                            if (hasAccount) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'This Email/Student ID is already registered')),
                              );
                            } else {
                              setState(() async {
                                AccountHandler.accountHandler.addUser(
                                    fnameController.text.toString(),
                                    lnameController.text.toString(),
                                    emailController.text.toString(),
                                    sidController.text.toString(),
                                    pController.text.toString(),
                                    passwordController.text.toString());

                                Profile currentProfile = await AccountHandler
                                    .accountHandler
                                    .getUser(emailController.text.toString());
                                context.read<AccountHandler>().setProfile =
                                    Profile(
                                        fnameController.text.toString(),
                                        lnameController.text.toString(),
                                        emailController.text.toString(),
                                        sidController.text.toString(),
                                        pController.text.toString(),
                                        passwordController.text.toString());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => DashboardPage()));
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Welcome')),
                              );
                            }
                          }
                        },
                        child: Text('Register',
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
                  ],
                ),
              ]),
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Page to recover account password if needed
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
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
              child: Column(
                children: [
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
                      title: Text(" Forgot Your Password?",
                          style: GoogleFonts.playfairDisplay(
                            fontStyle: FontStyle.normal,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      subtitle: const Text("  Please enter your email below")),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Center(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required Field';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              hintText: 'john.kennedy@ontariotechu.net'),
                        ),
                      )),
                  Container(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Reset Instructions Sent')),
                          );
                        }
                      },
                      child: Text('Reset Password',
                          style: GoogleFonts.playfairDisplay(
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            )));
  }
}

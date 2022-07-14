import 'package:flutter/material.dart';
import 'account_handler.dart';
import 'profile.dart';
import 'package:provider/src/provider.dart';
import 'package:park_share/Dashboard/dashboard.dart';

//account details page shows all user information that they can edit
class AccountDetailsPage extends StatefulWidget {
  final Profile? profile;
  const AccountDetailsPage({Key? key, this.profile}) : super(key: key);

  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController sidController = TextEditingController();
  TextEditingController pController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AccountHandler accountHandler = context.watch<AccountHandler>();
    emailController.text = accountHandler.getProfile!.getEmail();
    fnameController.text = accountHandler.getProfile!.getFirstName();
    lnameController.text = accountHandler.getProfile!.getLastName();
    passwordController.text = accountHandler.getProfile!.getPassword();
    pController.text = accountHandler.getProfile!.getPhoneNumber();
    sidController.text = accountHandler.getProfile!.getSid();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Account Details"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(children: [
            Column(
              children: <Widget>[
                Image.asset(
                  'images/profile.png',
                  height: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Edit Email'),
                        content: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required Field';
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              hintText: 'john.kennedy@ontariotechu.net'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    readOnly: true,
                    controller: emailController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.edit),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'john.kennedy@ontariotechu.net'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
                  child: TextFormField(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Edit Student ID'),
                        content: TextFormField(
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
                              labelText: 'Student Number',
                              hintText: '100123456'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    controller: sidController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.edit),
                        border: OutlineInputBorder(),
                        labelText: 'Student Number',
                        hintText: '100123456'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
                  child: TextFormField(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Edit Phone Number'),
                        content: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required Field';
                            }
                            if (value.length != 9) {
                              return 'Please enter 10 numerical digits';
                            }
                            return null;
                          },
                          controller: pController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone Number',
                              hintText: '4161234567'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    controller: pController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.edit),
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                        hintText: '4161234567'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15, bottom: 0),
                  child: TextFormField(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Edit First Name'),
                        content: TextFormField(
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
                              hintText: 'John'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    controller: fnameController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.edit),
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                        hintText: 'John'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15, bottom: 0),
                  child: TextFormField(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Edit Last Name'),
                        content: TextFormField(
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
                              hintText: 'Doe'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    controller: lnameController,
                    readOnly: true,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.edit),
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                        hintText: 'Doe'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15, bottom: 20),
                  child: TextFormField(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Edit Password'),
                        content: TextFormField(
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
                              labelText: 'Password',
                              hintText: 'Enter Password'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    controller: passwordController,
                    readOnly: true,
                    obscureText: true,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.edit),
                        border: OutlineInputBorder(),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Saved')),
                        );

                        await AccountHandler.accountHandler.updateUser(
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
                            currentProfile;

                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardPage(),
                              ));
                        });
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ]),
        ));
  }
}

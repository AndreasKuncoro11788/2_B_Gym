import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home.dart';
import 'package:flutter_application_1/view/register.dart';
import 'package:flutter_application_1/component/form_component.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Map? dataForm = widget.data;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return "Username cannot be empty";
                }
                return null;
              },
                  controller: usernameController,
                  hintTxt: "Username",
                  helperTxt: "Enter the registered user",
                  iconData: Icons.person),
              
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return "Password Empty";
                }
                return null;
              },
                  password: true,
                  controller: passwordController,
                  hintTxt: "Password",
                  helperTxt: "Enter the Password",
                  iconData: Icons.password),
                  
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (dataForm!['username'] == usernameController.text &&
                            dataForm['password'] == passwordController.text) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeView()));
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Wrong Password'),
                              content: ElevatedButton(
                                onPressed: () => pushRegister(context),
                                child: const Text('Sign Up Here !!')),
                              actions: <Widget>[ 
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                  ElevatedButton(  // Ubah di sini
                    onPressed: () {
                      pushRegister(context);
                    },
                    child: const Text('Don\'t have an account?'), // Ubah menjadi ElevatedButton
                  ),
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Forgot Password'),
                        content: dataForm != null
                            ? Text('Username: ${dataForm['username']}\nPassword: ${dataForm['password']}')
                            : const Text('No data registered.'),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterView()),
    );
  }
}

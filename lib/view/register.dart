import 'package:flutter/material.dart';
import 'package:2_B_Gym/View/login.dart';
import 'package:2_B_Gym/component/form_component.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'First name cannot be empty';
                      }
                      return null;
                    },
                    controller: firstNameController,
                    hintTxt: 'First Name',
                    helperTxt: 'Bow',
                    iconData: Icons.person),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Last name cannot be empty';
                      }
                      return null;
                    },
                    controller: lastNameController,
                    hintTxt: 'Last Name',
                    helperTxt: 'ty',
                    iconData: Icons.person),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Username cannot be empty';
                      }
                      if (p0.toLowerCase() == 'anjing') {
                        return 'Tidak boleh menggunakan kata kasar';
                      }
                      return null;
                    },
                    controller: usernameController,
                    hintTxt: 'Username',
                    helperTxt: 'Bowtyla',
                    iconData: Icons.person),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      if (!p0.contains('@')) {
                        return 'Must consist @';
                      }
                      return null;
                    },
                    controller: emailController,
                    hintTxt: 'Email',
                    helperTxt: 'bowt@gmail.com',
                    iconData: Icons.email),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if (p0.length < 8) {
                        return 'Min. 8 digit';
                      }
                      return null;
                    },
                    controller: passwordController,
                    hintTxt: 'Password',
                    helperTxt: '12345678',
                    iconData: Icons.password,
                    password: true),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Confirm password cannot be empty';
                      }
                      if (p0 != passwordController.text) {
                        return 'Wrong Password';
                      }
                      return null;
                    },
                    controller: confirmPasswordController,
                    hintTxt: 'Confirm Password',
                    helperTxt: '12345678',
                    iconData: Icons.password,
                    password: true),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Phone cannot be empty';
                      }
                      return null;
                    },
                    controller: phoneController,
                    hintTxt: 'Phone',
                    helperTxt: '08211223344',
                    iconData: Icons.phone_android),
                  

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> formData = {};
                        formData['firstName'] = firstNameController.text;
                        formData['lastName'] = lastNameController.text;
                        formData['username'] = usernameController.text;
                        formData['email'] = emailController.text;
                        formData['password'] = passwordController.text;
                        formData['phone'] = phoneController.text;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LoginView(data: formData),
                          ),
                        );
                      }
                    },
                    child: const Text('Register'),
                  ),
    
                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
             
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginView(),
                        ),
                      );
                    },
                    child: const Text('Have an account? Back to Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

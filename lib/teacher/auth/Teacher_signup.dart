import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../homepage.dart';
import '../../authmethods.dart';
import '../../widgets/text_input_field.dart';
import '../screens/teacher_home.dart';

class TeacherSignupScreen extends StatefulWidget {
  const TeacherSignupScreen({Key? key}) : super(key: key);

  @override
  _TeacherSignupScreenState createState() => _TeacherSignupScreenState();
}

class _TeacherSignupScreenState extends State<TeacherSignupScreen> {
  final TextEditingController _name= TextEditingController();
  final TextEditingController _enoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  bool _isLoading = false;


  @override
  void dispose() {
    super.dispose();
    _enoController.dispose();
    _passwordController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().teacher_signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        name:_name.text,
      eno: _enoController.text

    );
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => TeacherHomePage()),


      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Text(
                'Relax \nDear Teachers',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.red,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'Signup',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 45),
              TextInputField(controller: _name, labelText: 'enter your good name', icon: Icons.person,  ),

              const SizedBox(
                height: 24,
              ),
              TextInputField(
                 labelText: 'enter your employee no',
                controller: _enoController,
                icon: Icons.school,
              ),
              const SizedBox(
                height: 24,
              ),
              TextInputField(
                labelText: 'enter your email',
                controller: _emailController,
                icon: Icons.mail_rounded,
              ),
              const SizedBox(
                height: 24,
              ),
              passFieldInput(
                hintText: 'enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,

              ),
              const SizedBox(
                height: 24,
              ),

              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: Colors.blue,
                  ),
                  child: !_isLoading
                      ? const Text(
                    'Sign up',
                  )
                      : const CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'Already have an account?',
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      child: const Text(
                        ' Login.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
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

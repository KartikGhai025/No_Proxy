import 'package:flutter/material.dart';
import '../../authmethods.dart';
import '../../widgets/text_input_field.dart';
import '../screens/teacher_home.dart';

class TeacherSignupScreen extends StatefulWidget {
  const TeacherSignupScreen({Key? key}) : super(key: key);

  @override
  _TeacherSignupScreenState createState() => _TeacherSignupScreenState();
}

class _TeacherSignupScreenState extends State<TeacherSignupScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _enoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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


    String res = await AuthMethods().teacher_signUpUser(

        password: _passwordController.text,
        name: _name.text,
        eno: _enoController.text);
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TeacherHomePage(_enoController.text)),
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
      // backgroundColor: Colors.black54,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                'Relax, \nDear Teachers',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.red,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'Signup',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 55),
              TextInputField(
                controller: _name,
                labelText: 'enter your good name',
                icon: Icons.person,
              ),
              const SizedBox(
                height: 10,
              ),
              EmpInputField(
                labelText: 'enter your employee no',
                controller: _enoController,
                icon: Icons.school,
              ),
              const SizedBox(
                height: 10,
              ),

              PassFieldInput(
                hintText: 'enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
              ),

              const SizedBox(
                height: 40,
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
                    color: Colors.red,
                  ),
                  child: !_isLoading
                      ? const Text(
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    'Sign Up',
                  )
                      : const CircularProgressIndicator(
                          color: Colors.red,
                        ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      style: TextStyle(
                          // fontSize: 20,
                          color: Colors.black),
                      'Already have an account?',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Login.',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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

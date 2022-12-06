import 'package:fair_attendance/student/homescreens/home.dart';
import 'package:flutter/material.dart';
import '../../widgets/text_input_field.dart';
import '../../authmethods.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _name= TextEditingController();
  final TextEditingController _sem= TextEditingController();
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

    setState(() {
      _isLoading = true;
    });


    String res = await AuthMethods().signUpUser(
        eno: _enoController.text,
        password: _passwordController.text,
      name:_name.text,
   //   sem:  _sem.text
         );
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => HomePage(_enoController.text)),


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
                'Now, \nNo Proxy',
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
              const SizedBox(
                height: 24,
              ),
              TextInputField(controller: _name, labelText: 'enter your name', icon: Icons.person,  ),
              const SizedBox(
                height: 10,
              ),

              EnInputField(
                labelText: 'Enter your eno',
                icon: Icons.numbers,
                controller: _enoController,
              ),
              const SizedBox(
                height: 10,
              ),
              PassFieldInput(
                hintText: 'Enter your password',
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
                    color: Colors.red,
                  ),
                  child: !_isLoading
                      ? Text(
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    'Sign Up',
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      style: TextStyle(

                          color: Colors.black
                      ),
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
                          fontSize: 20,
                          color: Colors.red,
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

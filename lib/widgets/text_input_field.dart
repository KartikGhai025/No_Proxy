import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  final IconData icon;

  const TextInputField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      controller: controller,
      decoration: InputDecoration(
       // focusColor: Colors.white,
        fillColor: Colors.red,
        labelText: labelText,
        prefixIcon: Icon(
          icon,
          color: Colors.red,
        ),
        labelStyle: const TextStyle(
         // color: Colors.red,
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.blue,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.blue,
            )),
      ),
    );
  }
}


class EnInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  final IconData icon;

  const EnInputField(
      {Key? key,
        required this.controller,
        required this.labelText,
        required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 7,
      textAlign: TextAlign.center,
      controller: controller,
      decoration: InputDecoration(
        // focusColor: Colors.white,
        fillColor: Colors.red,
        labelText: labelText,
        prefixIcon: Icon(
          icon,
          color: Colors.red,
        ),
        labelStyle: const TextStyle(
          // color: Colors.red,
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.blue,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.blue,
            )),
      ),
    );
  }
}


class EmpInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  final IconData icon;

  const EmpInputField(
      {Key? key,
        required this.controller,
        required this.labelText,
        required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 5,
      textAlign: TextAlign.center,
      controller: controller,
      decoration: InputDecoration(
        // focusColor: Colors.white,
        fillColor: Colors.red,
        labelText: labelText,
        prefixIcon: Icon(
          icon,
          color: Colors.red,
        ),
        labelStyle: const TextStyle(
          // color: Colors.red,
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.blue,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.blue,
            )),
      ),
    );
  }
}


class PassFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  const PassFieldInput({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return TextField(
      // maxLength: 7,
      controller: textEditingController,
      decoration: InputDecoration(
        // fillColor: Colors.white,
        //  suffixIconColor: Colors.white,
        labelText: "enter password",
        prefixIcon: const Icon(
          Icons.security,
          color: Colors.red,
        ),
        labelStyle: const TextStyle(
          //color: Colors.blue,
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.blue,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
         ),
      ),
      keyboardType: textInputType,
      obscureText: true,
    );
  }
}

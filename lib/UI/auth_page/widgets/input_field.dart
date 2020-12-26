import 'package:flutter/material.dart';
import 'package:integral_admin/services/responsive_size.dart';

class InputField extends StatefulWidget {
  final String hint;
  final Widget suffixIcon;
  final Function suffixAction;

  InputField({this.hint, this.suffixIcon, this.suffixAction});

  InputField.emailField()
      : hint = 'Email',
        suffixIcon = Icon(Icons.mail),
        suffixAction = null;

  InputField.passwordField()
      : hint = 'Пароль',
        suffixIcon = Icon(Icons.lock),
        suffixAction = null;

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.width(15),
          vertical: ResponsiveSize.height(ResponsiveSize.height(5))),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: widget.hint,
          suffixIcon: GestureDetector(
              onTap: widget.suffixAction, child: widget.suffixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

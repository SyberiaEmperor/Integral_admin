import 'package:flutter/material.dart';
import 'package:integral_admin/services/responsive_size.dart';

class InputField extends StatefulWidget {
  final String hint;
  final Widget suffixIcon;
  final bool isPassword;
  final TextEditingController controller;

  InputField(this.controller,
      {this.hint, this.suffixIcon, this.isPassword = false});

  InputField.emailField(this.controller)
      : hint = 'Email',
        suffixIcon = Icon(Icons.mail),
        isPassword = false;

  InputField.passwordField(this.controller)
      : hint = 'Пароль',
        suffixIcon = Icon(Icons.visibility),
        isPassword = true;

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool passwordVisible;
  Function suffixAction;

  @override
  void initState() {
    passwordVisible = !widget.isPassword;
    if (widget.isPassword) {
      suffixAction = () {
        passwordVisible = !passwordVisible;
        setState(() {});
      };
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.width(15),
          vertical: ResponsiveSize.height(ResponsiveSize.height(5))),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: Color(0xddFA7022),
          primaryColor: Color(0xddFA7022),
        ),
        child: TextFormField(
          controller: widget.controller,
          obscureText: !passwordVisible,
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixIcon: GestureDetector(
                onTap: suffixAction,
                child: widget.isPassword
                    ? (passwordVisible
                        ? widget.suffixIcon
                        : Icon(Icons.visibility_off))
                    : widget.suffixIcon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

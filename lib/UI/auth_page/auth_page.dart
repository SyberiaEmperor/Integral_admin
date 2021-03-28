import 'package:flutter/material.dart';
import 'package:integral_admin/UI/auth_page/widgets/auth_title.dart';
import 'package:integral_admin/UI/auth_page/widgets/input_field.dart';
import 'package:integral_admin/blocs/auth_bloc/auth_bloc.dart';
import 'package:integral_admin/services/responsive_size.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthTitle(),
              InputField.emailField(email),
              InputField.passwordField(password),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    width: ResponsiveSize.width(100),
                    height: ResponsiveSize.height(50),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius:
                            BorderRadius.circular(ResponsiveSize.height(10))),
                    child: Text(
                      'Войти',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

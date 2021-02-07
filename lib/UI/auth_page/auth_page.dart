import 'package:flutter/material.dart';
import 'package:integral_admin/UI/auth_page/widgets/auth_title.dart';
import 'package:integral_admin/UI/auth_page/widgets/input_field.dart';
import 'package:integral_admin/UI/default_pages/loading_page.dart';
import 'package:integral_admin/UI/default_pages/warning_snackbar.dart';
import 'package:integral_admin/UI/main_page/main_page.dart';
import 'package:integral_admin/blocs/auth_bloc/auth_bloc.dart';
import 'package:integral_admin/blocs/main_page_bloc/mainpage_bloc.dart';
import 'package:integral_admin/entities/test_dish_controller.dart';
import 'package:integral_admin/services/responsive_size.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _mapToStateListener(BuildContext context, AuthState state) {
      if (state is AuthErrorState) {
        bottomWarningBar(context, state.caption);
      }
      if (state is AuthLoggedInState) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) =>
                          MainPageBloc(dishController: TestDishController()),
                      child: MainPage(),
                    )));
      }
    }

    Widget _mapToStateBuilder(BuildContext context, AuthState state) {
      if (state is AuthMainState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthTitle(),
            InputField.emailField(email),
            InputField.passwordField(password),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(AuthLogInEvent(
                      login: email.text, password: password.text));
                },
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
                        .bodyText2
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      }
      if (state is AuthInProgressState) {
        return LoadingPage(caption: 'Получение данных');
      }
      return Container();
    }

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: _mapToStateListener,
        builder: _mapToStateBuilder,
      ),
    );
  }
}

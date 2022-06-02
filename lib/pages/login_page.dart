import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wallet_uwu/api/auth_api.dart';
import 'package:wallet_uwu/common/theme_helper.dart';
import 'package:wallet_uwu/models/auth_model.dart';
import 'package:wallet_uwu/provider/refresh_token.dart';
import 'package:wallet_uwu/utils/validation.dart';

import 'forgot_password_page.dart';
import 'registration_page.dart';
import '/widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Widget inputUsernameForm() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: TextFormField(
        controller: username,
        validator: (val) => uValidator(value: val, isRequire: true),
        decoration: ThemeHelper().textInputDecoration('Username'),
        style: const TextStyle(fontFamily: "Poppins"),
      ),
      decoration: ThemeHelper().inputBoxDecorationShadow(),
    );
  }

  Widget inputPasswordForm() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: TextFormField(
        obscureText: true,
        controller: password,
        validator: (val) => uValidator(value: val, isRequire: true),
        decoration: ThemeHelper().textInputDecoration('Password'),
        style: const TextStyle(fontFamily: "Poppins"),
      ),
      decoration: ThemeHelper().inputBoxDecorationShadow(),
    );
  }

  Widget buttonSubmit() {
    return Container(
      width: double.infinity,
      decoration: ThemeHelper().buttonBoxDecoration(context),
      child: ElevatedButton(
        style: ThemeHelper().buttonStyle(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
          child: Text(
            'Sign In'.toUpperCase(),
            style: const TextStyle(
                fontSize: 18,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        onPressed: () {
          formSubmitted();
        },
      ),
    );
  }

  Widget forgotPassword() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ForgotPasswordPage(),
            ),
          );
        },
        child: const Text(
          "Forgot your password?",
          style: TextStyle(color: Colors.grey, fontFamily: "Poppins"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: _headerHeight,
                child: HeaderWidget(
                  _headerHeight,
                  true,
                  Icons.login_rounded,
                ),
              ),
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Login',
                        style: TextStyle(fontSize: 55, fontFamily: "Poppins"),
                      ),
                      const Text(
                        'Silahkan login dengan akun anda',
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Poppins",
                            fontSize: 16),
                      ),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              inputUsernameForm(),
                              inputPasswordForm(),
                              forgotPassword(),
                              buttonSubmit(),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: "Dont have an account ? ",
                                          style:
                                              TextStyle(fontFamily: "Poppins")),
                                      TextSpan(
                                        text: 'Create',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegistrationPage(),
                                              ),
                                            );
                                          },
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Poppins",
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void formSubmitted() async {
    // final sss = Provider.of<RefreshTokenProvider>(context).refreshingToken;
    if (_formKey.currentState!.validate()) {
      await AuthApi().authLogin(username.text, password.text).then((value) => {
            if (value.statusCode == 200)
              {Navigator.of(context).pushNamed('/provider')}
            else
              {
                Fluttertoast.showToast(
                    msg: 'Username dan Password Salah',
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.black54)
              }
          });
    }
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallet_uwu/api/auth_api.dart';
import 'package:wallet_uwu/common/theme_helper.dart';
import 'package:wallet_uwu/utils/validation.dart';

import '/widgets/header_primary_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();

  Widget inputEmailForm() {
    return Container(
      child: TextFormField(
        controller: email,
        keyboardType: TextInputType.emailAddress,
        decoration:
            ThemeHelper().textInputDecoration("Email", "Enter your email"),
        validator: (val) => uValidator(value: val, isEmail: true),
        style: const TextStyle(fontFamily: "Poppins"),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: ThemeHelper().inputBoxDecorationShadow(),
    );
  }

  Widget buttonSubmit() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 15),
      decoration: ThemeHelper().buttonBoxDecoration(context),
      child: ElevatedButton(
        style: ThemeHelper().buttonStyle(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: Text(
            "Send".toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              color: Colors.white,
            ),
          ),
        ),
        onPressed: () {
          formSubmitted();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: _headerHeight,
                child:
                    HeaderPrimaryWidget(_headerHeight, true, Icons.password_rounded),
              ),
              SafeArea(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontSize: 38,
                                  fontFamily: "Poppins",
                                  color: Colors.black54),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                'We will email you a verification code to check your authenticity.',
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontFamily: "Poppins"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              inputEmailForm(),
                              buttonSubmit()
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Remember your password? ",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black87),
                              ),
                              TextSpan(
                                text: 'Login',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                  },
                                style: const TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void formSubmitted() async {
    if (_formKey.currentState!.validate()) {
      try {
        final res = await AuthApi().forgotPassword(email.text);
        if (res.statusCode == 200) {
          Navigator.of(context).pushReplacementNamed('/forgot_verify',
              arguments: res.verifyToken);
        } else {
          Fluttertoast.showToast(
            msg: res.message,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.black54,
          );
        }
      } catch (err) {
        Fluttertoast.showToast(
          msg: "Tidak bisa terkoneksi dengan server",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black54,
        );
      }
    }
  }
}

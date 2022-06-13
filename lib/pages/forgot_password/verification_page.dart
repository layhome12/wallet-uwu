import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../api/auth_api.dart';
import '/widgets/header_primary_widget.dart';

class ForgotVerificationPage extends StatefulWidget {
  const ForgotVerificationPage({Key? key}) : super(key: key);

  @override
  _ForgotVerificationPageState createState() => _ForgotVerificationPageState();
}

class _ForgotVerificationPageState extends State<ForgotVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child:
                  HeaderPrimaryWidget(_headerHeight, true, Icons.privacy_tip_outlined),
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
                            'Verification',
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: "Poppins",
                                color: Colors.black54),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Enter the verification code we just sent you on your email address.',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: (isLoading)
                                  ? const CircularProgressIndicator(
                                      color: Colors.purple,
                                    )
                                  : OTPTextField(
                                      length: 4,
                                      obscureText: true,
                                      width: 300,
                                      fieldWidth: 50,
                                      style: const TextStyle(
                                          fontSize: 30, fontFamily: "Poppins"),
                                      textFieldAlignment:
                                          MainAxisAlignment.spaceAround,
                                      fieldStyle: FieldStyle.underline,
                                      onCompleted: (pin) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        submittedForm(pin.toString());
                                      },
                                      onChanged: (pin) {},
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "If you didn't receive a code! ",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.black38,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Resend',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      style: const TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange),
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
            )
          ],
        ),
      ),
    );
  }

  void submittedForm(String otpCode) async {
    final token = ModalRoute.of(context)?.settings.arguments.toString();

    try {
      final response = await AuthApi().verifyPasswordOtp(otpCode, token!);
      if (response.statusCode == 200) {
        Timer(const Duration(milliseconds: 2000), () {
          Navigator.of(context).pushReplacementNamed(
            '/reset_password',
            arguments: response.pwdReset,
          );
        });
      } else {
        Timer(const Duration(milliseconds: 2000), () {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
            msg: response.message,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.black54,
          );
        });
      }
    } catch (err) {
      Timer(const Duration(milliseconds: 2000), () {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
          msg: "Tidak bisa terhubung server",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black54,
        );
      });
    }
  }
}

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:wallet_uwu/api/register_api.dart';
import 'package:wallet_uwu/models/register_model.dart';
import '/widgets/header_widget.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _formKey = GlobalKey<FormState>();
  late bool _isLoading = false;

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
                  HeaderWidget(_headerHeight, true, Icons.privacy_tip_outlined),
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
                            // textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Enter the verification code we just sent you on your email address.',
                            style: TextStyle(
                                fontFamily: "Poppins", color: Colors.black54),
                            // textAlign: TextAlign.center,
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
                              child: (_isLoading)
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
                                          _isLoading = true;
                                        });
                                        formSubmitted(pin.toString());
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

  void formSubmitted(String? otpCode) async {
    final verifyToken = ModalRoute.of(context)?.settings.arguments as String;

    await RegisterApi().verifikasiAkun(verifyToken, otpCode!).then((value) => {
          if (value.statusCode.toString() == '200')
            {
              Timer(const Duration(milliseconds: 2000), () {
                Navigator.of(context).popAndPushNamed('/register');
                Fluttertoast.showToast(
                    msg: 'Verifikasi Berhasil Silahkan Login Kembali',
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.black54);
              }),
            }
          else
            {
              Timer(const Duration(milliseconds: 2000), () {
                setState(() {
                  _isLoading =
                      false; // Now it is showing fade effect and navigating to Login page
                });
                Fluttertoast.showToast(
                    msg: 'Verifikasi Kode Gagal, Kode Tidak Cocok',
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.black54);
              })
            }
        });
  }
}

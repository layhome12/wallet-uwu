import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallet_uwu/api/auth_api.dart';

import '../../common/theme_helper.dart';
import '../../utils/validation.dart';
import '../../widgets/header_primary_widget.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();

  Widget inputPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: password,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: ThemeHelper()
            .textInputDecoration("New Password", "Enter your new password"),
        validator: (val) =>
            uValidator(value: val, isRequire: true, match: confirm.text),
        style: const TextStyle(fontFamily: "Poppins"),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: ThemeHelper().inputBoxDecorationShadow(),
    );
  }

  Widget inputConfirmPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: confirm,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: ThemeHelper().textInputDecoration(
            "Confirm Password", "Enter your confirm password"),
        validator: (val) =>
            uValidator(value: val, isRequire: true, match: password.text),
        style: const TextStyle(fontFamily: "Poppins"),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: ThemeHelper().inputBoxDecorationShadow(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pwdReset = ModalRoute.of(context)?.settings.arguments.toString();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 300,
                child: HeaderPrimaryWidget(300, true, Icons.privacy_tip_outlined),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        children: const [
                          Text(
                            'Reset Password',
                            style: TextStyle(
                                fontSize: 39,
                                fontFamily: "Poppins",
                                color: Colors.black54),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Enter your new password to reset password',
                              style: TextStyle(
                                  color: Colors.black38, fontFamily: "Poppins"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            inputPassword(),
                            inputConfirmPassword(),
                            Container(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 20, left: 15),
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      "Reset".toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    formSubmitted(pwdReset!);
                                  },
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void formSubmitted(String token) async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await AuthApi().resetPassword(token, password.text);
        if (response.statusCode == 200) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
            msg: response.message,
            backgroundColor: Colors.black54,
          );
        } else {
          Fluttertoast.showToast(
            msg: response.message,
            backgroundColor: Colors.black54,
          );
        }
      } catch (err) {
        Fluttertoast.showToast(
          msg: "Tidak bisa terhubung server",
          backgroundColor: Colors.black54,
        );
      }
    }
  }
}

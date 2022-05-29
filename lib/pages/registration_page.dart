import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallet_uwu/api/register_api.dart';
import 'package:wallet_uwu/common/theme_helper.dart';
import 'package:wallet_uwu/pages/verification_page.dart';
import 'package:wallet_uwu/utils/validation.dart';
import 'package:wallet_uwu/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lasName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  Widget inputNameForm() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
            child: TextFormField(
              controller: firstName,
              style: const TextStyle(fontFamily: "Poppins"),
              decoration: ThemeHelper().textInputDecoration('First Name'),
              validator: (val) => uValidator(value: val, isRequire: true),
            ),
            decoration: ThemeHelper().inputBoxDecorationShadow(),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            child: TextFormField(
                controller: lasName,
                style: const TextStyle(fontFamily: "Poppins"),
                decoration: ThemeHelper().textInputDecoration('Last Name'),
                validator: (val) => uValidator(value: val, isRequire: true)),
            decoration: ThemeHelper().inputBoxDecorationShadow(),
          ),
        )
      ],
    );
  }

  Widget inputEmailForm() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: email,
        style: const TextStyle(fontFamily: "Poppins"),
        decoration: ThemeHelper().textInputDecoration("E-mail address"),
        keyboardType: TextInputType.emailAddress,
        validator: (val) => uValidator(value: val, isEmail: true),
      ),
      decoration: ThemeHelper().inputBoxDecorationShadow(),
    );
  }

  Widget inputUsernameForm() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: username,
        style: const TextStyle(fontFamily: "Poppins"),
        decoration: ThemeHelper().textInputDecoration("Username"),
        keyboardType: TextInputType.name,
        validator: (val) => uValidator(value: val, isRequire: true),
      ),
      decoration: ThemeHelper().inputBoxDecorationShadow(),
    );
  }

  Widget inputPhoneNumberForm() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
          controller: phoneNumber,
          style: const TextStyle(fontFamily: "Poppins"),
          decoration: ThemeHelper().textInputDecoration("Mobile Number"),
          keyboardType: TextInputType.phone,
          validator: (val) => uValidator(value: val, isRequire: true)),
      decoration: ThemeHelper().inputBoxDecorationShadow(),
    );
  }

  Widget inputPasswordForm() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        obscureText: true,
        controller: password,
        style: const TextStyle(fontFamily: "Poppins"),
        decoration: ThemeHelper().textInputDecoration("Password"),
        validator: (val) => uValidator(value: val, isRequire: true),
      ),
      decoration: ThemeHelper().inputBoxDecorationShadow(),
    );
  }

  Widget btnSubmit() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      width: double.infinity,
      decoration: ThemeHelper().buttonBoxDecoration(context),
      child: ElevatedButton(
        style: ThemeHelper().buttonStyle(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: Text(
            "Register".toUpperCase(),
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Poppins"),
          ),
        ),
        onPressed: () {
          FocusScope.of(context).unfocus();
          formSubmitted();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              const SizedBox(
                height: 250,
                child: HeaderWidget(220, true, Icons.person_add_alt_1_rounded),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 265, 25, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          inputNameForm(),
                          inputUsernameForm(),
                          inputEmailForm(),
                          inputPhoneNumberForm(),
                          inputPasswordForm(),
                          btnSubmit(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Expanded(child: Divider()),
                          Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: const Text(
                              "Ikuti sosial media kami",
                              style: TextStyle(
                                  color: Colors.grey, fontFamily: "Poppins"),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150),
                                border: Border.all(
                                    width: 5, color: HexColor("#d31d1d")),
                                color: HexColor("#d31d1d"),
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.google,
                                size: 20,
                                color: HexColor("#FFFFFF"),
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150),
                                border: Border.all(
                                    width: 5, color: HexColor("#40ABF0")),
                                color: HexColor("#40ABF0"),
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.twitter,
                                size: 20,
                                color: HexColor("#FFFFFF"),
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150),
                                border: Border.all(
                                    width: 5, color: HexColor("#1a0dab")),
                                color: HexColor("#1a0dab"),
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.facebookMessenger,
                                size: 20,
                                color: HexColor("#FFFFFF"),
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
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

  void formSubmitted() async {
    if (_formKey.currentState!.validate()) {
      try {
        await RegisterApi()
            .registerSave(firstName.text, lasName.text, username.text,
                email.text, phoneNumber.text, password.text)
            .then((value) => {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerificationPage(
                                register: value,
                              )))
                });
      } catch (err) {
        Fluttertoast.showToast(
            msg: 'Tidak dapat terhubung, Periksa otak anda',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.black54);
      }
    }
  }
}

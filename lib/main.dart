import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:wallet_uwu/pages/login_page.dart';
import 'package:wallet_uwu/pages/providertest.dart';
import 'package:wallet_uwu/pages/registration_page.dart';
import 'package:wallet_uwu/pages/verification_page.dart';
import 'package:wallet_uwu/provider/refresh_token.dart';

import 'pages/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color _primaryColor = HexColor('#DC54FE');
  final Color _accentColor = HexColor('#8A02AE');

  MyApp({Key? key}) : super(key: key);

  // Design color
  // Color _primaryColor= HexColor('#FFC867');
  // Color _accentColor= HexColor('#FF3CBD');

  // Our Logo Color
  // Color _primaryColor= HexColor('#D44CF6');
  // Color _accentColor= HexColor('#5E18C8');

  // Our Logo Blue Color
  //Color _primaryColor= HexColor('#651BD2');
  //Color _accentColor= HexColor('#320181');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RefreshTokenProvider(),
      child: MaterialApp(
        title: 'Flutter Login UI',
        theme: ThemeData(
          primaryColor: _primaryColor,
          accentColor: _accentColor,
          scaffoldBackgroundColor: Colors.grey.shade100,
          primarySwatch: Colors.grey,
        ),
        home: SplashScreen(title: 'Flutter Login UI'),
        initialRoute: '/',
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegistrationPage(),
          '/verify_otp': (context) => const VerificationPage(),
          '/provider': (context) => ProviderTest(),
        },
      ),
    );
  }
}

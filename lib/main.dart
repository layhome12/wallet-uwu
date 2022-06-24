import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:wallet_uwu/pages/main_layout.dart';
import 'package:wallet_uwu/pages/dummy/dummy_page.dart';
import 'package:wallet_uwu/pages/forgot_password/forgot_password_page.dart';
import 'package:wallet_uwu/pages/forgot_password/reset_password_page.dart';
import 'package:wallet_uwu/pages/forgot_password/verification_page.dart';
import 'package:wallet_uwu/pages/login/login_page.dart';
import 'package:wallet_uwu/pages/providertest.dart';
import 'package:wallet_uwu/pages/register/registration_page.dart';
import 'package:wallet_uwu/pages/register/verification_page.dart';
import 'package:wallet_uwu/pages/top_up/success_page.dart';
import 'package:wallet_uwu/pages/top_up/top_up_local.dart';
import 'package:wallet_uwu/pages/wallet/qrcode_page.dart';
import 'package:wallet_uwu/pages/wallet/success_page.dart';
import 'package:wallet_uwu/pages/wallet/transfer_page.dart';
import 'package:wallet_uwu/provider/access_token.dart';
import 'package:wallet_uwu/provider/wallet_ammount.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AccessTokenProvider()),
        ChangeNotifierProvider(create: (context) => WalletAmmountProvider())
      ],
      child: MaterialApp(
        title: 'Kantongku',
        theme: ThemeData(
          primaryColor: _primaryColor,
          accentColor: _accentColor,
          scaffoldBackgroundColor: Colors.grey.shade100,
          primarySwatch: Colors.grey,
        ),
        home: const SplashScreen(title: 'Kantongku'),
        initialRoute: '/',
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegistrationPage(),
          '/verify_otp': (context) => const RegisterVerificationPage(),
          '/forgot_password': (context) => const ForgotPasswordPage(),
          '/forgot_verify': (context) => const ForgotVerificationPage(),
          '/reset_password': (context) => const ResetPasswordPage(),
          '/main_layout': (context) => const MainLayout(),

          // ==> Route Wallet
          '/transfer': (context) => const TransferPage(),
          '/qr_code': (context) => QRCodePage(),
          '/success_transfer': (context) => const SuccessPage(),

          //==> Route Top Up
          '/topup_local': (context) => const TopUpLocalPage(),
          '/topup_success': (context) => const SuccessTopUpPage(),

          // ==> Route Dummy
          '/provider': (context) => ProviderTest(),
          '/dummy': (context) => const DummyPage()
        },
      ),
    );
  }
}

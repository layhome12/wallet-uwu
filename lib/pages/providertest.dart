import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_uwu/models/auth_model.dart';
import 'package:wallet_uwu/provider/refresh_token.dart';

class ProviderTest extends StatelessWidget {
  ProviderTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RefreshTokenProvider>(context).refreshingToken;
    print(provider);
    return Text(provider.toString());
  }
}

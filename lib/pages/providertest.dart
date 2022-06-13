import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_uwu/api/auth_api.dart';
import 'package:wallet_uwu/models/auth_model.dart';
import 'package:wallet_uwu/provider/access_token.dart';

class ProviderTest extends StatelessWidget {
  ProviderTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AccessTokenProvider>(context);
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Consumer<AccessTokenProvider>(
              builder: (context, value, widget) {
                var status = value.tokenAuth.statusCode;
                var message = value.tokenAuth.message;
                var token = value.tokenAuth.tokenAccess;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(status.toString()),
                    Text(message.toString()),
                    Text(token.toString()),
                    ElevatedButton(
                      onPressed: () {
                        provider.updateToken();
                      },
                      child: Text("refresh Token"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/dummy');
                        },
                        child: Text("Data Dummy"))
                  ],
                );
              },
            )),
      ),
    );
  }

  Widget aa(String text) {
    return Text(text);
  }
}

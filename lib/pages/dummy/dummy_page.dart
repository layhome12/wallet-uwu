import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_uwu/api/dummy_api.dart';
import 'package:wallet_uwu/models/dummy_model.dart';
import 'package:wallet_uwu/provider/access_token.dart';

class DummyPage extends StatefulWidget {
  const DummyPage({Key? key}) : super(key: key);

  @override
  State<DummyPage> createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  List<ListData> _dataDummy = [];

  @override
  void initState() {
    refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_dataDummy[index].dummyName),
            );
          },
          itemCount: _dataDummy.length,
        ),
      ),
    );
  }

  Future refreshData() async {
    final provider = Provider.of<AccessTokenProvider>(context, listen: false);
    final datadummy =
        await DummyApi().getDataDummy(provider.tokenAuth.tokenAccess);

    if (datadummy.statusCode != 200) {
      provider.updateToken();
      refreshData();
    }

    setState(() {
      _dataDummy = datadummy.listData;
    });
  }
}

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wallet_uwu/pages/account/account_page.dart';
import 'package:wallet_uwu/pages/dashboard/dashboard_page.dart';
import 'package:wallet_uwu/pages/history/history_page.dart';
import 'package:wallet_uwu/pages/top_up/top_up_page.dart';
import 'package:wallet_uwu/pages/wallet/wallet_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  final List<Widget> pageList = [
    const TopUpPage(),
    const WalletPage(),
    const DashboardPage(),
    const HistoryPage(),
    const AccountPage()
  ];
  Widget pageActive = const DashboardPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageStorage(
        bucket: pageStorageBucket,
        child: pageActive,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.purple.shade500,
        color: Colors.deepPurple.shade700,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.add,
              size: 27,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.account_balance_wallet_rounded,
              size: 27,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.home,
              size: 27,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.article_outlined,
              size: 27,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.manage_accounts,
              size: 27,
              color: Colors.white,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            pageActive = pageList[index];
          });
        },
      ),
    );
  }
}

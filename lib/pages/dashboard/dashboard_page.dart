import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wallet_uwu/api/dashboard_api.dart';
import 'package:wallet_uwu/models/carousel_model.dart';
import 'package:wallet_uwu/provider/wallet_ammount.dart';
import 'package:wallet_uwu/widgets/header_secondary_widget.dart';

import '../../models/berita_model.dart';
import '../../provider/access_token.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<CarouselModel> _listItemCarousel = [];
  List<BeritaModel> _listBerita = [];
  int carouselIndex = 0;
  String ammount = "0";

  @override
  void initState() {
    getDataBanner();
    getDataBerita();
    getDataAmmount();
    super.initState();
  }

  Widget cardHeaderNavigation() {
    return Container(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.only(top: 178, left: 20, right: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/topup_local');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.coins,
                    size: 26,
                    color: Colors.deepPurple.shade600,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Text(
                      "Top Up",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/transfer');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.qrcode,
                    size: 26,
                    color: Colors.deepPurple.shade700,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Text(
                      "Transfer",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                print("History");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.history,
                    size: 26,
                    color: Colors.deepPurple.shade700,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Text(
                      "History",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget titleHeader() {
    return Container(
      margin: EdgeInsets.only(top: 35),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Kantongku",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "ReggaeOne",
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              "Cash",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "ReggaeOne",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Rp. ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "ReggaeOne",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ammount,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                  fontFamily: "Digital7",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bannerContent() {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            margin: const EdgeInsets.only(bottom: 3),
            width: double.infinity,
            child: Text(
              "Fitur Baru",
              style: TextStyle(
                fontFamily: "ReggaeOne",
                fontSize: 20,
                color: Colors.deepPurple.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            margin: EdgeInsets.only(bottom: 10),
            width: double.infinity,
            child: const Text(
              "Ayo telusuri hal menarik tentang kami",
              style: TextStyle(fontFamily: "Poppins", fontSize: 13),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.6,
                aspectRatio: 1.0,
                initialPage: 0,
                height: 170,
                autoPlayInterval: const Duration(seconds: 5),
                onPageChanged: (index, value) {
                  setState(() {
                    carouselIndex = index;
                  });
                }),
            items: _listItemCarousel.map((i) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(blurRadius: 5, color: Colors.deepPurple.shade200)
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(i.bannerFile),
                  ),
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: CarouselIndicator(
              count:
                  (_listItemCarousel.isNotEmpty) ? _listItemCarousel.length : 1,
              index: carouselIndex,
              color: Colors.grey.shade400,
              activeColor: Colors.deepPurple,
            ),
          )
        ],
      ),
    );
  }

  Widget listBerita() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          margin: const EdgeInsets.only(bottom: 3),
          width: double.infinity,
          child: Text(
            "Yang Menarik",
            style: TextStyle(
              fontFamily: "ReggaeOne",
              fontSize: 20,
              color: Colors.deepPurple.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          margin: const EdgeInsets.only(bottom: 15),
          width: double.infinity,
          child: const Text(
            "Ayo kenali lebih dekat dengan Kantongku",
            style: TextStyle(fontFamily: "Poppins", fontSize: 13),
          ),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: _listBerita
                .map(
                  (e) => Container(
                    margin: const EdgeInsets.all(10),
                    width: 175,
                    height: 240,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: const [
                        BoxShadow(blurRadius: 10, color: Colors.black12)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  topRight: Radius.circular(13)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(e.beritaImg))),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.beritaNama,
                                style: const TextStyle(
                                  fontFamily: "ReggaeOne",
                                  color: Colors.deepPurple,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  e.beritaIsi.substring(0, 45),
                                  style: const TextStyle(
                                      fontFamily: "Poppins", fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(blurRadius: 15, color: Colors.purple.shade200)
                  ],
                  color: Colors.deepPurple.shade900,
                ),
                height: 220,
                padding: const EdgeInsets.only(bottom: 80),
                child: const HeaderSecondaryWidget(
                  150,
                  false,
                  Icons.login_rounded,
                ),
              ),
              titleHeader(),
              cardHeaderNavigation()
            ],
          ),
          bannerContent(),
          listBerita(),
        ],
      ),
    );
  }

  Future getDataBanner() async {
    final provider = Provider.of<AccessTokenProvider>(context, listen: false);
    try {
      final response =
          await DashboardApi().getBanner(provider.tokenAuth.tokenAccess);
      if (response.statusCode != 200) {
        provider.updateToken();
        getDataBanner();
      }

      setState(() {
        _listItemCarousel = response.listData;
      });
    } catch (err) {
      Fluttertoast.showToast(
          msg: "Tidak Bisa Terhubung Server", backgroundColor: Colors.black87);
    }
  }

  Future getDataBerita() async {
    final provider = Provider.of<AccessTokenProvider>(context, listen: false);
    try {
      final response =
          await DashboardApi().getBerita(provider.tokenAuth.tokenAccess);

      if (response.statusCode != 200) {
        provider.updateToken();
        getDataBerita();
      }

      setState(() {
        _listBerita = response.listData;
      });
    } catch (err) {
      Fluttertoast.showToast(
          msg: "Tidak Bisa Terkoneksi Server", backgroundColor: Colors.black87);
    }
  }

  Future getDataAmmount() async {
    final provider = Provider.of<AccessTokenProvider>(context, listen: false);
    final wallet = Provider.of<WalletAmmountProvider>(context, listen: false);
    try {
      final response =
          await DashboardApi().getAmmount(provider.tokenAuth.tokenAccess);

      if (response.statusCode != 200) {
        provider.updateToken();
        getDataAmmount();
      }

      setState(() {
        ammount = response.walletAmmount;
        wallet.changeSaldo(response.walletAmmount);
      });
    } catch (err) {
      Fluttertoast.showToast(
          msg: "Tidak Bisa Terkoneksi Server", backgroundColor: Colors.black87);
    }
  }
}

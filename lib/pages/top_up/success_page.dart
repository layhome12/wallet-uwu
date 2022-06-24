import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:ticket_widget/ticket_widget.dart';

class SuccessTopUpPage extends StatefulWidget {
  const SuccessTopUpPage({Key? key}) : super(key: key);

  @override
  State<SuccessTopUpPage> createState() => _SuccessTopUpPageState();
}

class _SuccessTopUpPageState extends State<SuccessTopUpPage> {
  @override
  Widget build(BuildContext context) {
    final dataResponse = ModalRoute.of(context)?.settings.arguments;
    Map<String, dynamic> value = json.decode(dataResponse.toString());

    MoneyFormatterOutput nominal =
        MoneyFormatter(amount: value["transaksi_ammount"].toDouble()).output;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text(
          "Rincian Top Up",
          style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context)
              .pushNamedAndRemoveUntil('/main_layout', (route) => false),
        ),
        backgroundColor: Colors.deepPurple,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 60, left: 35, right: 35),
                child: TicketWidget(
                  width: 350,
                  height: 555,
                  isCornerRounded: true,
                  padding: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 65),
                    child: Column(
                      children: [
                        Text(
                          value["transaksi_status_id"] == 2
                              ? "SUCCESS"
                              : "PENDING",
                          style: TextStyle(
                            fontSize: 33,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: value["transaksi_status_id"] == 2
                                ? Colors.green.shade400
                                : Colors.orange.shade300,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Rp. ",
                                style: TextStyle(
                                  fontFamily: "ReggaeOne",
                                  fontSize: 25,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                nominal.nonSymbol
                                    .replaceAll(".00", "")
                                    .replaceAll(",", "."),
                                style: TextStyle(
                                  fontFamily: "Digital7",
                                  fontSize: 60,
                                  color: Colors.grey.shade800,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 92, left: 3, bottom: 30),
                          child: DottedLine(dashColor: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Metode Top Up",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                              Text(
                                "Transfer Local",
                                style: TextStyle(fontFamily: "ReggaeOne"),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: DottedLine(dashColor: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Nominal",
                                  style: TextStyle(fontFamily: "Poppins")),
                              Text(
                                  'Rp. ' +
                                      nominal.nonSymbol
                                          .replaceAll(".00", "")
                                          .replaceAll(",", "."),
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: DottedLine(dashColor: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "No. Transaksi",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                              Text(
                                value["transaksi_code"],
                                style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: DottedLine(dashColor: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Waktu Selesai",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                              Text(
                                value["created_at"]
                                    .toString()
                                    .replaceAll(".000Z", "")
                                    .replaceAll("T", " "),
                                style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: DottedLine(dashColor: Colors.black54),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              width: double.infinity,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: value["transaksi_status_id"] == 2
                            ? Colors.green.shade300
                            : Colors.orange.shade300,
                        width: 6),
                    boxShadow: const [
                      BoxShadow(blurRadius: 10, color: Colors.black12)
                    ]),
                child: Icon(Icons.check_rounded,
                    size: 65,
                    color: value["transaksi_status_id"] == 2
                        ? Colors.green.shade300
                        : Colors.orange.shade300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

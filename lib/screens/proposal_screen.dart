import 'package:SimhegaM/screens/items/sp_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ProposalScreen extends StatelessWidget {
  String uslLb;
  String uslTtp;
  ProposalScreen({Key? key, required this.uslLb, required this.uslTtp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  minLeadingWidth: 0,
                  leading: const SizedBox(
                    height: double.infinity,
                    child: SPIcon(assetName: 'story.png'),
                  ),
                  title: const Text(
                    'Latar Belakang',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  subtitle: Html(data: uslLb),
                ),
              ),
              Divider(),
              Container(
                child: ListTile(
                  minLeadingWidth: 0,
                  leading: const SizedBox(
                    height: double.infinity,
                    child: SPIcon(assetName: 'check.png'),
                  ),
                  title: const Text(
                    'Penutup',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  subtitle: Html(data: uslTtp),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

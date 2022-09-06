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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Latar Belakang',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Html(data: uslLb),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Penutup',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 0.5,
              ),
              Html(data: uslTtp),
            ],
          ),
        ),
      ],
    );
  }
}

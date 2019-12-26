import 'package:flutter/material.dart';
import 'package:triviados/presentation/widgets/PrimaryButton.dart';
import 'package:triviados/presentation/widgets/wave_clippers.dart';

class HomeWidget extends StatelessWidget {
  final Function onStart;

  const HomeWidget({Key key, this.onStart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipper2(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0x22ff3a5a), Color(0x22fe494d)])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper3(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0x44ff3a5a), Color(0x44fe494d)])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper1(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 120,
                      ),
                      Text(
                        "Triviados",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xffff3a5a), Color(0xfffe494d)])),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 130,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                child: PrimaryButton(onPressed: onStart, text: "Start"),
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SizedBox(
              width: double.infinity,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0), side: BorderSide(color: Colors.orange.shade400)),
                child: Text(
                  "Exit",
                  style: TextStyle(color: Colors.orange.shade400, fontWeight: FontWeight.w700, fontSize: 18),
                ),
                onPressed: () {},
              ),
            ),
          ),
          Spacer(),
          Center(
            child: Text(
              "Captain Alvis",
              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

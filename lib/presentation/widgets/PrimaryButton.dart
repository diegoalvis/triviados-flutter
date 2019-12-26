
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {

  final String text;
  final Function onPressed;

  const PrimaryButton({Key key, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return RaisedButton(
      color: Colors.orange.shade400,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:triviados/presentation/widgets/primary_button.dart';

class ResultsPage extends StatelessWidget {
  final int score, totalQuestions;
  final Function() onExitPressed;

  const ResultsPage({Key key, this.score, this.totalQuestions, this.onExitPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = TextStyle(color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w500);
    final TextStyle trailingStyle = TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onExitPressed,
          ),
          backgroundColor: Color(0xffff3a5a),
          title: Text("Results")),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffff3a5a), Color(0xfffe494d)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Total Questions", style: titleStyle),
                  trailing: Text("${totalQuestions}", style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Score", style: titleStyle),
                  trailing: Text("$score%", style: trailingStyle),
                ),
              ),
              SizedBox(height: 48.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PrimaryButton(onPressed: onExitPressed, text: "Goto Home"),
                  Spacer(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

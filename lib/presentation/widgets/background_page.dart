import 'package:flutter/material.dart';
import 'package:triviados/presentation/widgets/wave_clippers.dart';

class BackgroundPage extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const BackgroundPage({Key key, this.backgroundColor = Colors.deepPurple,  @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: WaveClipper2(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            height: 200,
          ),
        ),
        child,
      ],
    );
  }

//  void _nextSubmit() {
//    if (_answers[_currentIndex] == null) {
//      _key.currentState.showSnackBar(SnackBar(
//        content: Text("You must select an answer to continue."),
//      ));
//      return;
//    }
//    if (_currentIndex < (widget.questions.length - 1)) {
//      setState(() {
//        _currentIndex++;
//      });
//    } else {
////      Navigator.of(context).pushReplacement(MaterialPageRoute(
////          builder: (_) => QuizFinishedPage(questions: widget.questions, answers: _answers)
////      ));
//    }
//  }

}

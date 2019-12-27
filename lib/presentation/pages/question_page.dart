import 'package:flutter/material.dart';
import 'package:triviados/domain/entites/trivia.dart';
import 'package:triviados/presentation/widgets/background_page.dart';

class QuestionPage extends StatelessWidget {
  static final TextStyle _questionStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);

  final Trivia trivia;
  final Function(String option) onOptionSelected;
  final Function() onExitPressed;

  QuestionPage({Key key, this.trivia, this.onOptionSelected, this.onExitPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> options = trivia.incorrectAnswers;
    if (!options.contains(trivia.correctAnswer)) {
      options.add(trivia.correctAnswer);
      options.shuffle();
    }

    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onExitPressed,
          ),
          backgroundColor: Color(0xffff3a5a),
          title: Text("Exit")),
      body: BackgroundPage(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 24.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      trivia.question,
                      softWrap: true,
                      style: _questionStyle,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...options.map((option) => Container(
                          color: trivia.optionSelected == null
                              ? Colors.white
                              : option == trivia.correctAnswer ? Colors.lightGreen : Colors.white,
                          child: RadioListTile(
                            title: Text("$option"),
                            value: option,
                            groupValue: trivia.optionSelected,
                            onChanged: (value) {
                              if (trivia.optionSelected == null) {
                                onOptionSelected(value);
                              }
                            },
                          ),
                        ))
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

///can be extracted from another custom widget pages
//  Expanded(
//  child: Container(
//  alignment: Alignment.bottomCenter,
//  child: RaisedButton(
//  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//  color: Theme.of(context).primaryColor,
//  textColor: Colors.white,
//  child: Text(currentIndex == (widget.trivia.length - 1) ? "Submit" : "Next"),
//  onPressed: () {},
//  ),
//  ),
//  )
//  void _nextSubmit() {
//    if (_answers[currentIndex] == null) {
//      _key.currentState.showSnackBar(SnackBar(
//        content: Text("You must select an answer to continue."),
//      ));
//      return;
//    }
//    if (currentIndex < (widget.question.length - 1)) {
//      setState(() {
//        currentIndex++;
//      });
//    } else {
////      Navigator.of(context).pushReplacement(MaterialPageRoute(
////          builder: (_) => QuizFinishedPage(questions: widget.questions, answers: _answers)
////      ));
//    }
//  }
//

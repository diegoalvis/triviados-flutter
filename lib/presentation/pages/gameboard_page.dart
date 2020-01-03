import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triviados/presentation/bloc/gameboard_bloc.dart';
import 'package:triviados/presentation/bloc/gameboard_event.dart';
import 'package:triviados/presentation/bloc/gameboard_state.dart';
import 'package:triviados/presentation/pages/home_page.dart';
import 'package:triviados/presentation/pages/question_page.dart';
import 'package:triviados/presentation/pages/results_page.dart';
import 'package:triviados/presentation/widgets/background_page.dart';
import 'package:triviados/presentation/widgets/primary_button.dart';

class GameBoardPage extends StatefulWidget {
  GameBoardPage({Key key}) : super(key: key);

  @override
  _GameBoardPageState createState() => _GameBoardPageState();
}

class _GameBoardPageState extends State<GameBoardPage> with InjectorWidgetMixin {
  GameBoardBloc _bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    _bloc = GameBoardBloc(injector.get());
    return Scaffold(
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is InitialState) {
            return HomePage(onStart: () => _bloc.add(PlayEvent()));
          }

          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is TriviasLoaded) {
            _bloc.add(NextQuestionEvent());
          }

          if (state is AnswerSelected || state is ShowTrivia) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: QuestionPage(
                      trivia: state.trivia,
                      onExitPressed: () => _showExitGameDialog(() => _bloc.add(ExitGameEvent())),
                      onOptionSelected: (option) => _bloc.add(OptionSelectedEvent(option))),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 48.0),
                  child: PrimaryButton(
                      text: "Next", onPressed: state is AnswerSelected ? () => _bloc.add(NextQuestionEvent()) : null),
                ),
              ],
            );
          }

          if (state is GameFinished) {
            return ResultsPage(
                onExitPressed: () => _bloc.add(ExitGameEvent()), score: state.score, totalQuestions: state.totalQuestions);
          }

          if (state is ErrorState) {
            return BackgroundPage(
              child: Column(
                children: [
                  Spacer(),
                  Expanded(child: Center(child: Text("Somethign went wrong trying to get the game info..."))),
                  Spacer(),
                  Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 48.0),
                          child: PrimaryButton(text: "Go to Home", onPressed: () => _bloc.add(ExitGameEvent()))))
                ],
              ),
            );
          }

          return Center();
        },
      ),
    );
  }

  void _showExitGameDialog(Function onExit) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text("Are you sure you want to exit?\nAll progress so far will be lost."),
            actions: [
              FlatButton(
                child: Text("CLOSE"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                  child: Text("EXIT"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    return onExit();
                  }),
            ],
          );
        });
  }
}

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:triviados/core/network/network_status.dart';
import 'package:triviados/core/result.dart';
import 'package:triviados/data/api/trivia_remote_data_source_impl.dart';
import 'package:triviados/data/local/trivia_local_data_source_impl.dart';
import 'package:triviados/data/repositories/trivia_repository_impl.dart';
import 'package:triviados/domain/entites/trivia.dart';
import 'package:triviados/domain/repositories/trivia_repository.dart';
import 'package:triviados/domain/usecases/get_trivia_list.dart';

class GameBoardPage extends StatefulWidget {
  final String title;

  GameBoardPage({Key key, this.title}) : super(key: key);

  @override
  _GameBoardPageState createState() => _GameBoardPageState();
}

class _GameBoardPageState extends State<GameBoardPage> {
  List<Trivia> triviaList;
  Trivia currentTrivia;

  @override
  void initState() {
    super.initState();
  }

  FutureBuilder buildTriviaList() {
    TriviaRepository repository =
        TriviaRepositoryImpl(NetworkStatus(DataConnectionChecker()), TriviaRemoteDataSourceImpl(), TriviaLocalDataSourceImpl());
    GetTriviaList usecase = GetTriviaList(repository);
    return FutureBuilder(
      future: usecase(),
      builder: (context, repoSnap) {
        if (repoSnap.connectionState == ConnectionState.none || repoSnap.hasData == false) {
          return Center(child: Text("No data"));
        }

        triviaList = (repoSnap.data as Success<List<Trivia>>).data;
        currentTrivia = triviaList.first;

        return Column(
          children: <Widget>[
            Expanded(child: Center(child: Text(currentTrivia.question))),
            Center(child: Text(currentTrivia.correctAnswer)),
            Expanded(
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Center(child: Text(currentTrivia.incorrectAnswers[index]));
                    })),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: buildTriviaList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            int pos = ((triviaList.indexOf(currentTrivia) + 1) % triviaList.length) ?? 0;
            currentTrivia = triviaList[pos];
          });
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

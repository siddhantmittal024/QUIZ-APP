import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io';
import 'package:toast/toast.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(new MaterialApp(
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "/Quizzler": (BuildContext context) => QuizPage()
      }
  ));
}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/q.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:
        Align(
          alignment: Alignment(0.0,0.6),
          child: RaisedButton(
          child: Text(
          "START",
          style: TextStyle(color: Colors.white, fontSize: 30),
      ),
      onPressed: () => (Navigator.of(context).pushNamed("/Quizzler")),
      color: Colors.blue,
      ),
        ),
      ),
    );
  }
  }
class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

List<Icon> scoreKeeper = [];
int c=0,d=0;
void checkAnswer(bool userPickedAnswer)
{
  bool correctAnswer = quizBrain.getQuestionAnswer();
  setState(() {
    if (quizBrain.isFinished() == true) {
      Alert(
      context: context,
      type: AlertType.warning,
      title: "QUIZZLER ALERT",
      desc: "YOU HAVE COME TO THE END OF THE QUIZ",
      buttons: [
        DialogButton(
          child: Text(
            "Score",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: checkScore,
          color: Color.fromRGBO(0, 179, 134, 1.0),

        ),
        DialogButton(
          child: Text(
            "Restart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Exit",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()=> exit(0),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();

    quizBrain.reset();
    scoreKeeper = [];

  }
   else {
      if (userPickedAnswer == correctAnswer) {
      scoreKeeper.add(Icon(
      Icons.check,
      color: Colors.green,
      ));
      c++;
      } else {
      scoreKeeper.add(Icon(
      Icons.close,
      color: Colors.red,
      ));
      }
      quizBrain.nextQuestion();
      }
   d++;
  });

}
void checkScore()
{
  Toast.show("YOUR SCORE IS $c OUT OF $d", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
  d=0;
  c=0;
}
 @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                  quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
    //The user picked false.
    },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: RaisedButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                //The user picked false.
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],


    );
  }
}
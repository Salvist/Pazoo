import 'package:flutter/material.dart';
import 'constants.dart';
import 'game_screen.dart';
import 'results.dart';
import 'character.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safari Puzzle App',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(
                displayColor: kBlackColor,
              ),
          buttonTheme: ButtonThemeData(
              minWidth: 190,
              height: 55,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.black87, width: 3.0)))),
      initialRoute: '/results_screen',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/game_screen': (context) => GameScreen(),
        '/results_screen': (context) => Results()
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Pazoo-Ref.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            Characters(),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 190,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                            colors: [
                              Colors.orangeAccent[100],
                              Colors.orangeAccent
                            ],
                            begin: FractionalOffset.bottomCenter,
                            end: FractionalOffset.topCenter)),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/game_screen');
                      },
                      child: Text('PLAY',
                          style: TextStyle(
                              fontSize: 30, fontFamily: 'ObjectSans')),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    width: 190,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                            colors: [
                              Colors.orangeAccent[100],
                              Colors.orangeAccent
                            ],
                            begin: FractionalOffset.bottomCenter,
                            end: FractionalOffset.topCenter)),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text('HOST',
                          style: TextStyle(
                              fontSize: 30, fontFamily: 'ObjectSans')),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    width: 190,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                            colors: [
                              Colors.orangeAccent[100],
                              Colors.orangeAccent
                            ],
                            begin: FractionalOffset.bottomCenter,
                            end: FractionalOffset.topCenter)),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text('JOIN',
                          style: TextStyle(
                              fontSize: 30, fontFamily: 'ObjectSans')),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
            )
          ],
        ),
      ),
    );
  }
}

class Characters extends StatefulWidget {
  @override
  _CharactersState createState() => _CharactersState();
}

class _CharactersState extends State<Characters> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 150,
      // color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_sharp,
              size: 40.0,
            ),
            onTap: () {
              setState(() {
                if (playerNumber <= 0) {
                  playerNumber = characters.length - 1;
                } else {
                  playerNumber--;
                }
              });
            },
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 3.0)),
              child: Image.asset(characters[playerNumber])),
          GestureDetector(
            child: Icon(Icons.arrow_forward_ios_sharp, size: 40.0),
            onTap: () {
              setState(() {
                if (playerNumber >= characters.length - 1) {
                  playerNumber = 0;
                } else {
                  playerNumber++;
                }
              });
            },
          )
        ],
      ),
    );
  }
}

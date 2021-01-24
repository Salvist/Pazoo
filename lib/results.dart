import 'package:flutter/material.dart';
import 'character.dart';
import 'constants.dart';

class Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Score-BG.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40),
            Container(
              height: 80.0,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('OVERALL TIME',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.blue[900])),
                  SizedBox(height: 5.0),
                  Text(
                    '13:49',
                    style: TextStyle(
                        fontSize: 45.0,
                        fontFamily: 'ObjectSans',
                        color: Colors.blue[900]),
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              height: 80.0,
              width: 310,
              decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(60.0)),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 90,
                    child: Image.asset('assets/Medal-1.png'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2.0)),
                    width: 90,
                    height: 90,
                    child: Image.asset(characters[playerNumber]),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text('Me', style: kDefaultStyle),
                      ),
                      Container(child: Text('03:50', style: kDefaultStyle))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 80.0,
              width: 310,
              decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(60.0)),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 90,
                    child: Image.asset('assets/Medal-2.png'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2.0)),
                    width: 90,
                    height: 90,
                    child: Image.asset(characters[3]),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text('Bob', style: kDefaultStyle),
                      ),
                      Container(child: Text('04:10', style: kDefaultStyle))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 80.0,
              width: 310,
              decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(60.0)),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 90,
                    child: Image.asset('assets/Medal-3.png'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2.0)),
                    width: 90,
                    height: 90,
                    child: Image.asset(characters[1]),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text('Tom', style: kDefaultStyle),
                      ),
                      Container(child: Text('04:32', style: kDefaultStyle))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 80.0,
              width: 310,
              decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(60.0)),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 90,
                    child: Image.asset('assets/Medal-4.png'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2.0)),
                    width: 90,
                    height: 90,
                    child: Image.asset(characters[4]),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text('Don', style: kDefaultStyle),
                      ),
                      Container(child: Text('04:58', style: kDefaultStyle))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 80.0,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 170,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.lightBlueAccent,
                    ),
                    child: FlatButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text('PLAY AGAIN',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'ObjectSans',
                                color: Colors.blue[900])),
                      ),
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.lightBlueAccent,
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text('MENU',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'ObjectSans',
                                color: Colors.blue[900])),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
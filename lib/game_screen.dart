import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'puzzle_piece.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'character.dart';
import 'game_logic.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    gameStart = false;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Welcome to the Game!'),
      //   backgroundColor: Colors.green,
      // ),
      body: SafeArea(
        child: Container(
          color: Color(0xFF6DA6FE),
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top:0,
                  child: Container(
                    color: Color(0xFF4186D8),
                    height: 115.0,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(4.0, 0, 4.0, 4.0),
                            child: Container(
                              child: Image.asset(
                                characters[playerNumber],
                              ),
                              height: 100.0,
                              color: Color(0xFFEBF5FF),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(4.0, 0, 4.0, 4.0),
                            child: Container(
                              child: Image.asset(
                                characters[3],
                              ),
                              height: 100.0,
                              color: Color(0xFFEBF5FF),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(4.0, 0, 4.0, 4.0),
                            child: Container(
                              child: Image.asset(
                                characters[1],
                              ),
                              height: 100.0,
                              color: Color(0xFFEBF5FF),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(4.0, 0, 4.0, 4.0),
                            child: Container(
                              child: Image.asset(
                                characters[4],
                              ),
                              height: 100.0,
                              color: Color(0xFFEBF5FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Positioned(
                left: 25,
                top: 122,
                child: Icon(
                  Icons.timer,
                  size: 33.0,
                  color: Colors.blueGrey[700],
                ),
              ),
              Positioned(
                left: 60,
                top: 126,
                child: Text(
                  '1:00',
                  style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                right: 25,
                top: 126,
                child: Text(
                  'Your turn',
                  style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 74,
                height: MediaQuery.of(context).size.height / 2.07,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 3.0)),

              ),
              Puzzle(),
              /*
              Positioned(
                bottom: 130,
                child: AutoCompleteButton(),
              ),

               */

              Positioned(
                  bottom: 0,
                  child: Container(
                    color: Colors.white,
                    height: 115.0,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          height: 115.0,
                          width: 160.0,
                          color: Colors.red,
                        ),
                        Container(
                          height: 115.0,
                          width: 160.0,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 115.0,
                          width: 160.0,
                          color: Colors.green,
                        ),
                        Container(
                          height: 115.0,
                          width: 160.0,
                          color: Colors.yellow,
                        ),
                        Container(
                          height: 115.0,
                          width: 160.0,
                          color: Colors.pinkAccent,
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class AutoCompleteButton extends StatefulWidget{
  @override
  _AutoCompleteButton createState() => _AutoCompleteButton();
}

class _AutoCompleteButton extends State<AutoCompleteButton>{
  @override
  Widget build(BuildContext context){
    return FlatButton(
      onPressed: (){
        setState((){
          Navigator.pushNamed(context, '/results_screen');
        });

      },
      child: Text('auto complete'),
    );
  }
}

class Puzzle  extends StatefulWidget {
  final int rows = 6;
  final int cols = 5;

  Puzzle({Key key}) : super(key: key);

  @override
  _Puzzle createState() => _Puzzle();
}

class _Puzzle extends State<Puzzle> {
  final List<String> puzzleImage = [
    'Puzzle_Zebra.png',
    'Puzzle_Tiger.png',
    'Puzzle_Lion.png'
  ];

  var rand = new Random();

  File _image;
  List<Widget> pieces = [];

  Future<File> imageToFile() async {
    int imageIndex = rand.nextInt(3);
    var bytes = await rootBundle.load('assets/${puzzleImage[imageIndex]}');
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/${puzzleImage[imageIndex]}');
    await file.writeAsBytes(
      bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes)
    );
    return file;
  }

  File image;

  _setPlaceHolder() async {
    this.image = await imageToFile();
  }
  Future getImage() async {
    await _setPlaceHolder();

    if (image != null) {
      setState(() {
        _image = image;
        pieces.clear();
      });

      splitImage(Image.file(image));
    }
  }

  // we need to find out the image size, to be used in the PuzzlePiece widget
  Future<Size> getImageSize(Image image) async {
    final Completer<Size> completer = Completer<Size>();

    image.image.resolve(const ImageConfiguration()).addListener(ImageStreamListener(
          (ImageInfo info, bool _) {
            completer.complete(Size(
              info.image.width.toDouble(),
              info.image.height.toDouble(),
            ));
          }
          )
    );

    final Size imageSize = await completer.future;

    return imageSize;
  }

  // here we will split the image into small pieces using the rows and columns defined above; each piece will be added to a stack
  void splitImage(Image image) async {
    Size imageSize = await getImageSize(image);

    for (int x = 0; x < widget.rows; x++) {
      for (int y = 0; y < widget.cols; y++) {
        setState(() {
          pieces.add(PuzzlePiece(key: GlobalKey(),
              image: image,
              imageSize: imageSize,
              row: x,
              col: y,
              maxRow: widget.rows,
              maxCol: widget.cols,
              bringToTop: this.bringToTop,
              sendToBack: this.sendToBack));
        });
      }
    }
  }

  // when the pan of a piece starts, we need to bring it to the front of the stack
  void bringToTop(Widget widget) {
    setState(() {
      pieces.remove(widget);
      pieces.add(widget);
    });
  }

  // when a piece reaches its final position, it will be sent to the back of the stack to not get in the way of other, still movable, pieces
  void sendToBack(Widget widget) {
    setState(() {
      pieces.remove(widget);
      pieces.insert(0, widget);
      if(gameComplete >= 30) Navigator.pushNamed(context, '/results_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!gameStart){
      getImage();
      gameStart = true;
    }

    return Stack(
      children: pieces,
    );

      /*
    return Scaffold(
      body: SafeArea(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: _image == null
                  ? new Text('No image selected.')
                  : Stack(children: pieces),
            ),
            FlatButton(onPressed: (){
              getImage();
            },
                child: Text('Play'))
          ],
        ),
      ),
    );

       */
  }
}

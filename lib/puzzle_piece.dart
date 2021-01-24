import 'dart:math';

import 'package:flutter/material.dart';
import 'game_logic.dart';

class PuzzlePiece extends StatefulWidget {
  final Image image;
  final Size imageSize;
  final int row;
  final int col;
  final int maxRow;
  final int maxCol;
  final Function bringToTop;
  final Function sendToBack;

  PuzzlePiece(
      {Key key,
        @required this.image,
        @required this.imageSize,
        @required this.row,
        @required this.col,
        @required this.maxRow,
        @required this.maxCol,
        @required this.bringToTop,
        @required this.sendToBack})
      : super(key: key);

  @override
  PuzzlePieceState createState() {
    return new PuzzlePieceState();
  }
}

class PuzzlePieceState extends State<PuzzlePiece> {
  double top;
  double left;
  bool isMovable = true;

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width - 80;
    final imageHeight = MediaQuery.of(context).size.height *
        MediaQuery.of(context).size.width /
        widget.imageSize.width;
    final pieceWidth = imageWidth / widget.maxCol;
    final pieceHeight = imageHeight / widget.maxRow;

    if (top == null) {
      top = Random().nextInt((imageHeight - pieceHeight).ceil()).toDouble();
      top -= widget.row * pieceHeight;
    }
    if (left == null) {
      left = Random().nextInt((imageWidth - pieceWidth).ceil()).toDouble();
      left -= widget.col * pieceWidth;
    }

    return Positioned(
      top: top + MediaQuery.of(context).size.width / 2.08 + 2,
      left: left + 40,
      width: imageWidth,
      child: GestureDetector(
        onTap: () {
          if (isMovable) {
            widget.bringToTop(widget);
          }
        },
        onPanStart: (_) {
          if (isMovable) {
            widget.bringToTop(widget);
          }
        },
        onPanUpdate: (dragUpdateDetails) {
          if (isMovable) {
            setState(() {
              top += dragUpdateDetails.delta.dy;
              left += dragUpdateDetails.delta.dx;

              if (-20 < top && top < 20 && -20 < left && left < 20) {
                top = 0;
                left = 0;
                isMovable = false;
                gameComplete++;
                widget.sendToBack(widget);
              }
            });
          }
        },
        child: ClipPath(
          child: CustomPaint(
              foregroundPainter: PuzzlePiecePainter(
                  widget.row, widget.col, widget.maxRow, widget.maxCol),
              child: widget.image),
          clipper: PuzzlePieceClipper(
              widget.row, widget.col, widget.maxRow, widget.maxCol),
        ),
      ),
    );
  }
}

// this class is used to clip the image to the puzzle piece path
class PuzzlePieceClipper extends CustomClipper<Path> {
  final int row;
  final int col;
  final int maxRow;
  final int maxCol;

  PuzzlePieceClipper(this.row, this.col, this.maxRow, this.maxCol);

  @override
  Path getClip(Size size) {
    return getPiecePath(size, row, col, maxRow, maxCol);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// this class is used to draw a border around the clipped image
class PuzzlePiecePainter extends CustomPainter {
  final int row;
  final int col;
  final int maxRow;
  final int maxCol;

  PuzzlePiecePainter(this.row, this.col, this.maxRow, this.maxCol);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue //Color(0x80FFFFFF) //0x80FFFFFF 10053D
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawPath(getPiecePath(size, row, col, maxRow, maxCol), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// this is the path used to clip the image and, then, to draw a border around it; here we actually draw the puzzle piece
Path getPiecePath(Size size, int row, int col, int maxRow, int maxCol) {
  final width = size.width / maxCol;
  final height = size.height / maxRow;
  final offsetX = col * width;
  final offsetY = row * height;
  final bumpSize = height / 4;

  var path = Path();
  path.moveTo(offsetX, offsetY);

  if (row == 0) {
    // top side piece
    path.lineTo(offsetX + width, offsetY);
  } else {

    path.lineTo(offsetX + width / 3, offsetY);
    //bottom bump
    if(row == 5 && col == 1 || row == 2 && col == 2 || row == 1 && col == 0){
      path.cubicTo(
          offsetX + width / 6,
          offsetY + bumpSize,
          offsetX + width / 6 * 5,
          offsetY + bumpSize,
          offsetX + width / 3 * 2,
          offsetY);
    } else {     // top bump
      path.cubicTo(
          offsetX + width / 6,
          offsetY - bumpSize,
          offsetX + width / 6 * 5,
          offsetY - bumpSize,
          offsetX + width / 3 * 2,
          offsetY);
    }
    path.lineTo(offsetX + width, offsetY);
  }

  if (col == maxCol - 1) {
    // right side piece
    path.lineTo(offsetX + width, offsetY + height);
  } else {
    // right bump
    path.lineTo(offsetX + width, offsetY + height / 3);
    if(col == 0 || col == 2 || col == 4){
      path.cubicTo(
          offsetX + width - bumpSize,  //offsetX is 0 in here
          offsetY + height / 6,
          offsetX + width - bumpSize,
          offsetY + height / 6 * 5,
          offsetX + width,
          offsetY + height / 3 * 2);
    }
    //left bump
    if(col == 1 || col == 3 || col == 5){
      path.cubicTo(
          offsetX + width + bumpSize,
          offsetY + height / 6,
          offsetX + width + bumpSize,
          offsetY + height / 6 * 5,
          offsetX + width,
          offsetY + height / 3 * 2);
    }
    path.lineTo(offsetX + width, offsetY + height);
  }

  if (row == maxRow - 1) {
    // bottom side piece
    path.lineTo(offsetX, offsetY + height);
  } else {
    // bottom bump
    path.lineTo(offsetX + width / 3 * 2, offsetY + height);
    if(row == 4 && col == 1 || row == 1 && col == 2 || row == 0 && col == 0){
      path.cubicTo(
          offsetX + width / 6 * 5,
          offsetY + height + bumpSize,
          offsetX + width / 6,
          offsetY + height + bumpSize,
          offsetX + width / 3,
          offsetY + height);
    } else {
      path.cubicTo(
          offsetX + width / 6 * 5,
          offsetY + height - bumpSize,
          offsetX + width / 6,
          offsetY + height - bumpSize,
          offsetX + width / 3,
          offsetY + height);
    }

    path.lineTo(offsetX, offsetY + height);
  }

  if (col == 0) {
    // left side piece
    path.close();
  } else {
    // left bump
    path.lineTo(offsetX, offsetY + height / 3 * 2);
    if(col == 1 || col == 3 || col == 5){
      path.cubicTo(
          offsetX - bumpSize,
          offsetY + height / 6 * 5,
          offsetX - bumpSize,
          offsetY + height / 6,
          offsetX,
          offsetY + height / 3);
    }
    if(col == 2 || col == 4){
      path.cubicTo(
          offsetX + bumpSize,
          offsetY + height / 6 * 5,
          offsetX + bumpSize,
          offsetY + height / 6,
          offsetX,
          offsetY + height/3);
    }
    path.close();
  }

  return path;
}
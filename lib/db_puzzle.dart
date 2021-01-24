import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

class PuzzleDatabase{
  static const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static Random _rand = Random.secure();

  static void createRoom(final dbRef){
    String code = getRandomString(5);

    for(int i = 0; i < 5; i++){
      dbRef.child(code).child('item$i').set({

      });
    }
  }

  static int getTransactionNumber(final dbRef){
    dbRef.orderByKey().equalTo('transactionNumber').once().then(
            (DataSnapshot ss){
          return ss.value;
        });
    return 0;
  }

  static getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rand.nextInt(_chars.length))));
}
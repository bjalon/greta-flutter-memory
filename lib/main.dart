import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final cardCount = 20;
  late List<int> orderList;

  MyApp({Key? key}) : super(key: key) {
    orderList = [for(var i=0; i < cardCount; i+=1) i];
    orderList.shuffle();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var cardReturnedList = [];
  var _counter = 0;

  @override
  Widget build(BuildContext context) {
    var isBlocked = cardReturnedList.length >= 2;

    final widgetList = [];

    for (var i = 0; i < widget.cardCount; i ++) {
      widgetList.add(CardWidget("${i%(widget.cardCount / 2)}",
          isBlocked: isBlocked,
          onCardReturned: onCardReturned,
          key: ValueKey("${i}_$_counter")));
    }

    final rowCount = sqrt(widget.cardCount);
    final Map<int, List<Widget>> columnChildren = {};
    for (var i = 0; i < widget.cardCount; i ++) {
      final rowIndex = (i ~/ rowCount).truncate();
      if ((i % rowCount).truncate() == 0) {
        print(i);
        columnChildren[rowIndex] = [];
      }
      print("$i/$rowIndex/${(i % rowCount)}");
      columnChildren[rowIndex]!.add(widgetList[widget.orderList[i]]);
    }

    final List<Widget> column = [];
    for (var row in columnChildren.values) {
      column.add(Row(children: row));
    }

    return MaterialApp(
      home: Scaffold(
        body: Column(children: column),
      ),
    );
  }

  void onCardReturned(String id) {
    cardReturnedList.add(id);
    print(cardReturnedList);
    if (cardReturnedList.length >= 2) {
      setState(() {});
      Future.delayed(
          Duration(seconds: 3),
          () => setState(() {
                _counter++;
                cardReturnedList = [];
              }));
    }
  }
}

class CardWidget extends StatefulWidget {
  final String value;
  final void Function(String id) onCardReturned;
  final bool isBlocked;

  const CardWidget(this.value,
      {Key? key, required this.onCardReturned, required this.isBlocked})
      : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  var isShown = false;

  @override
  Widget build(BuildContext context) {
    // var textAAfficher;
    // if (isShown) {
    //   textAAfficher = widget.value;
    // } else {
    //   textAAfficher = "?";
    // }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          child: IconButton(
              onPressed: clickedCard,
              icon: Text(isShown ? widget.value : "?"))),
    );
  }

  void clickedCard() {
    if (!widget.isBlocked) {
      setState(() {
        isShown = !isShown;
        if (isShown) {
          widget.onCardReturned(widget.value);
        }
        //
        // if (isShown) {
        //   isShown = false;
        // } else {
        //   isShown = true;
        // }
      });
    }
  }
}

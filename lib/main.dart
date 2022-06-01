import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var cardReturnedList = [];
  var _counter = 0;

  @override
  Widget build(BuildContext context) {
    var isBlocked = cardReturnedList.length >= 2;

    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardWidget("1",
                    isBlocked: isBlocked,
                    onCardReturned: onCardReturned,
                    key: ValueKey("1_$_counter")),
                CardWidget("2",
                    isBlocked: isBlocked,
                    onCardReturned: onCardReturned,
                    key: ValueKey("2_$_counter")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardWidget("1",
                    isBlocked: isBlocked,
                    onCardReturned: onCardReturned,
                    key: ValueKey("3_$_counter")),
                CardWidget("2",
                    isBlocked: isBlocked,
                    onCardReturned: onCardReturned,
                    key: ValueKey("4_$_counter")),
              ],
            )
          ],
        ),
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

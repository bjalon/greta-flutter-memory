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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardWidget("1", onCardReturned: onCardReturned),
                CardWidget("2", onCardReturned: onCardReturned),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardWidget("1", onCardReturned: onCardReturned),
                CardWidget("2", onCardReturned: onCardReturned),
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
  }
}

class CardWidget extends StatefulWidget {
  final String value;
  final void Function(String id) onCardReturned;

  const CardWidget(this.value, {Key? key, required this.onCardReturned}) : super(key: key);

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
          child: IconButton(onPressed: clickedCard, icon: Text(isShown ? widget.value : "?"))),
    );
  }

  void clickedCard() {
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

import 'package:bitcoin_ticker/price_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PriceScreen(),
      theme: ThemeData.light().copyWith(canvasColor: Colors.blueGrey),
    );
  }
}

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton androidDropdownButton() {
    List<DropdownMenuItem<String>> dropdownMenuItems = currenciesList
        .map(
          (currency) => DropdownMenuItem(
        child: Text(
          currency,
          style: TextStyle(color: Colors.white),
        ),
        value: currency,
      ),
    )
        .toList();
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownMenuItems,
        onChanged: (newValue) {
          setState(() {
            selectedCurrency = newValue;
            getCoinData();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = currenciesList
        .map((e) =>
        Text(
          e,
          style: TextStyle(color: Colors.white),
        ))
        .toList();
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (int selectedIndex) {
          setState(() {
            selectedCurrency = currenciesList[selectedIndex];
            getCoinData();
          });
        },
        children: pickerItems);
  }

  Map<String, String> cryptoCurrencyValues = {
    'BTC': '?',
    'ETH': '?',
    'LTC': '?'
  };

  void getCoinData() async {
    try {
      CoinData coinData = CoinData();
      Map<String, int> exchangeRates =
      await coinData.getCoinData(selectedCurrency);
      if (exchangeRates.length != 3) {
        return;
      }
      setState(() {
        for (String key in cryptoCurrencyValues.keys) {
          cryptoCurrencyValues[key] = exchangeRates[key].toString();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCoinData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('\ud83e\udd11 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cryptoList.map((e) => CryptoCard(e)).toList(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            color: Colors.lightBlue,
            padding: EdgeInsets.only(bottom: 20.0),
            child: Platform.isIOS ? iOSPicker() : androidDropdownButton(),
          )
        ],
      ),
    );
  }

  Widget CryptoCard(String cryptoCurrency) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = ${cryptoCurrencyValues[cryptoCurrency]} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptocurrency Converter Calculator',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          title: const Text(
            'Cryptocurrency Converter Calculator',
            style: TextStyle(
              fontFamily: 'PatrickHand',
            ),
          ),
        ),
        body: const ConvertPage(),
      ),
    );
  }
}

class ConvertPage extends StatefulWidget {
  const ConvertPage({Key? key}) : super(key: key);

  @override
  State<ConvertPage> createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {
  TextEditingController textEditingController = TextEditingController();
  var fromCrrName = '',
      toCrrName = '',
      fromCrrUnit = '',
      toCrrUnit = '',
      fromCrrValue = 0.0,
      toCrrValue = 0.0,
      result = 'No result';

  String selectFromCrr = 'btc';
  String selectToCrr = 'btc';

  final List<Product> products = [
    //Crypto
    Product(name: 'Crypto', type: 'sep'),
    Product(name: 'btc', type: 'data'),
    Product(name: 'eth', type: 'data'),
    Product(name: 'ltc', type: 'data'),
    Product(name: 'bch', type: 'data'),
    Product(name: 'bnb', type: 'data'),
    Product(name: 'eos', type: 'data'),
    Product(name: 'xrp', type: 'data'),
    Product(name: 'xlm', type: 'data'),
    Product(name: 'link', type: 'data'),
    Product(name: 'dot', type: 'data'),
    Product(name: 'yfi', type: 'data'),
    Product(name: 'bits', type: 'data'),
    Product(name: 'sats', type: 'data'),
    //Fiat
    Product(name: 'Fiat', type: 'sep'),
    Product(name: 'usd', type: 'data'),
    Product(name: 'aed', type: 'data'),
    Product(name: 'ars', type: 'data'),
    Product(name: 'aud', type: 'data'),
    Product(name: 'bdt', type: 'data'),
    Product(name: 'bmd', type: 'data'),
    Product(name: 'brl', type: 'data'),
    Product(name: 'cad', type: 'data'),
    Product(name: 'chf', type: 'data'),
    Product(name: 'clp', type: 'data'),
    Product(name: 'cny', type: 'data'),
    Product(name: 'czk', type: 'data'),
    Product(name: 'dkk', type: 'data'),
    Product(name: 'eur', type: 'data'),
    Product(name: 'gbp', type: 'data'),
    Product(name: 'hkd', type: 'data'),
    Product(name: 'huf', type: 'data'),
    Product(name: 'idr', type: 'data'),
    Product(name: 'ils', type: 'data'),
    Product(name: 'inr', type: 'data'),
    Product(name: 'jpy', type: 'data'),
    Product(name: 'krw', type: 'data'),
    Product(name: 'kwd', type: 'data'),
    Product(name: 'lkr', type: 'data'),
    Product(name: 'mmk', type: 'data'),
    Product(name: 'mxn', type: 'data'),
    Product(name: 'myr', type: 'data'),
    Product(name: 'ngn', type: 'data'),
    Product(name: 'nok', type: 'data'),
    Product(name: 'nzd', type: 'data'),
    Product(name: 'php', type: 'data'),
    Product(name: 'pkr', type: 'data'),
    Product(name: 'pln', type: 'data'),
    Product(name: 'rub', type: 'data'),
    Product(name: 'sar', type: 'data'),
    Product(name: 'sek', type: 'data'),
    Product(name: 'sgd', type: 'data'),
    Product(name: 'thb', type: 'data'),
    Product(name: 'try', type: 'data'),
    Product(name: 'twd', type: 'data'),
    Product(name: 'uah', type: 'data'),
    Product(name: 'vef', type: 'data'),
    Product(name: 'vnd', type: 'data'),
    Product(name: 'zar', type: 'data'),
    Product(name: 'xdr', type: 'data'),
    //Commodity
    Product(name: 'Commodity', type: 'sep'),
    Product(name: 'xag', type: 'data'),
    Product(name: 'xau', type: 'data'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(
                Icons.attach_money_outlined,
                size: 40,
                color: Colors.teal.shade900,
              ),
              title: const Text(
                'BitCoin cryptocurrency value exchange',
                style: TextStyle(
                  fontFamily: 'SourceSerifPro',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: "Enter Amount",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 94, 158, 151),
                    borderRadius: BorderRadius.circular(30)),
                // DropdownButton01
                child: DropdownButton(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: 'SourceSerifPro',
                  ),
                  underline: Container(),
                  isExpanded: true,
                  itemHeight: 50,
                  value: selectFromCrr,
                  onChanged: (newValue) {
                    setState(() {
                      selectFromCrr = newValue.toString();
                    });
                  },
                  items: products.map((value) {
                    return DropdownMenuItem(
                        enabled: value.type == 'sep' ? false : true,
                        value: value.name,
                        child: value.type == 'data'
                            ? Text(value.name)
                            : DropdownMenuItemSeperator(name: value.name));
                  }).toList(),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.arrow_right_alt_outlined,
                size: 35,
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 150,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 94, 158, 151),
                    borderRadius: BorderRadius.circular(30)),
                // DropdownButton02
                child: DropdownButton(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: 'SourceSerifPro',
                  ),
                  underline: Container(),
                  isExpanded: true,
                  itemHeight: 50,
                  value: selectToCrr,
                  onChanged: (newValue) {
                    setState(() {
                      selectToCrr = newValue.toString();
                    });
                  },
                  items: products.map((value) {
                    return DropdownMenuItem(
                        enabled: value.type == 'sep' ? false : true,
                        value: value.name,
                        child: value.type == 'data'
                            ? Text(value.name)
                            : DropdownMenuItemSeperator(name: value.name));
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.teal.shade900,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: _loadCrr,
            child: const Text('Convert'),
          ),
          SizedBox(
            height: 150,
            width: 400,
            child: Card(
              elevation: 8,
              margin: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadCrr() async {
    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        try {
          double num = 0.0;
          num = double.parse(textEditingController.text);
          fromCrrName = parsedJson['rates'][selectFromCrr]['name'];
          toCrrName = parsedJson['rates'][selectToCrr]['name'];
          fromCrrUnit = parsedJson['rates'][selectFromCrr]['unit'];
          toCrrUnit = parsedJson['rates'][selectToCrr]['unit'];
          fromCrrValue = parsedJson['rates'][selectFromCrr]['value'];
          toCrrValue = parsedJson['rates'][selectToCrr]['value'];

          double answer = 0.0;
          if (fromCrrName == 'btc') {
            answer = num * toCrrValue;
          } else if (fromCrrName != 'btc') {
            answer = num * (toCrrValue / fromCrrValue);
          }
          result =
              "$num $fromCrrName ($fromCrrUnit) = $answer $toCrrName ($toCrrUnit)";
        } catch (e) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Reminder',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text('Please enter amount.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Confirm'),
                    )
                  ],
                );
              });
        }
      });
    } else {
      setState(() {
        result = "No result";
      });
    }
  }
}

class Product {
  final String name;
  final String type;

  Product({required this.name, required this.type});
}

class DropdownMenuItemSeperator<T> extends DropdownMenuItem<T> {
  final String name;

  DropdownMenuItemSeperator({required this.name, Key? key})
      : super(
          key: key,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
}

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayText = '0';
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '';
  String opr = '';
  String preOpr = '';

  // Button Widget
  Widget calcButton(String btnText, Color btnColor, Color txtColor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btnText);
        },
        child: Text(
          '$btnText',
          style: TextStyle(
            fontSize: 40,
            color: txtColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor, // Background color
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculator
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        title: Text('Calculator',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        primaryColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$displayText',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('AC', Colors.grey, Colors.black),
                calcButton('+/-', Colors.grey, Colors.black),
                calcButton('%', Colors.grey, Colors.black),
                calcButton('/', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('7', Colors.grey[850]!, Colors.white),
                calcButton('8', Colors.grey[850]!, Colors.white),
                calcButton('9', Colors.grey[850]!, Colors.white),
                calcButton('x', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('4', Colors.grey[850]!, Colors.white),
                calcButton('5', Colors.grey[850]!, Colors.white),
                calcButton('6', Colors.grey[850]!, Colors.white),
                calcButton('-', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('1', Colors.grey[850]!, Colors.white),
                calcButton('2', Colors.grey[850]!, Colors.white),
                calcButton('3', Colors.grey[850]!, Colors.white),
                calcButton('+', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    calculation('0');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[850],minimumSize: Size(100, 15), // Background color
                    shape: StadiumBorder(),
                    padding: EdgeInsets.fromLTRB(34, 29,110, 20)
                  ),
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                ),
                calcButton('.', Colors.grey[850]!, Colors.white),
                calcButton('=', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Calculator logic
  void calculation(String btnText) {
    if (btnText == 'AC') {
      displayText = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }

      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = (numOne / 100).toString();
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.contains('.')) {
        result += '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result = result.startsWith('-') ? result.substring(1) : '-$result';
      finalResult = result;
    } else {
      result += btnText;
      finalResult = result;
    }

    setState(() {
      displayText = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    if (numTwo != 0) {
      result = (numOne / numTwo).toString();
      numOne = double.parse(result);
    } else {
      result = 'Error';
    }
    return doesContainDecimal(result);
  }

  String doesContainDecimal(String result) {
    if (result.contains('.')) {
      List<String> splitDecimal = result.split('.');
      if (int.parse(splitDecimal[1]) == 0) {
        return splitDecimal[0];
      }
    }
    return result;
  }
}

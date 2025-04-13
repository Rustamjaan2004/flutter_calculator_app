import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '';
  String result = '';

  void buttonPressed(String text) {
    setState(() {
      display += text;
    });
  }

  void clearDisplay() {
    setState(() {
      display = '';
      result = '';
    });
  }

  void calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(display);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        result = evalResult.toString();
      });
    } catch (e) {
      setState(() {
        result = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator - Suyunov Rustamjon'),
        backgroundColor: Colors.yellow[600],
      ),
      backgroundColor: Color(0xFFB0E0E6),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerRight,
              color: Colors.white,
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    display,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    result,
                    style: TextStyle(fontSize: 28, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  return CalculatorButton(
                    text: buttonLabels[index],
                    onPressed: () {
                      if (buttonLabels[index] == 'C') {
                        clearDisplay();
                      } else if (buttonLabels[index] == '=') {
                        calculateResult();
                      } else {
                        buttonPressed(buttonLabels[index]);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> buttonLabels = [
    '1', '2', '3', 'C',
    '4', '5', '6', '+',
    '7', '8', '9', '-',
    '0', '.', '=', '',
  ];
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CalculatorButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Text(text, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFF0FFFF), // Button color
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        foregroundColor: Colors.black, // Text color
      ),
    );
  }
}

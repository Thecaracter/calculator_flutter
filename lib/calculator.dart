import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = '';
  String result = '0';
  List<String> buttonList = [
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "C",
    "0",
    ".",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2530),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    // color: Color(0xff4D455D),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Color(0xff4D455D),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1),
                          blurRadius: 4,
                          spreadRadius: 0.5,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Text(
                      result,
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: buttonList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return CustomButton(buttonList[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CustomButton(String buttonText) {
    return InkWell(
      splashColor: Color(0xFF1d2530),
      onTap: () {
        setState(() {
          handleButton(buttonText);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getbgColor(buttonText),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                buttonText,
                style: TextStyle(
                    fontSize: 24,
                    color: getColor(buttonText),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleButton(String buttonText) {
    if (buttonText == "AC") {
      userInput = '';
      result = '0';
      return;
    } else if (buttonText == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
      }
    } else if (buttonText == "=") {
      result = calculate();
      userInput = result;
      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
    } else {
      userInput = userInput + buttonText;
    }
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluate = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluate.toString();
    } catch (e) {
      return "error";
    }
  }

  getColor(String buttonText) {
    if (buttonText == "C" || buttonText == "=") {
      return Color(0xFF3A98B9);
    } else {
      return Colors.white.withOpacity(0.7);
    }
  }

  getbgColor(String buttonText) {
    if (buttonText == "AC") {
      return Color(0xFF3A98B9);
    } else {
      return Color(0xff4D455D);
    }
  }
}

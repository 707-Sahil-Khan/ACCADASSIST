import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/otherCalculations.dart';
import 'package:project/simpleCalculator.dart';
import 'cgpaCalculator.dart';

class ScientificCalculator extends StatefulWidget {
  const ScientificCalculator({super.key});

  @override
  _ScientificCalculatorState createState() {
    return _ScientificCalculatorState();
  }
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  String TextToDisplay = '';
  String Ans = '0';
  String RESULT = '';
  String finalAns = '';
  bool isDarkMode = false;
  bool flag = false;

  // Function to update the display
  void updateDisplay(String buttonValue) {
    setState(() {
      TextToDisplay += buttonValue;
    });
  }

  // Function to calculate the answer using the new API
  Future<void> calculateAnswer() async {
    try {
      // API URL
      const String API_URL = 'https://api.mathjs.org/v4/';

      // Create the request body
      final Map<String, dynamic> requestBody = {"expr": TextToDisplay};

      // Send the request
      final response = await http.post(
        Uri.parse(API_URL),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      // Check the response status
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        // Clear variables to ensure no leftovers
        RESULT = result.toString();
        finalAns = '';
        flag = false;

        // Extract the answer
        for (int i = 0; i < RESULT.length; i++) {
          if (RESULT[i] == ' ') {
            flag = true;
          }

          if (flag) {
            if (RESULT[i] == ',') {
              flag = false;
              break;
            } else {
              finalAns += RESULT[i];
            }
          }
        }

        // Update the result in the UI
        setState(() {
          Ans = finalAns;
        });
      } else {
        setState(() {
          Ans = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        Ans = 'Error: $e';
      });
    }
  }

  String _getTruncatedText(String text, int maxLength) {
    if (text.length > maxLength) {
      return text.substring(text.length - maxLength);
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Scientific Calculator',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: isDarkMode ? const Color(0xFF1d2630) : Colors.white,
      drawer: Drawer(
        backgroundColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  'AccadAssist',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calculate,
                  color: Color(0xFFFF9500), size: 30),
              title: Text(
                'Simple Calculator',
                style: TextStyle(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SimpleCalculator(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate,
                  color: Color(0xFFFF9500), size: 30),
              title: Text(
                'CGPA Calculator',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CgpaCalculator(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate,
                  color: Color(0xFFFF9500), size: 30),
              title: Text(
                'Other Calculators',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtherCalculators(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sunny_snowing,
                  color: Color(0xFFFF9500), size: 30),
              title: Text(
                isDarkMode ? 'Change to light theme' : 'Change to dark theme',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // User input display
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.height * 1,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 8),
              child: Text(
                _getTruncatedText(TextToDisplay, 12),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 30,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ),

          // Answer display
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.height * 1,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  Ans,
                  textAlign: TextAlign.right,
                  style:
                      const TextStyle(color: Color(0xFFFF9500), fontSize: 65),
                ),
              ),
            ),
          ),

          // Buttons
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Color(0xFF2A2A2A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(33),
                  topRight: Radius.circular(33),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Row 1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '√',
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('√');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'AC',
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              //This will clear the text to default
                              TextToDisplay = '';
                              Ans = '0';
                              finalAns = '0';
                            });
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Container(
                              child: Icon(
                                Icons.cancel,
                                size: 40,
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              // this will delete the last character
                              TextToDisplay = TextToDisplay.substring(
                                  0, TextToDisplay.length - 1);
                            });
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '%',
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('%');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'n!',
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('!');
                          },
                        ),
                      ],
                    ),
                    // Row 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '(',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('(');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                ')',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay(')');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'x^y',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('^');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'e',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('e');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9500),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '/',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('/');
                          },
                        ),
                      ],
                    ),
                    // Row 3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'sin',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('sin(');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '7',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('7');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '8',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('8');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '9',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('9');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9500),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'x',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('*');
                          },
                        ),
                      ],
                    ),
                    // Row 4
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'cos',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('cos(');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '4',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('4');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '5',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('5');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '6',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('6');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9500),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('-');
                          },
                        ),
                      ],
                    ),
                    // Row 5
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'tan',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('tan(');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('1');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('2');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '3',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('3');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9500),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '+',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('+');
                          },
                        ),
                      ],
                    ),
                    // Row 6
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'log',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('log(');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('0');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'π',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('3.1415');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '.',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('.');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9500),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '=',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            calculateAnswer();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

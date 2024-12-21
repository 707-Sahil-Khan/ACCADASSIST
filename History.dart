import 'package:flutter/material.dart';
import 'package:project/cgpaCalculator.dart';
import 'package:project/otherCalculations.dart';
import 'package:project/scientificCalculator.dart';
import 'package:project/simpleCalculator.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  @override
  HistoryPageState createState() {
    return HistoryPageState();
  }
}

class HistoryPageState extends State<HistoryPage> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Currency Calculator',
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
                'Scientific Calculator',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScientificCalculator(),
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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Simple Calculator History : '),
            Text('Scientific Calculator History : '),
            Text('CGPA Calculator History : '),
            Text('BMI History : '),
            Text('Currency History : '),
            Text('Discount History : '),
          ],
        ),
      ),
    );
  }
}

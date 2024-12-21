import 'package:flutter/material.dart';

class DiscountCalculator extends StatefulWidget {
  const DiscountCalculator({super.key});

  @override
  DiscountCalculatorState createState() {
    return DiscountCalculatorState();
  }
}

class DiscountCalculatorState extends State<DiscountCalculator> {
  bool isDarkMode = false;
  TextEditingController orignalAmount = TextEditingController();
  TextEditingController discount = TextEditingController();

  double discountedAmount = 0,
      convertDiscount = 0,
      ammountAfterDiscountApplied = 0;

  void CalculateDiscount() {
    setState(() {
      convertDiscount = double.parse(discount.text);
      convertDiscount = convertDiscount / 100;

      discountedAmount = double.parse(orignalAmount.text);
      discountedAmount = discountedAmount * convertDiscount;

      ammountAfterDiscountApplied = double.parse(orignalAmount.text);
      ammountAfterDiscountApplied =
          ammountAfterDiscountApplied - discountedAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Discount Calculator',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: isDarkMode ? const Color(0xFF1d2630) : Colors.white,
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Original Amount',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
            TextField(
              controller: orignalAmount,
              cursorColor: isDarkMode ? Color(0xFF1d2630) : Colors.white,
              decoration: InputDecoration(
                hintText: ' 0.00',
                hintStyle: TextStyle(
                  color: isDarkMode ? Color(0xFFB3B3B3) : Colors.white,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.white : Color(0xFF1d2630),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white : Color(0xFF1d2630),
                    ),
                    borderRadius: BorderRadius.circular(100)),
                filled: true,
                fillColor: isDarkMode ? Colors.white : Color(0xFF1d2630),
              ),
              style: TextStyle(
                color: isDarkMode ? Color(0xFFB3B3B3) : Colors.white,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text(
              'Discount %',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
            TextField(
              controller: discount,
              cursorColor: isDarkMode ? Color(0xFF1d2630) : Colors.white,
              decoration: InputDecoration(
                hintText: ' 0%',
                hintStyle: TextStyle(
                  color: isDarkMode ? Color(0xFFB3B3B3) : Colors.white,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.white : Color(0xFF1d2630),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white : Color(0xFF1d2630),
                    ),
                    borderRadius: BorderRadius.circular(100)),
                filled: true,
                fillColor: isDarkMode ? Colors.white : Color(0xFF1d2630),
              ),
              style: TextStyle(
                color: isDarkMode ? Color(0xFFB3B3B3) : Colors.white,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 1,
              color: Colors.transparent,
              child: Text(
                'Discounted amount : ' +
                    discountedAmount.toString() +
                    '\nAmount after discount applied : ' +
                    ammountAfterDiscountApplied.toString(),
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: Size(160, 60),
                ),
                onPressed: () {
                  if (orignalAmount.text.isNotEmpty &&
                      discount.text.isNotEmpty) {
                    CalculateDiscount();
                  }
                },
                child: Text(
                  'Calculate',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

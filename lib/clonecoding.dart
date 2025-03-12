import 'package:flutter/material.dart';
import 'widgets/button.dart';
import 'widgets/card.dart';

// void main() {
//   runApp(App());
// }

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Hey dahyeon',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'welcome back',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'TotalBalance',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '\$5 194 482',
                  style: TextStyle(
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      text: 'Transfer',
                      bgColor: Color(0xfff2b33a),
                      textColor: Colors.white,
                    ),
                    Button(
                      text: 'Request',
                      bgColor: Color(0xff1f2123),
                      textColor: Colors.white,
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Wallets',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CurrencyCard(
                  name: 'Euro',
                  code: 'EUR',
                  amount: "6 428",
                  icon: Icons.euro_rounded,
                  isInverted: false,
                  order: 0,
                ),
                CurrencyCard(
                  name: 'Bitcoin',
                  code: 'BTC',
                  amount: "9 785",
                  icon: Icons.currency_bitcoin,
                  isInverted: true,
                  order: 1,
                ),
                CurrencyCard(
                  name: 'Dollar',
                  code: 'USD',
                  amount: "9 785",
                  icon: Icons.attach_money_outlined,
                  isInverted: false,
                  order: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

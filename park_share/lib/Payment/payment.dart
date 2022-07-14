import 'package:flutter/material.dart';
import 'checkout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class Payment extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // to avoid overflow when keyboard is open
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            //removes back arrow
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 5,
            title: Text("Payment",
                style: GoogleFonts.playfairDisplay(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.white,
                ))),
        body: Container(
          child: ScaffoldBodyContent(),
          decoration: new BoxDecoration(color: Colors.teal.withOpacity(0.1)),
        ));
  }
}

class ScaffoldBodyContent extends StatefulWidget {
  @override
  State<ScaffoldBodyContent> createState() => _ScaffoldBodyContentState();
}

class _ScaffoldBodyContentState extends State<ScaffoldBodyContent> {
  int _selectedCard = 0;
  TextEditingController _controllerone = TextEditingController();
  TextEditingController _controllertwo = TextEditingController();
  TextEditingController _controllerthree = TextEditingController();
  TextEditingController _controllerfour = TextEditingController();

  final _paymentKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _paymentKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Payment Method",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.credit_card),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 20, 10),
            child: Text("Please select payment type before proceeding",
                style: GoogleFonts.playfairDisplay(
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                  color: Colors.black,
                )),
          ),
          // container holds payment options
          Container(
            width: 250,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
            //contains list of payment options
            child: Column(
              children: <Widget>[
                //VISA
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: _selectedCard == 1 ? const Color(0xffC4B9B9) : null,
                  ),
                  child: GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 10,
                        ),
                        Text(
                            "Visa                                               "),
                        Image.asset(
                          'images/visa.jpg',
                          width: 40,
                        ),
                      ],
                    ),
                    onTap: () async {
                      _selectedCard = 1;
                      setState(() {});
                    },
                  ),
                ),

                // Mastercard
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: _selectedCard == 2 ? const Color(0xffC4B9B9) : null,
                  ),
                  child: GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 10,
                        ),
                        Text("Mastercard                                  "),
                        Image.asset(
                          'images/mastercard.png',
                          width: 40,
                        ),
                      ],
                    ),
                    onTap: () async {
                      _selectedCard = 2;
                      setState(() {});
                    },
                  ),
                ),
                // Paypal
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: _selectedCard == 3 ? const Color(0xffC4B9B9) : null,
                  ),
                  child: GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 10,
                        ),
                        Text(
                            "Paypal                                          "),
                        Image.asset(
                          'images/paypal.png',
                          width: 40,
                        ),
                      ],
                    ),
                    onTap: () async {
                      _selectedCard = 3;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          //Credit card number
          Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 00),
            child: TextFormField(
              inputFormatters: [
                // allows for a max of 16 characters
                new LengthLimitingTextInputFormatter(16),
              ],
              validator: (value) {
                // requires 16 characters
                if (value == null || value.isEmpty || value.length < 16) {
                  return 'Required Field';
                }
                return null;
              },
              controller: _controllerone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Payment Card Number',
              ),
              keyboardType: TextInputType.number,
            ),
          ),

          //Name on Credit card
          Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '8 Digit Credit Card';
                  }
                  return null;
                },
                controller: _controllertwo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name on Credit Card',
                ),
                // keyboardType: TextInputType.number,
              ),
            ),
          ),
          Row(children: [
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Padding(
                // padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Field';
                    }
                    return null;
                  },
                  controller: _controllerthree,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expiry Date',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            //Gap between Expiry date and CVV
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Field';
                    }
                    return null;
                  },
                  controller: _controllerfour,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CVV',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            SizedBox(
              width: 30,
            ),
          ]),
          // back button that pops to previous screen
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 30, 5, 0),
                width: 165,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Back",
                        style: GoogleFonts.playfairDisplay(
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ))),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5, 30, 10, 0),
                width: 165,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      // makes sure a payment card is selected
                      if (_selectedCard == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please select a payment card.')),
                        );
                      }
                      // proceeds to next page
                      if (_paymentKey.currentState!.validate() &
                          (_selectedCard > 0)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Checkout(_controllerone.text)),
                        );
                      }
                    },
                    child: Text("Checkout",
                        style: GoogleFonts.playfairDisplay(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

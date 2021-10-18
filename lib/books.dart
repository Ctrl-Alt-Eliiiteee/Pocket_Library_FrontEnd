import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_system/main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class DisplayBooks extends StatefulWidget {
  late MyBooks myBooks;
  DisplayBooks({required this.myBooks});

  @override
  _DisplayBooksState createState() => _DisplayBooksState();
}

List<String> bookNames = [
  "The Adventures of Sherlock Holmes",
  "The Fellowship of the Ring",
];

List<String> bookImages = [
  'https://images-na.ssl-images-amazon.com/images/I/917q1pl1VIL.jpg',
  'https://images-na.ssl-images-amazon.com/images/I/91rq1j7GYhL.jpg',
];

class _DisplayBooksState extends State<DisplayBooks> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        width: w,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h * 0.015,
            ),
            Center(
              child: Text(
                "Home",
                style: TextStyle(
                    fontSize: w * 0.06,
                    color: Colors.green,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: h * 0.03),
            Text(
              "Recommended",
              style: TextStyle(
                  fontSize: w * 0.06,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3 / 4,
                    crossAxisCount: 2,
                    mainAxisSpacing: h * 0.05,
                    crossAxisSpacing: w * 0.05),
                itemCount: bookNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyOrRent(
                                    myBooks: widget.myBooks,
                                    bookCover: bookImages[index],
                                    bookName: bookNames[index],
                                  )));
                    },
                    child: _bookCard(h, w, index),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bookCard(double h, double w, int index) {
    return Column(
      children: [
        Container(
          height: h * 0.18,
          width: w * 0.35,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                  image: NetworkImage(bookImages[index]),
                  fit: BoxFit.cover)),
        ),
        const SizedBox(height: 10),
        Text(
          bookNames[index],
          style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class BuyOrRent extends StatefulWidget {
  late MyBooks myBooks;
  final String ?bookName;
  final String ?bookCover;

  BuyOrRent({Key ?key, required this.myBooks, this.bookName, this.bookCover}) : super(key: key);
  @override
  _BuyOrRentState createState() => _BuyOrRentState();
}

class _BuyOrRentState extends State<BuyOrRent> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(String type) async {
    var options = {
      'key': 'rzp_test_RyfDbq015IzSkf',
      'amount': type == 'buy' ? 20000 : 5000,
      'name': 'Library Management',
      'description': 'Payment',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId.toString(), timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message.toString(),
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName.toString(), timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: h,
          width: w,
          child: Column(
            children: [
              SizedBox(height: h * 0.1),
              Container(
                height: h * 0.2,
                width: w * 0.35,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: NetworkImage(widget.bookCover.toString()),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(height: 10),
              Text(widget.bookName.toString(),
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    primary: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                child: Container(
                    height: h * 0.1,
                    width: w - 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Buy",
                            style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(
                          width: 20,
                        ),
                        const Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )),
                onPressed: () {
                  if(!widget.myBooks.bookNames.contains(widget.bookName)) {
                    widget.myBooks.add(widget.bookName, widget.bookCover);
                    openCheckout('buy');
                  }
                  else {
                    Fluttertoast.showToast(msg: "Already Exists in My Books");
                  }
                },
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    primary: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                child: Container(
                    height: h * 0.1,
                    width: w - 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Rent",
                            style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(
                          width: 20,
                        ),
                        const Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )),
                onPressed: () {
                  if(!widget.myBooks.bookNames.contains(widget.bookName)) {
                    widget.myBooks.add(widget.bookName, widget.bookCover);
                    openCheckout('rent');
                  }
                  else {
                    Fluttertoast.showToast(msg: "Already Exists in My Books");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

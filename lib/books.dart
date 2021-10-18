import 'package:flutter/material.dart';

class DisplayBooks extends StatefulWidget {
  @override
  _DisplayBooksState createState() => _DisplayBooksState();
}

List<Color?> _cardColors = [
  Colors.red[100],
  Colors.blue[100],
  Colors.pink[100],
  Colors.yellow[100]
];

List<String> _booknames = [
  "Amara The BRAVE",
  "Amara The BRAVE",
  "Amara The BRAVE",
  "Amara The BRAVE"
];

List<String> _coversList = [
  'assets/Amara.jpg',
  'assets/Amara.jpg',
  'assets/Amara.jpg',
  'assets/Amara.jpg'
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
                itemCount: _booknames.length,
                itemBuilder: (BuildContext context, int index) {
                  return TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyOrRent(
                                    bookCover: _coversList[index % 4],
                                    bookName: _booknames[index % 4],
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
          height: h * 0.2,
          width: w * 0.35,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                  image: AssetImage(_coversList[index % 4]),
                  fit: BoxFit.cover)),
        ),
        const SizedBox(height: 10),
        Text(
          _booknames[index % 4],
          style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ],
    );
  }
}

class BuyOrRent extends StatefulWidget {
  final String? bookName;
  final String? bookCover;

  const BuyOrRent({Key? key, this.bookName, this.bookCover}) : super(key: key);
  @override
  _BuyOrRentState createState() => _BuyOrRentState();
}

class _BuyOrRentState extends State<BuyOrRent> {
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
                        image: AssetImage(widget.bookCover.toString()),
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
                onPressed: () {},
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

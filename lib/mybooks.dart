import 'package:flutter/material.dart';

class DisplayMyBooks extends StatefulWidget {
  @override
  _DisplayMyBooksState createState() => _DisplayMyBooksState();
}

List<Color?> _cardColors = [
  Colors.red[100],
  Colors.blue[100],
  Colors.pink[100],
  Colors.yellow[100]
];

List<String> _myBooknames = [
  "Amara The BRAVE",
  "Amara The BRAVE",
];

List<String> _myIimagesList = [
  'assets/Amara.jpg',
  'assets/Amara.jpg',
];

class _DisplayMyBooksState extends State<DisplayMyBooks> {
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
                "Your books",
                style: TextStyle(
                    fontSize: w * 0.06,
                    color: Colors.green,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: h * 0.03),
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
                itemCount: _myBooknames.length,
                itemBuilder: (BuildContext context, int index) {
                  return TextButton(
                    onPressed: () {},
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
                  image: AssetImage(_myIimagesList[index % 4]),
                  fit: BoxFit.cover)),
        ),
        const SizedBox(height: 10),
        Text(
          _myBooknames[index % 4],
          style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ],
    );
  }
}

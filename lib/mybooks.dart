import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'main.dart';

class DisplayMyBooks extends StatefulWidget {
  late MyBooks myBooks;
  DisplayMyBooks({required this.myBooks});

  @override
  _DisplayMyBooksState createState() => _DisplayMyBooksState();
}

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
                itemCount: widget.myBooks.bookNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookViewer(
                                bookUrl: widget.myBooks.bookUrls[index],
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
                  image: NetworkImage(widget.myBooks.bookImages[index]),
                  fit: BoxFit.cover)),
        ),
        const SizedBox(height: 10),
        Text(
          widget.myBooks.bookNames[index],
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

class BookViewer extends StatelessWidget {
  late String bookUrl;
  BookViewer({Key? key, required this.bookUrl}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return Scaffold (
      body: SfPdfViewer.network(
        bookUrl,
      ),
    );
  }
}


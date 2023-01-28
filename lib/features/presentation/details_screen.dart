import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  TextStyle? getProductSans({double fontSize = 26}) {
    return TextStyle(fontFamily: 'Product Sans', fontSize: fontSize);
  }

  getBorder() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 2,
        color: Colors.grey);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          elevation: 3,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            SizedBox(
              height: 340,
              child: ListView.separated(
                shrinkWrap: true,
                primary: true,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 231,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.black),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 10);
                },
                itemCount: 13,
              ),
            ),
            Container(
                padding: EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Place', style: getProductSans(fontSize: 30)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.stars),
                            SizedBox(width: 14),
                            Text('Rating', style: getProductSans(fontSize: 18)),
                          ],
                        ),
                      ),
                      getBorder(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.place),
                            SizedBox(width: 14),
                            Text('Address',
                                style: getProductSans(fontSize: 18)),
                          ],
                        ),
                      ),
                      getBorder(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.timer),
                            SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('isOpened',
                                    style: getProductSans(fontSize: 14)),
                                Text('Opening Time',
                                    style: getProductSans(fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                      ),

                    ])),
          ],
        ));
  }
}

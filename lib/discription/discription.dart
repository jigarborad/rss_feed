import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Discription extends StatefulWidget {
  String selectedUrl;

  Discription({this.selectedUrl});

  @override
  _DiscriptionState createState() => _DiscriptionState(selectedUrl);
}

class _DiscriptionState extends State<Discription> {
  String selectedUrl;
  _DiscriptionState(this.selectedUrl);

  Future<void> openFeed(String selectedUrl) async {
    if (await canLaunch(selectedUrl)) {
      await launch(selectedUrl, forceWebView: false, forceSafariVC: true);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Discription'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Click Below Button',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: Colors.blue)),
            SizedBox(height: 20),
            FloatingActionButton.extended(
                onPressed: () {
                  openFeed(selectedUrl);
                },
                label: Text('Discription'))
          ],
        ),
      ),

      //floatingActionButton: FloatingActionButton.extended(
      //  onPressed: () {
      //  openFeed(selectedUrl);
      //},
      // label: Text('Click Here'))
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rrs_feed/discription/discription.dart';
import 'package:webfeed/webfeed.dart';
import 'package:intl/intl.dart';

class Rss_Feed extends StatefulWidget {
  final title = 'RSS FEED';
  @override
  _RssFeedState createState() => _RssFeedState();
}

class _RssFeedState extends State<Rss_Feed> {
  static const String feed_url = 'https://news.google.com/rss';
  RssFeed _feed;
  String _title;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  load() async {
    loadFeed().then((result) {
      updateFeed(result);
      updateTitle(_feed.title);
    });
  }

  Future<RssFeed> loadFeed() async {
    final client = http.Client();
    final response = await client.get(feed_url);
    return RssFeed.parse(response.body);
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return _feed == null
        ? Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Loading........',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: Colors.black)),
                  SizedBox(height: 20),
                  CircularProgressIndicator()
                ],
              ),
            ))
        : Scaffold(
            appBar: AppBar(
              title: Text(_title),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final item = _feed.items[index];
                String url1 = item.link;
                String time = DateFormat.yMMMMEEEEd().format(item.pubDate);
                return null == _feed || null == _feed.items
                    ? Center(child: CircularProgressIndicator())
                    : ListTile(
                        title: Text(
                          item.title,
                          style: TextStyle(fontSize: 15.0),
                        ),
                        subtitle: Text(time),
                        trailing: Icon(Icons.arrow_right),
                        contentPadding: EdgeInsets.all(5.0),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Discription(selectedUrl: url1)));
                        },
                      );
              },
            ),
          );
  }
}

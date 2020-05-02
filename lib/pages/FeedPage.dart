import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttercats/local.dart' show ACCESS_TOKEN;
import 'package:fluttercats/widgets/GifCardWidget.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FeedPageState createState() => new _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final String endpointURL = "https://api.giphy.com/v1/gifs/search";
  final int increment = 5;
  final int gifCount = 5;
  final String searchPhrase = 'cat';
  LinkedHashMap responseData = new LinkedHashMap();
  int currentLength = 0;
  bool isLoading = true;
  List<String> gifURLs = [];
  Random rng = new Random();

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  Future _loadMore() async {
    setState(() {
      isLoading = true;
    });

    int _offset = rng.nextInt(100);
    String requestUrl =
        "$endpointURL?api_key=$ACCESS_TOKEN&q=$searchPhrase&limit=$gifCount&offset=$_offset&rating=G&lang=en";

    http.Response response = await http.get(requestUrl);
    var jsonResp = json.decode(response.body);
    for (var i = currentLength; i <= currentLength + increment; i++) {
      responseData.addAll(jsonResp);
    }

    var giphysList = responseData["data"];

    giphysList.forEach((map) => {
          map.forEach((k, v) => {
                if (k == "images") {gifURLs.add(v["fixed_height"]["url"])}
              })
        });

    setState(() {
      isLoading = false;
      currentLength = responseData.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: LazyLoadScrollView(
        isLoading: isLoading,
        onEndOfPage: () => _loadMore(),
        scrollOffset: 100,
        child: ListView.builder(
          itemCount: gifURLs.length,
          itemBuilder: (context, position) {
            return GifCardWidget(gifURLs[position]);
          },
        ),
      ),
    );
  }
}

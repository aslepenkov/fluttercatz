import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert"; // for json recode
import "dart:math"; // for random
import 'CryptoCurrencyData.dart';

class CryptoCurrencyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CryptoCurrencyListState();
  }
}

class CryptoCurrencyListState extends State<CryptoCurrencyList> {
  List<CryptoCurrencyData> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Prices")),
        body: Container(child: ListView(children: _buildList())));
  }

  _loadIcons() async {
    final resp = await http.get('https://rest.coinapi.io/v1/assets/icons/1');

    if (resp.statusCode == 200) {
      var allData = json.decode(resp.body) as List<dynamic>;

      data.forEach((element) {
        dynamic icon =
            allData.where((i) => i["asset_id"] == element.symbol).toList();
        if (!icon.isEmpty) {
          element.imageURL = icon.first["url"];
        }
      });

      setState(() {
        data = data;
      });
    }
  }

  _loadCC() async {
    final resp = await http.get(
        'https://rest.coinapi.io/v1/assets?apikey=78933235-AC61-48C9-9B43-1591059FE868');

    var dataList = List<CryptoCurrencyData>();

    if (resp.statusCode == 200) {
      var allData = json.decode(resp.body) as List<dynamic>;
      var i = 0;
      allData
          .where((element) =>
              element['name'] != null &&
              element['asset_id'] != null &&
              element['price_usd'] != null)
          .forEach((element) {
        if (element['price_usd'] != null) {
          var record = CryptoCurrencyData(
              name: element['name'],
              symbol: element['asset_id'],
              imageURL: "",
              rank: i++,
              price: element['price_usd'] + 0.0);
          dataList.add(record);
        }
      });

      setState(() {
        data = dataList;
      });
    }
    _loadIcons();
  }

  List<Widget> _buildList() {
    return data //.take(10)
        .map((CryptoCurrencyData d) => ListTile(
              subtitle: Text(d.symbol),
              title: Text(d.name),
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(d.imageURL), child: _symbol(d)),
              trailing: Text('\$${d.price.toStringAsFixed(2)}'),
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadCC();
  }
}

Widget _symbol(CryptoCurrencyData d) {
  return d.imageURL == "" ? Text(d.symbol) : Text("");
}

import 'package:flutter/material.dart';
import 'package:flutter_demo/cats/LoginPage.dart';
import 'cryptocurrency/CryptoCurrencyList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                  color: Colors.white60,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  },
                  splashColor: Colors.blue,
                  child: Text('Cats')),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                  color: Colors.white60,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CryptoCurrencyList();
                        },
                      ),
                    );
                  },
                  splashColor: Colors.red,
                  child: Text('Cryptocurrency')),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                  color: Colors.white60,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return null;
                        },
                      ),
                    );
                  },
                  splashColor: Colors.red,
                  child: Text('Tik Tok')),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                  color: Colors.white60,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return null;
                        },
                      ),
                    );
                  },
                  splashColor: Colors.red,
                  child: Text('From dribble')),
            ),
          ])),
    );
  }
}

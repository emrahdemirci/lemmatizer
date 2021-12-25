import 'package:flutter/material.dart';
import 'package:lemmatizer/lemmatizer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Lemmatizer Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = "";
  Lemmatizer lemmatizer = new Lemmatizer();
  TextEditingController? _controller;
  @override
  void initState() {
    _controller = new TextEditingController();
    super.initState();
  }

  void _lemmatize() {
    setState(() {
      _text = lemmatizer.lemma(_controller!.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Input word"),
                controller: _controller,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Lemmatized Word : $_text',
                ),
              ),
              RaisedButton(
                onPressed: _lemmatize,
                child: Text('Lemmatize'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

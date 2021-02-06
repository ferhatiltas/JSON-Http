import 'package:flutter/material.dart';
import 'package:json_http/remote_api.dart';

import 'local_json.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    title: "JSON ve API Kullanımı",
    home: MyHomePage(),
  );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Json ve Api"),),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(child:Text("Local Json"), color: Colors.green, onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LocalJsonKullanimi()));
            },),
            RaisedButton(child:Text("Remote Api"), color: Colors.green, onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RemoteApiKullanimi()));
            },),

          ],
        ),
      ),
    );
  }
}


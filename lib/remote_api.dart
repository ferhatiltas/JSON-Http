
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:json_http/models/Gonderi.dart';


class RemoteApiKullanimi extends StatefulWidget {
  @override
  _RemoteApiKullanimiState createState() => _RemoteApiKullanimiState();
}

class _RemoteApiKullanimiState extends State<RemoteApiKullanimi> {
 // Gonderi gonderi;
  Future<List<Gonderi>> _gonderiGetir() async{
    var response= await http.get("https://jsonplaceholder.typicode.com/posts");

    if(response.statusCode==200){
      // gelen kod 200 olurssa demekki başarılı bir şekilde bağlanılmıştır
       // return Gonderi.fromJsonMap(json.decode(response.body));
      return (json.decode(response.body) as List).map((tekGonderiMap) => Gonderi.fromJsonMap(tekGonderiMap)).toList();

    }else{
      // 200 dışında kodlar ekrana çıkarsa demekki hata çıkmış 404 gibi
      throw Exception("Bağlanamadık ${response.statusCode}");
    }

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Remote Api"),),
      body: FutureBuilder(future: _gonderiGetir(),builder: (BuildContext context, AsyncSnapshot<List<Gonderi>> snapshot){
        if(snapshot.hasData){
          return ListView.builder(itemCount: snapshot.data.length,itemBuilder:(context,index){
            return Padding(
              padding: EdgeInsets.all(5),
              child: Card(

                  elevation: 12,
                child: Column(
                  children: [
                    Center(child: Text(snapshot.data[index].title)),
                    SizedBox(height: 12,),
                    Center(child: Text(snapshot.data[index].body)),
                    SizedBox(height: 12,),
                    CircleAvatar(child: Text(snapshot.data[index].id.toString()),),
                  ],
                ),

              ),
            );
          } );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }
}

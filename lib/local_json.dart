import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:json_http/models/Araba.dart';

class LocalJsonKullanimi extends StatefulWidget {
  @override
  _LocalJsonKullanimiState createState() => _LocalJsonKullanimiState();
}

class _LocalJsonKullanimiState extends State<LocalJsonKullanimi> {
  List<Araba> tumArabalar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // veriKaynaginiOku().then((value) {
    //   setState(() {
    //     tumArabalar = value;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local JSON Kullanımı"),
      ),
      body: Container(
              child: FutureBuilder(future: veriKaynaginiOku(),builder: (context,sonuc){

                if(sonuc.hasData){
                  // başarılı ise
                  tumArabalar=sonuc.data;

                  return  ListView.builder(
                    itemBuilder: (context, indetx) {
                      return ListTile(
                        title: Text(tumArabalar[indetx].araba_adi),
                        subtitle: Text(tumArabalar[indetx].model[1].fiyat.toString()),
                      );
                    },
                    itemCount: tumArabalar.length,
                  );
                } else{
                  return Center(child: CircularProgressIndicator(),);
                }

              }),
            )

    );
  }

// @override
// Widget build(BuildContext context) {
//
//   return Scaffold(
//     appBar: AppBar(title: Text("Local JSON Kullanımı"),),
//     body: tumArabalar !=null ? Container(
//       child: ListView.builder(itemBuilder: (context,indetx){
//         return ListTile(
//           title: Text(tumArabalar[indetx]["araba_adi"]),
//           subtitle: Text(tumArabalar[indetx]["ulke"]),
//         );
//       },itemCount: tumArabalar.length,),
//     ) : Center(child: CircularProgressIndicator(),),
//   );
// }

  Future<List> veriKaynaginiOku() async {
    // Birinci Yöntem
    // Future<String> jsonOku=DefaultAssetBundle.of(context).loadString("assets/data/araba.json");
    // jsonOku.then((okunanJson) {
    //   debugPrint(okunanJson);
    //   return okunanJson;
    // } );

    // İkinci Yöntem async eklememiz gerekiyor metod sonuna awaitin çalışması için
    var gelenJson = await DefaultAssetBundle.of(context)
        .loadString("assets/data/araba.json");
    debugPrint(gelenJson);

    List<Araba> arabaListesi =  (json.decode(gelenJson) as List).map((mapYapisi) => Araba.fromJsonMap(mapYapisi)).toList();// decode  gelen stringi parçalayıp json formatına dönüştürür
    print("Toplam Araba Sayısı : " + arabaListesi.length.toString());
    for (int i = 0; i < arabaListesi.length; i++) {
      print("Marka : " + arabaListesi[i].araba_adi.toString());
      print("Ülkesi : " + arabaListesi[i].ulke.toString());
    }

    return arabaListesi;
  }
}

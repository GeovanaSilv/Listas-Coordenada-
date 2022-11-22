import 'package:flutter/material.dart';
import 'ctcdata.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:location/location.dart';



Future<List<ctcData>> fetchData() async {
  var response = await http.get(
      Uri.parse("https://www.slmm.com.br/CTC/ctcApi.php"),
      headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    // print(response.body);
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new ctcData.fromJson(data)).toList();
  } else {
    throw Exception('Erro inesperado....');
  }
}

class listacoord extends StatefulWidget {
  const listacoord({Key? key}) : super(key: key);

  @override
  _listacoordState createState() => _listacoordState();
}

class _listacoordState extends State<listacoord> {
 
  late Future<List<ctcData>> futureData;
  
  


  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }
  
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("listagem"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<List<ctcData>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ctcData> data = snapshot.data!;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                        color: Color.fromARGB(255, 176, 170, 247),
                            child: ListTile(
                              title: Text(data[index].ra),
                                trailing: Row(mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.bolt_rounded,color: Colors.yellowAccent,),
                                  IconButton(onPressed: (){
                    
                                  
              
           
           
                                  }, icon: const Icon(Icons.favorite),color: Colors.red,)
                      ],),
                           
                               
                                ));
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // by default
                return CircularProgressIndicator();
              }),
        ));
  }
}

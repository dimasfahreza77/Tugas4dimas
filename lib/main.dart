import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'details.dart';
import 'newdata.dart';

void main() {
  runApp(MaterialApp(
    title: "API Test",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
    ),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List> data;

  @override
  void initState() {
    super.initState();
    data = fetchData();
  }

  Future<List> fetchData() async {
    final response = await http.get(
        Uri.parse('http://192.168.43.213/restapi/list.php')); // Ganti URL sesuai dengan API Anda.
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("PHP MySQL CRUD"),
        ),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => NewData(),
          ),
        ),
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data available');
          } else {
            return Items(list: snapshot.data!);
          }
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  final List list;

  Items({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.text_snippet_outlined),
          title: Text(list[index]['title']),
          subtitle: Text(list[index]['content']),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Details(list: list, index: index),
          )),
        );
      },
    );
  }
}

 import 'package:flutter/cupertino.dart';
 import 'package:flutter/material.dart';
 import 'editdata.dart';
 import 'main.dart';
 import 'package:http/http.dart' as http;

 class Details extends StatefulWidget {
 List list;
 int index;
 Details({required this.list, required this.index});
 @override
 _DetailsState createState() => _DetailsState();
 }
 class _DetailsState extends State<Details> {
 void delete() {
 var url = Uri.parse('http://192.168.43.213/restapi/delete.php'); //deletion api
 http.post(url, body: {'id': widget.list[widget.index]['id']});
 }
 void confirm() {AlertDialog alertDialog = AlertDialog(
 content: const Text("Are You Sure?"), //confi rming the deletion of record
 actions: [
 MaterialButton(
 child: const Text("YES DELETE"),
 onPressed: () {
 delete();
 Navigator.of(context).push(
 MaterialPageRoute(builder: (BuildContext context) => Home()));
 },
 ),
 MaterialButton(
 child: const Text("NO.."),
 onPressed: () {},
 ),
 ],
 );
 showDialog(builder: (context) => alertDialog, context: context);
 }
@override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar (
 title: Center(child: Text('${widget.list[widget.index]['title']}')),
 shape: const BeveledRectangleBorder(
 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:
 Radius.circular(20))
 ),
 ),
 body: Center(child: Column(
 children: [
 const SizedBox(height: 20,),
 Text(
 widget.list[widget.index]['title'],
 style: const TextStyle(fontSize: 20.0),
 ),
 const SizedBox(height: 20,),
 Text(
 widget.list[widget.index]['content'],
 ),
 const SizedBox(height: 100,),
 Row(children: [
 Container(
 padding: const EdgeInsets.all(10),
 child: MaterialButton(
 child: const Text("Edit Data"),
 color:  Colors.amber,
 onPressed: () => Navigator.of(context).push(
 MaterialPageRoute(
 builder: (BuildContext context) =>
 Edit(list: widget.list, index: widget.index)),
 ),
 )
 ),
 Container(
 padding: const EdgeInsets.all(10),
 child: MaterialButton(
 child: const Text("Delete"),
 color:  Colors.amber,
 onPressed: (){confirm();}
 )
 ),
 ],)
 ],
 ),)
 );
 }
 }
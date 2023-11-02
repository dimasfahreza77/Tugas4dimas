import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  final List list;
  final int index;

  Edit({Key? key, required this.list, required this.index}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  late TextEditingController title;
  late TextEditingController content;

  void editData() {
    var url = Uri.parse('http://192.168.43.213/restapi/update.php'); // update api calling
    http.post(url, body: {
      'id': widget.list[widget.index]['id'],
      'title': title.text,
      'content': content.text
    });
  }

  @override
  void initState() {
    title = TextEditingController(text: widget.list[widget.index]['title']);
    content = TextEditingController(text: widget.list[widget.index]['content']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Edit Data ${widget.list[widget.index]['title']}"),
        ),
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: title,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Title',
                hintText: 'Enter Title',
                prefixIcon: Icon(Icons.title),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              maxLines: 5,
              controller: content,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Content',
                hintText: 'Enter Content',
                prefixIcon: Icon(Icons.text_snippet_outlined),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: MaterialButton(
              child: const Text("Edit Data"),
              color: Colors.amber,
              onPressed: () {
                editData();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => Home()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

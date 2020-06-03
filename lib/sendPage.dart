import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadPage extends StatefulWidget {
  UploadPage({Key key, this.url}) : super(key: key);

  final String url;

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  dynamic data;
  Modelproverb probs;
  var isLoading = true;

  Future<dynamic> getData() async {
    setState(() {
      isLoading = true;
    });
    var response = await http.get(Uri.encodeFull("http://10.0.2.2:5000/get"),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      probs = Modelproverb.fromJson(data);
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }

    print(data);
    print(probs.proverb[0]);

    return "successful";
  }

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  String state = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        title: Text('Welcome to Machine Learning'),
        backgroundColor: Colors.orange,
        elevation: 5,
      ),
      body: isLoading
          ? Center(
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                color: Colors.orange,
                elevation: 5,
                textColor: Colors.white,
                child: new Text("Get Result"),
                onPressed: getData,
              ),
            )
          : ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  title: Text('Proverb on detected object in the image',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  subtitle: new Text(probs.proverb[0],
                      style: TextStyle(color: Colors.black, fontSize: 25)),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          var file = await ImagePicker.pickImage(source: ImageSource.gallery);
          var res = await uploadImage(file.path, widget.url);
          setState(() {
            state = res;
            print(res);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Modelproverb {
  dynamic proverb;

  Modelproverb(this.proverb);

  Modelproverb.fromJson(Map<dynamic, dynamic> json) : proverb = json['prob'];

  Map<dynamic, dynamic> toJson() => {
        'prob': proverb,
      };
}

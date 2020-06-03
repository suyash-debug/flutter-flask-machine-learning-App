import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'sendPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter File Upload Example',
      home: StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  void switchScreen(str, context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => UploadPage(url: str)));
  @override
  Widget build(context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        appBar: AppBar(
          title: Text('Flutter File Upload Example'),
          backgroundColor: Colors.orange,
          elevation: 5,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text("Insert the URL that will connect you to the local server",
                  style: Theme.of(context).textTheme.headline),
              TextField(
                controller: controller,
                onSubmitted: (str) => switchScreen(str, context),
              ),
              FlatButton(
                child: Text("Take me to the upload screen"),
                onPressed: () => switchScreen(controller.text, context),
              )
            ],
          ),
        ));
  }
}

// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(new MaterialApp(
//     home: new HomePage(),
//   ));
// }

// class HomePage extends StatefulWidget {
//   @override
//   HomePageState createState() => new HomePageState();
// }

// class HomePageState extends State<HomePage> {
//   dynamic data;
//   Modelproverb probs;
//   var isLoading = true;

//   Future<dynamic> getData() async {
//     setState(() {
//       isLoading = true;
//     });
//     var response = await http.get(Uri.encodeFull("http://10.0.2.2:5000/get"),
//         headers: {"Accept": "application/json"});
//     if (response.statusCode == 200) {
//       data = json.decode(response.body);
//       probs = Modelproverb.fromJson(data);
//       setState(() {
//         isLoading = false;
//       });
//     } else {
//       throw Exception('Failed to load photos');
//     }

//     print(data);
//     print(probs.proverb[0]);

//     return "successful";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Fetch Data JSON"),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: RaisedButton(
//           child: new Text("Fetch Data"),
//           onPressed: getData,
//         ),
//       ),
//       body: isLoading
//           ? Center(
//               child: Text('Best Machine Learning Project'),
//             )
//           : ListView.builder(
//               itemCount: 1,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   contentPadding: EdgeInsets.all(10.0),
//                   title: new Text(probs.proverb[0]),
//                 );
//               },
//             ),
//     );
//   }
// }

// class Modelproverb {
//   dynamic proverb;

//   Modelproverb(this.proverb);

//   Modelproverb.fromJson(Map<dynamic, dynamic> json) : proverb = json['prob'];

//   Map<dynamic, dynamic> toJson() => {
//         'prob': proverb,
//       };
// }

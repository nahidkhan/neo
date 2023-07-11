import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() => runApp(const MyApp());
List a = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<dynamic> data() async {
    return await fetchPosts();
  }

  @override
  void initState() {
    data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: data(),
          builder: (BuildContext buildContext, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext buildContext, int index) {
                    return Card(
                      margin: const EdgeInsets.all(16),
                      elevation: 0.9,
                      surfaceTintColor: Colors.cyan,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(snapshot.data[index]['name'] + "Name: "),
                          const Spacer(
                            flex: 1,
                          ),
                          Text(snapshot.data[index]['address']['street'] +
                              "Location: "),
                          Expanded(
                              child: Image.network(
                            a[index]["download_url"],
                            height: 150,
                            width: 150,
                          ))
                        ],
                      ),
                    );
                  });
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

fetchPosts() async {
  Response response =
      await get(Uri.https('jsonplaceholder.typicode.com', 'users'));
  Response imgResponse = await get(Uri.https("picsum.photos", "v2/list"));
  final decoded = jsonDecode(response.body);
  a = jsonDecode(imgResponse.body);
  return decoded;
}

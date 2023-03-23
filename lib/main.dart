import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lec/student.dart';
import 'package:dio/dio.dart';
import 'airline.dart';

void main() {
  runApp(MaterialApp(
    home: demo(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<student> studentlist = [];

  getdata() async {
    var url =
        Uri.parse('https://mocki.io/v1/d4867d8b-b5d5-4a48-a4ab-79131b5809b8');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    List list = jsonDecode(response.body);
    list.forEach((element) {
      print(element);
      setState(() {
        studentlist.add(student.fromJson(element));
      });
    }); // print(list);
  }
  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: studentlist.length > 0
          ? ListView.builder(
              itemBuilder: (context, index) {
                student s = studentlist[index];
                return ListTile(
                  title: Text("${s.name}"),
                  subtitle: Text("${s.city}"),
                );
              },
              itemCount: studentlist.length,
            )
          : CircularProgressIndicator(),
    );
  }
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  List<Data> data = [];

  getdata() async {

    try {
      var response = await Dio().get('https://reqres.in/api/users?page=2');
      Map<String, dynamic> m=response.data;
      print(m);
      airline air = airline.fromJson(m);
      setState(() {
        data = air.data!;
      });
    } catch (e) {
      print(e);
    }

    // var url = Uri.parse('https://reqres.in/api/users?page=2');
    // var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    //
    // Map<String, dynamic> m = jsonDecode(response.body);
    // airline air = airline.fromJson(m);
    // setState(() {
    //   data = air.data!;
    // });
    // print(list);
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: data.length > 0
          ? ListView.builder(
              itemBuilder: (context, index) {
                Data d = data[index];
                return Column(
                  children: [
                    ListTile(title: Image.network("${d.avatar}")),
                    ListTile(
                      title: Text("${d.id}"),
                    ),
                    ListTile(
                      title: Text("${d.email}"),
                    ),
                    ListTile(
                      title: Text("${d.firstName}"),
                    ),
                    ListTile(
                      title: Text("${d.lastName}"),
                    ),
                  ],
                );
              },
              itemCount: data.length,
            )
          : CircularProgressIndicator(),
    );
  }
}

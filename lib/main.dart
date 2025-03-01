import 'package:flutter/material.dart';
import 'package:local_database/update.dart';
import 'package:sqflite/sqflite.dart';

import 'LocalDb.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      LocalDatabase().readalldata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(()async {
              await LocalDatabase().readalldata();
            });
          },
          child: Icon(Icons.refresh),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        // icon: Icon(Icons.input),
                        hintText: 'Enter your text',
                        labelText: 'Input',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String inputText = _textController.text;

                      await LocalDatabase().addDataLocaly(Name: inputText);
                      await LocalDatabase().readalldata();
                      setState(() {});
                    },
                    child: const Text('Submit'),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    controller: ScrollController(),
                    itemCount: WholeDataList.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          height: 85,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(WholeDataList[index]['Name']),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateData(
                                                      id: WholeDataList[index]
                                                      ['id'])));
                                    },
                                    icon:
                                    Icon(Icons.edit, color: Colors.green)),
                                IconButton(
                                    onPressed: () async{
                                      await LocalDatabase().deleteData(
                                          id: WholeDataList[index]
                                          ['id']);
                                      await LocalDatabase().readalldata();
                                      setState(() {

                                      });
                                    },
                                    icon: Icon(Icons.delete,
                                        color: Colors.red)),
                              ]));
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

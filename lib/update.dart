import 'package:flutter/material.dart';

import 'LocalDb.dart';

class UpdateData extends StatefulWidget {
  final id;
  const UpdateData({super.key, required this.id});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  TextEditingController fullname= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  controller: fullname,
                  decoration: const InputDecoration(
                    // icon: Icon(Icons.input),
                    hintText: 'Enter your name',
                    // labelText: 'Input',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String inputText = fullname.text;

                    await LocalDatabase().updateData(Name: inputText,id:widget.id);
                    await LocalDatabase().readalldata();
                    Navigator.pop(context);
                    },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}


import 'package:flutter/material.dart';
import 'package:form/secondpage.dart';

import 'models/information.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Form',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Form'),
      routes: {'/second_page': (context) => const SecondPage()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String gender = "null";
  late Info person;
  String dropdownValue = 'Ahmedabad';
  late String name;
  late String number;
  bool _showError = false;
  final _formKey = GlobalKey<FormState>();
  var items = ["Ahmedabad", "Surat", "Vadodara"];

  void _handleGenderChange(String? value) {
    setState(() {
      gender = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(

                  decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Enter Your Name',
                      labelText: 'Name'),
                  onChanged: (value) {
                    name = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.dialpad),
                        hintText: 'Enter your Number',
                        labelText: 'PhoneNumber'),
                    onChanged: (value) {
                      number = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Number";
                      }
                      if (value.length < 10) {
                        return "Please enter a valid Number";
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Radio<String>(
                                value: "Male",
                                onChanged: _handleGenderChange,
                                groupValue: gender),
                            const Text(
                              "Male",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Radio<String>(
                                value: "Female",
                                onChanged: _handleGenderChange,
                                groupValue: gender),
                            const Text(
                              "Female",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Radio<String>(
                                value: "Other",
                                onChanged: _handleGenderChange,
                                groupValue: gender),
                            const Text(
                              "Neither",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _showError
                    ? const Text(
                      "Please select a value ",
                      style: TextStyle(color: Colors.red),
                    )
                    : Container(),
                DropdownButton(
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String e) {
                      return DropdownMenuItem(
                        child: Text(
                          e,
                          style: const TextStyle(color: Colors.green),
                        ),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          person = Info(
                              city: dropdownValue,
                              number: number,
                              name: name,
                              gender: gender);
                          if (gender == "null") {
                            _showError = true;
                            return;
                          }
                          Navigator.pushNamed(context, '/second_page',
                              arguments: person);
                        }
                      });
                    },
                    style: TextButton.styleFrom(
                        side: const BorderSide(color: Colors.green)),
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

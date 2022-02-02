import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
   File? imageFile ;


  String gender = "null";
  late Info person;
  String dropdownValue = 'Ahmedabad';
  late String name;
  late String number;
  late String email;
  bool _showError = false;
  final _formKey = GlobalKey<FormState>();
  var items = ["Ahmedabad", "Surat", "Vadodara"];
  bool _ischecked = false;
  bool _showErrorchckbx = false;

  void _handleGenderChange(String? value) {
    setState(() {
      gender = value!;
    });
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    // String pattern = "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'abc@email.com',
                          labelText: 'E-mail'),
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) => validateEmail(value!)),
                  TextFormField(
                      // autovalidateMode: AutovalidateMode.always,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  TextFormField(
                      maxLines: 3,
                      // textAlignVertical: TextAlignVertical.top,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.home),
                          hintText: 'Enter your address',
                          labelText: 'Address'),
                      onChanged: (value) {
                               var address = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your Address";
                        }
                      }
                      ),
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
                                style: TextStyle(
                                    fontSize: 12, color: Colors.green),
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
                                style: TextStyle(
                                    fontSize: 12, color: Colors.green),
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
                                style: TextStyle(
                                    fontSize: 12, color: Colors.green),
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
                  Container(
                      child: imageFile == null
                          ? Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton(
                                    color: Colors.greenAccent,
                                    onPressed: () {
                                      _getFromGallery();
                                    },
                                    child: Text("PICK FROM GALLERY"),
                                  ),
                                  Container(
                                    height: 40.0,
                                  ),
                                  RaisedButton(
                                    color: Colors.lightGreenAccent,
                                    onPressed: () {
                                      _getFromCamera();
                                    },
                                    child: Text("PICK FROM CAMERA"),
                                  )
                                ],
                              ),
                            )
                          : Container(
                             color: Colors.white,
                              child: Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                              ),
                            )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: _ischecked,
                          onChanged: (value) {
                            setState(() {
                              _ischecked = value!;
                              if (_ischecked) _showErrorchckbx = false;
                            });
                          }),
                      const Text("Please check this box to continue")
                    ],
                  ),
                  _showErrorchckbx
                      ? const Text(
                          "Please check the above box to Continue ",
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
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
                                gender: gender, imageFile: imageFile!);
                            if (gender == "null") {
                              _showError = true;
                              return;
                            }
                            if (_ischecked == false) {
                              _showErrorchckbx = true;
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
      ),
    );
  }

  // ImagePicker newimg = ImagePicker();
  _getFromGallery() async {
    print("getfromgallery Started");
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      maxWidth: 200,
    );
    
    if (pickedFile != null) {

      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    print("cool02");
  }

  _getFromCamera() async {

    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 100,
      maxWidth: 100,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}

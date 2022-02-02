import 'package:flutter/material.dart';

import 'models/information.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Info person = ModalRoute.of(context)!.settings.arguments as Info;
    return Scaffold(
        body: Center(
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name : ${person.name}"),
            const SizedBox(
              height: 5,
            ),
            Text("Number : ${person.number}"),
            const SizedBox(
              height: 5,
            ),
            Text("gender : ${person.gender}"),
            const SizedBox(
              height: 5,
            ),
            Text("city : ${person.city}"),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    ));
  }
}

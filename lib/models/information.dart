import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Info {
  late String name;
  late String number;
  late String city;
  late String gender;
  late File imageFile;

  Info(
      {required this.name,
      required this.number,
      required this.gender,
      required this.city,
      required this.imageFile});
}

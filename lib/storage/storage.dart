import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

final firestoreInstance = FirebaseFirestore.instance;
String? res;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('test/$fileName').putFile(file);
      final storageRef = FirebaseStorage.instance.ref();
      Reference ref = storageRef.child("/photo.jpg");
      var uploadTask = ref.putFile(file);

      var dowurl = await (await uploadTask).ref.getDownloadURL();
      final url = dowurl;

      print(url);

      firestoreInstance.collection('userd').add({
        "name": "piyush",
        "age": 20,
        "email": "piyush@gmail.com",
        "image": url,
        "address": {
          "street": "street 24",
          "city": "surat",
        }
      }).then((value) {
        res = value.id;
      });
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}

///
///
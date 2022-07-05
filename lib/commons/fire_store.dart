import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

final firestoreInstance = FirebaseFirestore.instance;
String? res;

class Stor {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String? dowurl;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('test/$fileName').putFile(file);
      final storageRef = FirebaseStorage.instance.ref();
      Reference ref = storageRef.child("/photo.jpg");
      var uploadTask = ref.putFile(file);


      dowurl = await (await uploadTask).ref.getDownloadURL();
      

      print(dowurl);

    
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}

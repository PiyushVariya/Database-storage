
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class Providers extends ChangeNotifier {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('User-Detail');

  final ImagePicker picker = ImagePicker();
  String? imagePath;

  Future<XFile> selectImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    imagePath = image!.path;
    notifyListeners();
    return image;
  }

  Future<List<Object?>> getUserList() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
        notifyListeners();

    return allData;
  }
}

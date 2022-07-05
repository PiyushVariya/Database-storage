import 'package:database/storage/storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageStorage extends StatefulWidget {
  const ImageStorage({Key? key}) : super(key: key);

  @override
  State<ImageStorage> createState() => _ImageStorageState();
}

class _ImageStorageState extends State<ImageStorage> {
  // FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  // FirebaseStorage storageRef = FirebaseStorage.instance;
  // String collectionName = 'Image';

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Upload Image'),
              onPressed: () async {
                // addImage();
                final results = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg'],
                );
                if (results == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No file Selected'),
                    ),
                  );
                  return null;
                }

                final path = results.files.single.path!;
                final fileName = results.files.single.name;

                storage
                    .uploadFile(path, fileName)
                    .then((value) => print(fileName));
              },
            )
          ],
        ),
      ),
    );
  }
}















































///Pick the image in local storage and store the image in storage database 

///import 'package:database/storage/storage.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';

// class ImageStorage extends StatefulWidget {
//   const ImageStorage({Key? key}) : super(key: key);

//   @override
//   State<ImageStorage> createState() => _ImageStorageState();
// }

// class _ImageStorageState extends State<ImageStorage> {
//   @override
//   Widget build(BuildContext context) {
//     final Storage storage = Storage();
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               child: const Text('Upload Image'),
//               onPressed: () async {
//                 final results = await FilePicker.platform.pickFiles(
//                   allowMultiple: false,
//                   type: FileType.custom,
//                   allowedExtensions: ['png', 'jpg'],
//                 );
//                 if (results == null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('No file Selected'),
//                     ),
//                   );
//                   return null;
//                 }

//                 final path = results.files.single.path!;
//                 final fileName = results.files.single.name;

//                 storage
//                     .uploadFile(path, fileName)
//                     .then((value) => print('Done'));
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

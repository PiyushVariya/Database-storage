import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database/storage/storage.dart';
import 'package:database/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.image,
      required this.userName,
      required this.emailid})
      : super(key: key);

  final String userName;
  final String emailid;
  final String image;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // void _onTab() {
  //   firestoreInstance.collection('User-Detail').get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       print(result.data());
  //       print(result.data()['User Name']);
  //     });
  //   });
  // }
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('User-Detail');

  Future<List<Object?>> getUserList() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;

    // print(allData);
  }

  @override
  void initState() {
    print(_collectionRef);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 30.0),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
                future: getUserList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data[index]["User Name"]);
                          return ListTile(
                            leading: ClipOval(
                              child: CircleAvatar(
                                radius: 40.0,
                                backgroundColor: Clr.white,
                                child: Image.network(widget.image),
                              ),
                            ),
                            title: Text("${snapshot.data[index]["User Name"]}"),
                            subtitle:
                                Text("${snapshot.data[index]["Email-id"]}"),
                          );
                        }),
                  );
                }),
            ElevatedButton(
                onPressed: () {
                  // _onTab();
                  print(_collectionRef.get());
                },
                child: const Text('Get Data'))
          ],
        ),
      ),
    );
  }
}




































// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // FirebaseDatabase db = FirebaseDatabase.instance;
//   final firestoreInstance = FirebaseFirestore.instance;
//   String? res;

//   // void _onpressedAddData() {
//   //   final firebaseUser = FirebaseAuth.instance.currentUser;
//   //   firestoreInstance.collection('users').doc(firebaseUser?.uid).set({
//   //     "name": "piyush",
//   //     "age": 20,
//   //     "email": "piyush@gmail.com",
//   //     "address": {
//   //       "street": "street 24",
//   //       "city": "surat",
//   //     }
//   //   }).then((value) {
//   //     // print(value.id);
//   //   });
//   // }

//   Future<void> onPressedUpdateData() async {
//     await firestoreInstance
//         .collection('user')
//         .doc(res)
//         .update({"name": "yes"}).then((_) {
//       print('update suceesfully');
//     });
//   }

//   // addData() {
//   //   String? key = db.ref().push().key;
//   //   db.ref('car').child('Team 1').set({
//   //     'name': 'car1',
//   //     'description': 'car team 1',
//   //     // 'key': key,
//   //   });
//   //   db.ref('car').child('Team 2').set({
//   //     'name': 'car2',
//   //     'description': 'car team 2',
//   //     // 'key': key,
//   //   });
//   //   db.ref('car').child('Team 3').set({
//   //     'name': 'car3',
//   //     'description': 'car team 3',
//   //     // 'key': key,
//   //   });
//   //   db.ref('car').child('Team 4').set({
//   //     'name': 'car4',
//   //     'description': 'car team 4',
//   //     // 'key': key,
//   //   });
//   //   db.ref('car').child('Team 5').set({
//   //     'name': 'car5',
//   //     'description': 'car team 5',
//   //     // 'key': key,
//   //   });
//   // }

//   // updateData() {
//   //   db.ref('car').child('Team 1').update({
//   //     'name': 'piyush',
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           // crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               child: const Text('Add Data'),
//               onPressed: () {
//                 firestoreInstance.collection('user').add({
//                   "name": "piyush",
//                   "age": 20,
//                   "email": "piyush@gmail.com",
//                   "address": {
//                     "street": "street 24",
//                     "city": "surat",
//                   }
//                 }).then((value) {
//                   res = value.id;
//                 });
//               },
//             ),
//             ElevatedButton(
//                 child: const Text('Update Data'),
//                 onPressed: () async {
//                   print(res);
//                   await onPressedUpdateData();
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database/commons/commons.dart';
import 'package:database/commons/fire_store.dart';
import 'package:database/home_page.dart';
import 'package:database/provider/auth_provider.dart';
import 'package:database/utils/colors.dart';
import 'package:database/utils/strings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  Stor path = Stor();
  String? pathI;

  ///Image Picker

  final userController = TextEditingController();
  final emailController = TextEditingController();
  final imageController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final cityController = TextEditingController();
  final FirebaseStorage storage = FirebaseStorage.instance;
  String? dowurl;
  final _key = GlobalKey<FormState>();

  ///provider
  Providers pro = Providers();

  ///DropDown
  String? dropDownValue;

  @override
  void initState() {
    pro = Provider.of<Providers>(context, listen: false);
    // pro.selectImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Stream<QuerySnapshot> userDetail =
    // FirebaseFirestore.instance.collection('User-Detail').snapshots();

    // final Stor stor = Stor();
    return Scaffold(
      backgroundColor: Clr.white,
      appBar: appBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    circuleImage(),
                  ],
                ),
                Form(
                  key: _key,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 40.0),
                    child: Column(
                      children: [
                        userName(),
                        const SizedBox(height: 20.0),
                        email(),
                        const SizedBox(height: 20.0),
                        password(),
                        const SizedBox(height: 20.0),
                        age(),
                        const SizedBox(height: 20.0),
                        city(),
                        const SizedBox(height: 20.0),
                        dropDownBtn(),
                        const SizedBox(height: 20.0),
                        submitBtn(context)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDownBtn() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Clr.grey),
        contentPadding: const EdgeInsets.only(left: 40.0),
        filled: true,
        // hintText: widget.hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(50.0),
            right: Radius.circular(50.0),
          ),
        ),
      ),
      value: dropDownValue,
      hint: const Text(Txt.selectGender),
      icon: const Padding(
        padding: EdgeInsets.only(right: 18.0),
        child: Icon(Icons.arrow_drop_down,size: 30.0,),
      ),
      onChanged: (dynamic newValue) {
        setState(() {
          dropDownValue = newValue!;
        });
      },
      items: const [
        DropdownMenuItem(
          child: Text('Male'),
          value: 'Male',
        ),
        DropdownMenuItem(
          child: Text('Female'),
          value: 'Female',
        ),
      ],
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Clr.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Clr.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget circuleImage() {
    return GestureDetector(onTap: () async {
      await pro.selectImage();
    }, child: Consumer<Providers>(
      builder: (context, value, child) {
        return CircleAvatar(
          radius: 52.0,
          backgroundColor: Clr.pink,
          child: ClipOval(
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: Clr.white,
              child: value.imagePath != null
                  ? Image.file(File('${value.imagePath}'))
                  : Image.network('https://i.imgur.com/sUFH1Aq.png'),
              //  pro.imagePath != null
              //     ? Image.file(
              //         File(pro.imagePath.toString()),
              //       )
              //     : Image.network('https://i.imgur.com/sUFH1Aq.png')),
            ),
          ),
        );
      },
    ));
  }

  Widget submitBtn(BuildContext context) {
    return ElevatedButton(
      child: const Text(Txt.submit),
      onPressed: () async {
        // _onTab();
        File file = File(pro.imagePath.toString());

        await storage.ref('test/${pro.imagePath}').putFile(file);
        final storageRef = FirebaseStorage.instance.ref();
        Reference ref = storageRef.child("/photo.jpg");
        var uploadTask = ref.putFile(file);

        dowurl = await (await uploadTask).ref.getDownloadURL();

        if (_key.currentState!.validate()) {
          FirebaseFirestore.instance.collection('User-Detail').add({
            "User Name": userController.text,
            "Email-id": emailController.text,
            "Password": passwordController.text,
            "Age": ageController.text,
            "City": cityController.text,
            "image": dowurl,
            "Gender": dropDownValue,
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      },
    );
  }

  CustomeTextField city() {
    return CustomeTextField(
      hintText: Txt.city,
      controller: cityController,
      validator: (value) => value!.isEmpty ? 'city not vaild' : null,
    );
  }

  CustomeTextField age() {
    return CustomeTextField(
      hintText: Txt.age,
      controller: ageController,
      validator: (value) => value!.isEmpty ? 'age not vaild' : null,
    );
  }

  CustomeTextField password() {
    return CustomeTextField(
      hintText: Txt.pass,
      controller: passwordController,
      validator: (value) => value!.isEmpty ? 'password not vaild' : null,
    );
  }

  CustomeTextField email() {
    return CustomeTextField(
      hintText: Txt.email,
      controller: emailController,
      validator: (value) => value!.isEmpty ? 'email not vaild' : null,
    );
  }

  CustomeTextField userName() {
    return CustomeTextField(
      hintText: Txt.user,
      controller: userController,
      validator: (value) => value!.isEmpty ? 'user name  not vaild' : null,
    );
  }
}//DropdownButton(
                        //   value: dropDownValue,
                        //   hint: const Text('Select a Gender'),
                        //   icon: const Icon(Icons.arrow_drop_down),
                        //   onChanged: (dynamic newValue) {
                        //     setState(() {
                        //       dropDownValue = newValue!;
                        //     });
                        //   },
                        //   items: const [
                        //     DropdownMenuItem(
                        //       child: Text('Male'),
                        //       value: '1',
                        //     ),
                        //     DropdownMenuItem(
                        //       child: Text('Female'),
                        //       value: '2',
                        //     ),
                        //   ],
                        // )

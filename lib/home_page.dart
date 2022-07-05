import 'package:database/edit_screen.dart';
import 'package:database/provider/auth_provider.dart';
import 'package:database/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: fabBtn(context),
      body: SafeArea(
        child: Column(
          children: [
            // futureBuild(),
            futureBuild(),
            getDataBtn(),
          ],
        ),
      ),
    );
  }

  Widget futureBuild() {
    return Consumer<Providers>(
      // future: getUserList(),
      builder: (context, value, child) {
        return FutureBuilder(
          future: value.getUserList(),
          builder: (context, snapshot) => listOfData(snapshot),
        );
      },
    );
  }

  FloatingActionButton fabBtn(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add, size: 30.0),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditScreen(),
          ),
        );
      },
    );
  }

  ElevatedButton getDataBtn() {
    return ElevatedButton(
        onPressed: () {
          // _onTab();
          // print(_collectionRef.get());
        },
        child: const Text('Get Data'));
  }

  Widget listOfData(AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.data == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              // print(snapshot.data[index]["image"]);
              return Column(
                children: [
                  // Text(snapshot.data[index]['image']),
                  ListTile(
                    leading: CircleAvatar(
                      child: ClipOval(
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Clr.white,
                          child: Image.network(snapshot.data[index]['image']),
                        ),
                      ),
                    ),
                    title: Text(
                        "${snapshot.data[index]["User Name"] ?? 'null'}"), //
                    subtitle:
                        Text("${snapshot.data[index]["Email-id"] ?? 'null'}"),
                  ),
                ],
              );
            }),
      );
    }
  }
}

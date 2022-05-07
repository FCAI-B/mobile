import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Bar'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('babies').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Text('Waiting');
            } else {
              return ListView(                
                children: snapshot.data.docs.map<Widget>((DocumentSnapshot doc) {
                  return ListTile(
                    title: Text(doc.get('name')),
                    subtitle: Text(doc.get('votes').toString()),
                    onTap: () {
                      //TODO update the document to increase the votes
                    },
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}

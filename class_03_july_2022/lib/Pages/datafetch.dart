import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DataFetch extends StatefulWidget {
  const DataFetch({Key? key}) : super(key: key);

  @override
  State<DataFetch> createState() => _DataFetchState();
}

class _DataFetchState extends State<DataFetch> {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['full_name']),
              subtitle: Text(data['company']),
            );
          }).toList(),
        );
         }


      },
    ),
        // child: FutureBuilder<DocumentSnapshot>(
        //   future: users.doc("avi05CsauGSz5M7mM8GT").get(),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     if (snapshot.hasData) {
        //       return Text("${snapshot.data['full_name']}");
        //     } else {
        //       return CircularProgressIndicator();
        //     }
        //     // if (snapshot.hasError) {
        //     //   return Text("Something went wrong");
        //     // }

        //     // if (snapshot.hasData && !snapshot.data!.exists) {
        //     //   return Text("Document does not exist");
        //     // }

        //     // if (snapshot.connectionState == ConnectionState.done) {
        //     // }

        //     // return Text("loading");
        //   },
        // ),
      ),
    );
  }
}

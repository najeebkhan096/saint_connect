import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:saintconnect/Screens/CreateProfile.dart';
import 'package:saintconnect/Screens/HomePage.dart';
import 'package:saintconnect/Screens/welcome.dart';
import 'package:saintconnect/auth/auth.dart';
import 'package:saintconnect/module/myuser.dart';

class Wrapper extends StatelessWidget {

  static const routename = 'Wrapper';

  Future<bool> Check_position(String id) async {
    bool admin = false;
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print(element);
        Map<dynamic, dynamic> fetcheddata =
        element.data() as Map<dynamic, dynamic>;
        if (fetcheddata['userid'] == id) {
        admin= fetcheddata['profile_created'];
        Timestamp stamp = fetcheddata['date'];
        currentuser=MyUser(
          docid: element.id,
          created_profile: fetcheddata['profile_created'],
          email: fetcheddata['email'],
          uid: id,
          username: fetcheddata['username'],
           year: fetcheddata['year'],
          date: stamp.toDate(),
          qr_image: fetcheddata['QR_image'].toString(),
          payment: fetcheddata['payment']

        );
        }
      });
    });
    return admin;
  }

  @override
  Widget build(BuildContext context) {


    final authservice = Provider.of<AuthService>(context);


    return StreamBuilder(
        stream: authservice.user,
        builder: (_, AsyncSnapshot<MyUser?> snapshot) {
          final MyUser? user = snapshot.data;
          if(user!=null){
            currentuser=MyUser(
                uid: user.uid,
                username: user.username,
                email: user.email
            );
            user_id=user.uid!;

          }

          return user == null ? Welcome():

          FutureBuilder(
              future: Check_position(user.uid.toString()),

              builder: (BuildContext context, AsyncSnapshot snapshot) {

                return !snapshot.hasData  ?
                SpinKitCircle(

                  color: Colors.white,

                )

                    :

                snapshot.data==true?

                HomeScreen():

                Createprofile();

              });

        });
  }
}
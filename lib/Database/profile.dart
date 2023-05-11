import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saintconnect/module/MyProfile.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/module/view.dart';

class ProfileDatabase{

  Future update_profile_views({required List<ProfileView> ? profileviews,required String docid}) async {

    Map<String, dynamic> data = {
        'views': profileviews!.map((e) => {
          'date': e.date,
          'userid': e.userid,
        }   )   .toList()
    };

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');
    await collection.doc(docid).update(data);

  }
  
  Future update_visit_time({required List<ProfileView> ? profileviews,required String docid}) async {

    Map<String, dynamic> data = {
      'visit_time': profileviews!.map((e) => {
        'time': e.date,
        'userid': e.userid,
      }   )   .toList()
    };

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');
    await collection.doc(docid).update(data);

  }

  Future delete_profile({required String ? docid}) async {


    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');
    await collection.doc(docid).delete();

  }
  Future delete_card({required String ? docid}) async {


    CollectionReference collection =
    FirebaseFirestore.instance.collection('Cards');
    await collection.doc(docid).delete();

  }

}
ProfileDatabase profileDatabase=ProfileDatabase();

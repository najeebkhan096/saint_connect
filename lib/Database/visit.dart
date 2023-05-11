import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saintconnect/module/MyProfile.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/module/view.dart';
import 'package:saintconnect/module/visit_time.dart';

class Visit_Time_Database{

  Future update_visit_time({required List<VisitTime> ? time,required String docid}) async {

    Map<String, dynamic> data = {
      'visit_time': time!.map((e) => {
        'time': e.time,
        'userid': e.userid,
      }   )   .toList()
    };

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');
    await collection.doc(docid).update(data);

  }

}
Visit_Time_Database visittime_database=Visit_Time_Database();

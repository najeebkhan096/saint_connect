

class MyUser {
  final docid;
  final String ? uid;
  String ? imageurl;
   String ? email;
  String ? bgimage;
  String ? phone;
  String ? username;
  bool ? created_profile;
   bool ? year;
  bool ? payment;

  String ? qr_image;
  DateTime ? date;

  MyUser({
    this.payment,
    this.uid,
    this.email,
    this.username,
    this.imageurl,
    this.phone,
    this.docid,
    this.bgimage,
    this.created_profile,
    this.year,
    this.qr_image,
    this.date
  });

}

MyUser ? currentuser;


String ? user_id='';
String imageurl="";


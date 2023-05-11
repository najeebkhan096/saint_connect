// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:path/path.dart' as Path;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:saintconnect/Database/database.dart';
// import 'package:saintconnect/Screens/HomePage.dart';
// import 'package:saintconnect/constants.dart';
// import 'package:saintconnect/module/MyProfile.dart';
// import 'package:saintconnect/module/myuser.dart';
// import 'package:saintconnect/widgets/buildtext.dart';
// import 'package:saintconnect/widgets/createButton.dart';
// import 'package:saintconnect/widgets/wrapper.dart';
// class Edit_Team extends StatefulWidget {
//   static const routename="Edit_Team";
//
//   @override
//   State<Edit_Team> createState() => _Edit_TeamState();
// }
//
// class _Edit_TeamState extends State<Edit_Team> {
//   List<int> bgcolors=[
//     0xff000000,
//     0xffFFFFFF,
//     0xffF3B2FB,
//     0xff70CEE2,
//     0xff70E292,
//     0xffC4E270,
//     0xff3652D9,
//     0xff9936D9,
//     0xffD98D36,
//     0xffD936A3,
//     0xffDAC07A,
//   ];
//
//   List<String> social=[
//     'images/fb2.png',
//     'images/google.png',
//     'images/insta.webp',
//     'images/snapchat.png',
//     'images/twitter.png',
//     'images/whatsapp.png'
//   ];
//
//   Color pickerColor = Color(0xff443a49);
//   Color currentColor = Color(0xff443a49);
//
// // ValueChanged<Color> callback
//   void changeColor(Color color) {
//     setState(() => pickerColor = color);
//   }
//   void _pickcolor() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Pick a color!'),
//           content: SingleChildScrollView(
//             child: ColorPicker(
//               pickerColor: pickerColor,
//               onColorChanged: changeColor,
//             ),
//             // Use Material color picker:
//             //
//             // child: MaterialPicker(
//             //   pickerColor: pickerColor,
//             //   onColorChanged: changeColor,
//             //   showLabel: true, // only on portrait mode
//             // ),
//             //
//             // Use Block color picker:
//             //
//             // child: BlockPicker(
//             //   pickerColor: currentColor,
//             //   onColorChanged: changeColor,
//             // ),
//             //
//             // child: MultipleChoiceBlockPicker(
//             //   pickerColors: currentColors,
//             //   onColorsChanged: changeColors,
//             // ),
//           ),
//           actions: <Widget>[
//             ElevatedButton(
//               child: const Text('Got it'),
//               onPressed: () {
//                 setState(() => currentColor = pickerColor);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future uploadFilelist({List<File> ? mylist,String ? type,File ? myfile}) async {
//
//
//     if(mylist!=null){
//       for (int i = 0; i < mylist.length; i++) {
//         ref = firebase_storage.FirebaseStorage.instance
//             .ref()
//             .child('${"profile"}/${Path.basename(mylist[i].path)}');
//         await ref!.putFile(mylist[i]).whenComplete(() async {
//           await ref!.getDownloadURL().then((imageurl) {
//             if(imageurl!=null){
//
//               if(type=="images"){
//
//                 setState((){
//                   desired_profile!.images!.add(imageurl);
//                 });
//               }
//               else if(type=="accreditation"){
//                 setState((){
//                   desired_profile!.Accreditation!.add(imageurl);
//                 });
//
//               }
//               else if(type=="logo"){
//                 setState((){
//                   desired_profile!.logo!=imageurl;
//                 });
//
//               }
//               else if(type=="myprofile"){
//
//                 setState((){
//                   desired_profile!.profile_image=imageurl;
//                 });
//               }
//               else if(type=="bgimage"){
//
//                 setState((){
//                   desired_profile!.Backgroundimage=imageurl;
//                 });
//               }
//               else if(type=="video"){
//
//                 setState((){
//                   desired_profile!.video=imageurl;
//                 });
//               }
//
//
//
//
//
//             }
//           });
//         });
//       }
//     }
//     else{
//       print("khan baba"+myfile.toString());
//
//       ref = firebase_storage.FirebaseStorage.instance
//           .ref()
//           .child('${"profile"}/${Path.basename(myfile!.path)}');
//       await ref!.putFile(myfile).whenComplete(() async {
//         await ref!.getDownloadURL().then((imageurl) {
//           if(imageurl!=null){
//
//
//             if(type=="logo"){
//               setState((){
//                 desired_profile!.logo=imageurl;
//               });
//
//             }
//             else if(type=="images"){
//
//               setState((){
//                 desired_profile!.images!.add(imageurl);
//               });
//             }
//             else if(type=="profile"){
//
//               setState((){
//                 desired_profile!.profile_image=imageurl;
//               });
//             }
//             else if(type=="bgimage"){
//
//               setState((){
//                 desired_profile!.Backgroundimage=imageurl;
//               });
//             }
//             else if(type=="video"){
//
//               setState((){
//                 desired_profile!.video=imageurl;
//               });
//             }
//             if(type=="images"){
//
//               setState((){
//                 desired_profile!.images!.add(imageurl);
//               });
//             }
//             else if(type=="accreditation"){
//               setState((){
//                 desired_profile!.Accreditation!.add(imageurl);
//               });
//
//             }
//
//
//           }
//         });
//       });
//     }
//
//   }
//
//
//
//   final GlobalKey<FormState> _formKey = GlobalKey();
//
//   bool isloading=false;
//
//   Future<void> _submit() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//     _formKey.currentState!.save();
//     setState(() {
//       isloading=true;
//     });
//
//
//
//
//     await database.update_team(createdprofile: desired_profile!,docid: desired_profile!.docid!).then((value) async{
//
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           backgroundColor: mycolor,
//           content: Text("Profile Updated",style: TextStyle(color: Colors.white),)));
//
//       setState(() {
//         isloading=false;
//       });
//
//       Navigator.of(context).pop();
//
//     });
//
//
//
//   }
//
//   void _showErrorDialog(String msg) {
//     showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: Text('An Error Occured'),
//           content: Text(msg),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Okay'),
//               onPressed: () {
//                 Navigator.of(ctx).pop();
//               },
//             )
//           ],
//         ));
//   }
//
//   final picker = ImagePicker();
//
//   String ? selectedoption;
//
//
//
//
//   Future _show_my_Dialog(String ? choice) async{
//     await showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//             content: Container(
//               height: MediaQuery.of(context).size.height * 0.2,
//               child: Column(
//                 children: [
//                   ListTile(
//                     onTap: () async{
//                       await  getfilename(1,choice).then((value) {
//                         Navigator.of(context).pop();
//                       });
//                     },
//                     leading: Icon(
//                       Icons.camera,
//                       color: Colors.green,
//                     ),
//                     title: Text("Camera"),
//                   ),
//                   ListTile(
//                     onTap: () async{
//                       await   getfilename(2,choice).then((value) {
//                         Navigator.of(context).pop();
//                       });
//                     },
//                     leading: Icon(
//                       Icons.image,
//                       color: Colors.green,
//                     ),
//                     title: Text("Gallery"),
//                   )
//                 ],
//               ),
//             )));
//   }
//
//
//   File ? profile_file;
//
//   File ? logo_file;
//
//
//   File ? accreditation;
//   File ? image_file;
//
//   File? videofile;
//
//   File ? bg_file;
//
//   Future getfilename(int choice,String ?operation) async {
//     if (choice == 1) {
//       final image =
//       await ImagePicker.platform.getImage(source: ImageSource.camera);
//       setState(() {
//         if(operation=="profile"){
//           profile_file = File(image!.path);
//         }
//         else if(operation=="logo"){
//           logo_file = File(image!.path);
//         }
//         else if(operation=="accreditation"){
//           accreditation=File(image!.path);
//         }
//         else  if(operation=="images"){
//
//           image_file=File(image!.path);
//         }
//         else  if(operation=="video"){
//           videofile= File(image!.path);
//         }
//         else  if(operation=="bgimage"){
//           bg_file= File(image!.path);
//         }
//       });
//     } else {
//       final image =
//       await ImagePicker.platform.getImage(source: ImageSource.gallery);
//       setState(() {
//         if(operation=="profile"){
//           profile_file = File(image!.path);
//         }
//         else if(operation=="logo"){
//           logo_file = File(image!.path);
//         }
//         else if(operation=="accreditation"){
//           accreditation=File(image!.path);
//         }
//         else  if(operation=="images"){
//           image_file=File(image!.path);
//         }
//         else  if(operation=="video"){
//           videofile= File(image!.path);
//         }
//         else  if(operation=="bgimage"){
//           bg_file= File(image!.path);
//         }
//       });
//     }
//   }
//
//   CollectionReference ? imgRef;
//
//   firebase_storage.Reference ? ref;
//
//
//   MyProfile ? desired_profile;
//   @override
//   Widget build(BuildContext context) {
//     final height=MediaQuery.of(context).size.height;
//     final width=MediaQuery.of(context).size.width;
//
//     desired_profile=ModalRoute.of(context)!.settings.arguments as MyProfile;
//
//     return Scaffold(
//       backgroundColor: bgcolor,
//       body: Form(
//         key: _formKey,
//         child: ListView(
//
//           children: [
//
//             SizedBox(height: height*0.02,),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: width*0.1),
//               child:       Image.asset("images/logo.png",height: height*0.05,),),
//
//             Container(
//               margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
//               child:   Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   SizedBox(height: height*0.025,),
//                   BuildItalicText(txt: "Got a Couple of Edits?", fontsize: 0.0358),
//                   SizedBox(height: height*0.02,),
//                   LinearProgressIndicator(
//                     value: 0.15,
//                     backgroundColor: bgcolor,
//                     color: mycolor,
//                     minHeight: height*0.00252,
//                   ),
//
//                   SizedBox(height: height*0.05,),
//
//
//
//
//                   Row(
//                     children: [
//                       Container(
//                         height: height*0.14,
//                         width: width*0.23,
//                         child: Stack(
//                           children: [
//
//
//                             CircleAvatar(
//                               radius:50,
//                               backgroundImage: NetworkImage(desired_profile!.profile_image!),
//                             ),
//
//                             Positioned(
//                               bottom: 0,
//                               right: 0,
//
//                               child: InkWell(
//                                 onTap: ()async{
//                                   await  _show_my_Dialog("profile").then((value) async{
//                                     await  uploadFilelist(myfile: profile_file,type: 'profile').then((value) {
//                                       setState((){
//
//                                       });
//                                     });
//                                   });
//                                 },
//                                 child: CircleAvatar(
//                                   radius: 17,
//                                   backgroundColor: mycolor,
//                                   child: CircleAvatar(
//                                       radius:15,
//                                       backgroundColor: Colors.black,
//                                       child: Icon(Icons.edit,color: mycolor,size: 14,)
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       Expanded(
//                         child: Padding(
//                           padding:  EdgeInsets.only(left: width*0.05),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               BuildWhiteMuiliTextBold(txt: "Your Profile Picture", fontsize: 0.022),
//                               BuildWhiteMuiliText(txt: "Upload a picture of yourself.", fontsize: 0.0185)
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//
//                   SizedBox(height: height*0.025,),
//
//                   Row(
//                     children: [
//                       InkWell(
//                         onTap: ()async{
//                           await  _show_my_Dialog("logo").then((value) async{
//                             await  uploadFilelist(myfile: logo_file,type: 'logo').then((value) {
//                               setState((){
//
//                               });
//                             });
//                           });
//                         },
//                         child: Container(
//                           height: height*0.14,
//                           width: width*0.23,
//                           child: Stack(
//                             children: [
//
//                               CircleAvatar(
//                                 radius:50,
//                                 backgroundImage: NetworkImage(desired_profile!.logo!),
//                               )
//                               ,
//                               Positioned(
//                                 bottom: 0,
//                                 right: 0,
//
//                                 child: CircleAvatar(
//                                   radius: 17,
//                                   backgroundColor: mycolor,
//                                   child: CircleAvatar(
//                                       radius:15,
//                                       backgroundColor: Colors.black,
//                                       child: Icon(Icons.edit,color: mycolor,size: 14,)
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       Expanded(
//                         child: Padding(
//                           padding:  EdgeInsets.only(left: width*0.05),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               BuildWhiteMuiliTextBold(txt: "Company Logo", fontsize: 0.022),
//                               BuildWhiteMuiliText(txt: "Upload your Company Logo.", fontsize: 0.018)
//                             ],
//                           ),
//                         ),
//                       )
//
//
//                     ],
//                   ),
//                   SizedBox(height: height*0.065,),
//
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Your Details", fontsize: 0.03)),
//
//                   SizedBox(height: height*0.015,),
//                   Container(
//
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Name", fontsize: 0.022)),
//                   SizedBox(height: height*0.015,),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                         height: height*0.054,
//                         width: width*1,
//
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         padding: EdgeInsets.only(left: width*0.05),
//                         child:TextFormField(
//                           initialValue: desired_profile!.your_details!.name,
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             desired_profile!.your_details!.name=value;
//                           },
//                           onFieldSubmitted: (value){
//                             desired_profile!.your_details!.name=value;
//                           },
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//                           decoration: InputDecoration(
//                               hintText: "Your Name",
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                   color: Color(0xff5D5D5D),
//                                   fontFamily: 'Corporate A Italic',
//                                   fontSize: 15
//
//                               )
//
//                           ),
//                         )
//                     ),
//
//                   ),
//                   SizedBox(height: height*0.015,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Email", fontsize: 0.022)),
//                   SizedBox(height: height*0.015,),
//
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                         height: height*0.054,
//                         width: width*1,
//
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         padding: EdgeInsets.only(left: width*0.05),
//                         child:TextFormField(
//                           initialValue: desired_profile!.your_details!.email,
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             desired_profile!.your_details!.email=value;
//                           },
//                           onFieldSubmitted: (value){
//                             desired_profile!.your_details!.email=value;
//                           },
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//                           decoration: InputDecoration(
//                               hintText: "Hello@SaintConnect.info",
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                   color: Color(0xff5D5D5D),
//                                   fontFamily: 'Corporate A Italic',
//                                   fontSize: 15
//
//                               )
//
//                           ),
//                         )
//                     ),
//
//                   ),
//                   SizedBox(height: height*0.015,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Contact Number", fontsize: 0.022)),
//                   SizedBox(height: height*0.015,),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                         height: height*0.054,
//                         width: width*1,
//
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         padding: EdgeInsets.only(left: width*0.05),
//                         child:TextFormField(
//                           keyboardType: TextInputType.number,
//                           initialValue: desired_profile!.your_details!.contact_no,
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             desired_profile!.your_details!.contact_no=value;
//                           },
//                           onFieldSubmitted: (value){
//                             desired_profile!.your_details!.contact_no=value;
//                           },
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//                           decoration: InputDecoration(
//                               hintText: "020 8187 4998",
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                   color: Color(0xff5D5D5D),
//                                   fontFamily: 'Corporate A Italic',
//                                   fontSize: 15
//
//                               )
//
//                           ),
//                         )
//                     ),
//
//                   ),
//
//                   SizedBox(height: height*0.015,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Title/Company Position", fontsize: 0.022)),
//                   SizedBox(height: height*0.015,),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                         height: height*0.054,
//                         width: width*1,
//
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         padding: EdgeInsets.only(left: width*0.05),
//                         child:TextFormField(
//                           initialValue: desired_profile!.your_details!.title,
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             desired_profile!.your_details!.title=value;
//                           },
//                           onFieldSubmitted: (value){
//                             desired_profile!.your_details!.title=value;
//                           },
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//                           decoration: InputDecoration(
//                               hintText: "Director",
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                   color: Color(0xff5D5D5D),
//                                   fontFamily: 'Corporate A Italic',
//                                   fontSize: 15
//
//                               )
//
//                           ),
//                         )
//                     ),
//
//                   ),
//
//                   SizedBox(height: height*0.015,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Location", fontsize: 0.022)),
//                   SizedBox(height: height*0.015,),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                         height: height*0.054,
//                         width: width*1,
//
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         padding: EdgeInsets.only(left: width*0.05),
//                         child:TextFormField(
//                           initialValue: desired_profile!.your_details!.location,
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             desired_profile!.your_details!.location=value;
//                           },
//                           onFieldSubmitted: (value){
//                             desired_profile!.your_details!.location=value;
//                           },
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//                           decoration: InputDecoration(
//                               hintText: "United Kingdom",
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                   color: Color(0xff5D5D5D),
//                                   fontFamily: 'Corporate A Italic',
//                                   fontSize: 15
//
//                               )
//
//                           ),
//                         )
//                     ),
//
//                   ),
//
//                   SizedBox(height: height*0.015,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Introductionary Heading", fontsize: 0.022)),
//                   SizedBox(height: height*0.015,),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                         height: height*0.054,
//                         width: width*1,
//
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         padding: EdgeInsets.only(left: width*0.05),
//                         child:TextFormField(
//                           initialValue: desired_profile!.your_details!.intro_heading,
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             desired_profile!.your_details!.intro_heading=value;
//                           },
//                           onFieldSubmitted: (value){
//                             desired_profile!.your_details!.intro_heading=value;
//                           },
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//                           decoration: InputDecoration(
//                               hintText: "Welcome to my profile!",
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                   color: Color(0xff5D5D5D),
//                                   fontFamily: 'Corporate A Italic',
//                                   fontSize: 15
//
//                               )
//
//                           ),
//                         )
//                     ),
//
//                   ),
//
//                   SizedBox(height: height*0.015,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Introductionary Paragraph", fontsize: 0.022)),
//                   SizedBox(height: height*0.015,),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                         height: height*0.2,
//                         width: width*1,
//
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         padding: EdgeInsets.only(left: width*0.05),
//                         child:TextFormField(
//                           maxLines: 5,
//                           initialValue: desired_profile!.your_details!.paragraph,
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             desired_profile!.your_details!.paragraph=value;
//                           },
//                           onFieldSubmitted: (value){
//                             desired_profile!.your_details!.paragraph=value;
//                           },
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//                           decoration: InputDecoration(
//                               hintText: "Write paragraph",
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                   color: Color(0xff5D5D5D),
//                                   fontFamily: 'Corporate A Italic',
//                                   fontSize: 15
//
//                               )
//
//                           ),
//                         )
//                     ),
//
//                   ),
//                   SizedBox(height: height*0.05,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Personal Connections",fontsize: 0.03)),
//                   SizedBox(height: height*0.02,),
//                   Container(
//
//                     height: MediaQuery.of(context).size.height * 0.3,
//                     child: GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (ctx, index) {
//                         return
//
//                           index==desired_profile!.personal_connection!.length?
//
//                           InkWell(
//                             onTap: ()async{
//                               showModalBottomSheet(
//                                 context: context,
//                                 shape: RoundedRectangleBorder(
//                                   side: BorderSide(color: mycolor),
//                                   borderRadius: BorderRadius.vertical(
//                                       top: Radius.circular(60)
//                                   ),
//                                 ),
//                                 backgroundColor: addbg,
//                                 builder: (context) {
//                                   return Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(height: height*0.025,),
//                                       Container(
//
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//
//
//                                             Row(
//                                               children: [
//                                                 Image.asset("images/logo.png",height: height*0.03,),
//                                                 SizedBox(width: width*0.025,),
//                                                 BuildItalicText(txt: "Connect", fontsize: 0.03),
//                                               ],
//                                             ),
//
//
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(height: height*0.025,),
//                                       Container(
//                                           margin: EdgeInsets.only(left: width*0.05),
//                                           child: BuildItalicText(txt: "Add Social Media", fontsize: 0.025)),
//                                       SizedBox(height: height*0.025,),
//                                       Container(
//                                         margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
//                                         height: MediaQuery.of(context).size.height * 0.3,
//                                         child: GridView.builder(
//                                           physics: NeverScrollableScrollPhysics(),
//                                           itemBuilder: (ctx, index) {
//                                             return
//
//                                               InkWell(
//                                                 onTap: (){
//                                                   selectedoption=social[index];
//                                                   if(!desired_profile!.personal_connection!.contains(selectedoption)){
//                                                     print("jund");
//                                                     desired_profile!.personal_connection!.add(selectedoption!);
//                                                     setState(() {
//
//                                                     });
//                                                     Navigator.of(context).pop();
//                                                   }
//                                                   else{
//                                                     print("lund");
//                                                     Navigator.of(context).pop();
//                                                   }
//                                                 },
//                                                 child: Container(
//
//                                                   height: height*0.2,
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       borderRadius: BorderRadius.circular(10),
//                                                       image: DecorationImage(
//                                                           fit: BoxFit.cover,
//                                                           image: AssetImage(social[index])
//                                                       )
//                                                   ),
//                                                 ),
//                                               );
//                                           },
//                                           itemCount: social.length,
//                                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 4,
//                                             crossAxisSpacing: 10,
//                                             mainAxisSpacing: 15,
//                                             mainAxisExtent: 70,
//                                             //emoji height
//                                           ),
//                                           padding: EdgeInsets.all(5),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                               // await  _show_personal_socialmedia_options().then((value) {
//                               //   setState((){
//                               //
//                               //   });
//                               // });
//                             },
//                             child: Container(
//                               height: height*0.2,
//                               decoration: BoxDecoration(
//                                 color: addbg,
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                     color: mycolor
//                                 ),
//                               ),
//                               child: Icon(Icons.add,color: mycolor,size: 35),
//                             ),
//                           ):
//                           Container(
//
//                             height: height*0.2,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image: AssetImage(desired_profile!.personal_connection![index])
//                                 )
//                             ),
//                           );
//                       },
//                       itemCount:  desired_profile!.personal_connection!.length+1,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 4,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 15,
//                         mainAxisExtent: 70,
//                         //emoji height
//                       ),
//                       padding: EdgeInsets.all(5),
//                     ),
//                   ),
//
//
//
//                   SizedBox(height: height*0.025,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Accreditations & Badges",fontsize: 0.03)),
//                   SizedBox(height: height*0.025,),
//                   Container(
//
//                     height: MediaQuery.of(context).size.height * 0.15,
//                     child: GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (ctx, index) {
//                         return
//                           index==desired_profile!.Accreditation!.length? InkWell(
//                             onTap: ()async{
//                               await   _show_my_Dialog("accreditation").then((value) async{
//                                 await  uploadFilelist(myfile: accreditation!,type: 'accreditation').then((value) {
//
//                                 });
//                               });
//                             },
//                             child: Container(
//
//                               height: height*0.2,
//                               decoration: BoxDecoration(
//                                 color: addbg,
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                     color: mycolor
//                                 ),
//                               ),
//                               child: Icon(Icons.add,color: mycolor,size: 35),
//                             ),
//                           ):
//                           Container(
//                             height: height*0.2,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                     color: mycolor
//                                 ),
//                                 image: DecorationImage(
//                                     fit: BoxFit.fill,
//                                     image: NetworkImage(desired_profile!.Accreditation![index])
//                                 )
//                             ),
//                           );
//
//                       },
//                       itemCount:  desired_profile!.Accreditation!.length+1,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 4,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 15,
//                         mainAxisExtent: 70,
//                         //emoji height
//                       ),
//                       padding: EdgeInsets.all(5),
//                     ),
//                   ),
//                   SizedBox(height: height*0.03,),
//
//
//
//
//
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Business Details", fontsize: 0.03)),
//                   SizedBox(height: height*0.015,),
//                   Container(
//
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Buisness Name", fontsize: 0.02)),
//                   SizedBox(height: height*0.015,),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                         height: height*0.054,
//                         width: width*1,
//
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         padding: EdgeInsets.only(left: width*0.05),
//                         child:TextFormField(
//                           initialValue: desired_profile!.business_details!.Business_name,
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             desired_profile!.business_details!.Business_name=value;
//                           },
//                           onFieldSubmitted: (value){
//                             desired_profile!.business_details!.Business_name=value;
//                           },
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//                           decoration: InputDecoration(
//                               hintText: "Saint Connect",
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                   color: Color(0xff5D5D5D),
//                                   fontFamily: 'Corporate A Italic',
//                                   fontSize: 15
//
//                               )
//
//                           ),
//                         )
//                     ),
//
//                   ),
//                   SizedBox(height: height*0.015,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Electrical Contractor", fontsize: 0.02)),
//                   SizedBox(height: height*0.015,),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                         height: height*0.054,
//                         width: width*1,
//
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         padding: EdgeInsets.only(left: width*0.05),
//                         child:TextFormField(
//                           initialValue: desired_profile!.business_details!.company_sector,
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             desired_profile!.business_details!.company_sector=value;
//                           },
//                           onFieldSubmitted: (value){
//                             desired_profile!.business_details!.company_sector=value;
//                           },
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//                           decoration: InputDecoration(
//                               hintText: "Electrician",
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                   color: Color(0xff5D5D5D),
//                                   fontFamily: 'Corporate A Italic',
//                                   fontSize: 15
//
//                               )
//
//                           ),
//                         )
//                     ),
//
//                   ),
//
//                   SizedBox(height: height*0.015,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Company Website", fontsize: 0.02)),
//                   SizedBox(height: height*0.015,),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                         height: height*0.054,
//                         width: width*1,
//
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         padding: EdgeInsets.only(left: width*0.05),
//                         child:TextFormField(
//                           initialValue: desired_profile!.business_details!.website,
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             desired_profile!.business_details!.website=value;
//                           },
//                           onFieldSubmitted: (value){
//                             desired_profile!.business_details!.website=value;
//                           },
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//                           decoration: InputDecoration(
//                               hintText: "www.saintconnect.info",
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                   color: Color(0xff5D5D5D),
//                                   fontFamily: 'Corporate A Italic',
//                                   fontSize: 15
//
//                               )
//
//                           ),
//                         )
//                     ),
//
//                   ),
//
//                   SizedBox(height: height*0.015,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Company Number", fontsize: 0.02)),
//                   SizedBox(height: height*0.015,),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                         height: height*0.054,
//                         width: width*1,
//
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//                         padding: EdgeInsets.only(left: width*0.05),
//                         child:TextFormField(
//                           initialValue: desired_profile!.business_details!.company_contact_no,
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             desired_profile!.business_details!.company_contact_no=value;
//                           },
//                           onFieldSubmitted: (value){
//                             desired_profile!.business_details!.company_contact_no=value;
//                           },
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//                           decoration: InputDecoration(
//                               hintText: "020 8187 4998",
//                               border: InputBorder.none,
//                               hintStyle: TextStyle(
//                                   color: Color(0xff5D5D5D),
//                                   fontFamily: 'Corporate A Italic',
//                                   fontSize: 15
//
//                               )
//
//                           ),
//                         )
//                     ),
//
//                   ),
//
//
//                   SizedBox(height: height*0.05,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Business Connections",fontsize: 0.03)),
//
//                   SizedBox(height: height*0.02,),
//
//
//                   Container(
//
//                     height: MediaQuery.of(context).size.height * 0.3,
//                     child: GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (ctx, index) {
//                         return
//
//                           index==desired_profile!.business_connection!.length?
//
//                           InkWell(
//                             onTap: ()async{
//                               showModalBottomSheet(
//                                 context: context,
//                                 shape: RoundedRectangleBorder(
//                                   side: BorderSide(color: mycolor),
//                                   borderRadius: BorderRadius.vertical(
//                                       top: Radius.circular(60)
//                                   ),
//                                 ),
//                                 backgroundColor: addbg,
//                                 builder: (context) {
//                                   return Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(height: height*0.025,),
//                                       Container(
//
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//
//
//                                             Row(
//                                               children: [
//                                                 Image.asset("images/logo.png",height: height*0.03,),
//                                                 SizedBox(width: width*0.025,),
//                                                 BuildItalicText(txt: "Connect", fontsize: 0.03),
//                                               ],
//                                             ),
//
//
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(height: height*0.025,),
//                                       Container(
//                                           margin: EdgeInsets.only(left: width*0.05),
//                                           child: BuildItalicText(txt: "Add Social Media", fontsize: 0.025)),
//                                       SizedBox(height: height*0.025,),
//                                       Container(
//                                         margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
//                                         height: MediaQuery.of(context).size.height * 0.3,
//                                         child: GridView.builder(
//                                           physics: NeverScrollableScrollPhysics(),
//                                           itemBuilder: (ctx, index) {
//                                             return
//
//                                               InkWell(
//                                                 onTap: (){
//                                                   selectedoption=social[index];
//                                                   if(!desired_profile!.business_connection!.contains(selectedoption)){
//                                                     print("jund");
//                                                     desired_profile!.business_connection!.add(selectedoption!);
//                                                     setState(() {
//
//                                                     });
//                                                     Navigator.of(context).pop();
//                                                   }
//                                                   else{
//                                                     print("lund");
//                                                     Navigator.of(context).pop();
//                                                   }
//                                                 },
//                                                 child: Container(
//
//                                                   height: height*0.2,
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       borderRadius: BorderRadius.circular(10),
//                                                       image: DecorationImage(
//                                                           fit: BoxFit.cover,
//                                                           image: AssetImage(social[index])
//                                                       )
//                                                   ),
//                                                 ),
//                                               );
//                                           },
//                                           itemCount: social.length,
//                                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 4,
//                                             crossAxisSpacing: 10,
//                                             mainAxisSpacing: 15,
//                                             mainAxisExtent: 70,
//                                             //emoji height
//                                           ),
//                                           padding: EdgeInsets.all(5),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                             },
//                             child: Container(
//                               height: height*0.2,
//                               decoration: BoxDecoration(
//                                 color: addbg,
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                     color: mycolor
//                                 ),
//                               ),
//                               child: Icon(Icons.add,color: mycolor,size: 35),
//                             ),
//                           ):
//                           Container(
//
//                             height: height*0.2,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image: AssetImage(desired_profile!.business_connection![index])
//                                 )
//                             ),
//                           );
//                       },
//                       itemCount: desired_profile!.business_connection!.length+1,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 4,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 15,
//                         mainAxisExtent: 70,
//                         //emoji height
//                       ),
//                       padding: EdgeInsets.all(5),
//                     ),
//                   ),
//
//
//
//
//
//
//
//
//
//
//                   SizedBox(height: height*0.025,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Design & Appearance",fontsize: 0.025)),
//
//                   SizedBox(height: height*0.025,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Background Theme",fontsize: 0.022)),
//
//                   Container(
//                     height: height*0.075,
//
//                     child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children:[
//
//                           desired_profile!.design_appearance!.BackgroundTheme==0xff000000?
//                           Container(
//                             margin: EdgeInsets.only(left: width*0.02),
//                             child: CircleAvatar(
//                               radius: height*0.02,
//                               backgroundColor: Colors.white,
//                               child: CircleAvatar(
//                                 radius: height*0.018,
//                                 backgroundColor: Color(0xff000000),
//                               ),
//                             ),
//                           ): Container(
//                             margin: EdgeInsets.only(left: width*0.02),
//                             child: CircleAvatar(
//                               radius: height*0.02,
//                               backgroundColor:Color(  desired_profile!.design_appearance!.BackgroundTheme!),
//                             ),
//                           ),
//                           Row(
//                             children:   List.generate(bgcolors.length, (index) =>
//                             bgcolors[index]==0xff000000?
//                             desired_profile!.design_appearance!.BackgroundTheme==0xff000000?
//                             Text("")
//                                 :
//
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   desired_profile!.design_appearance!.BackgroundTheme=bgcolors[index];
//                                 });
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(left: width*0.02),
//                                 child: CircleAvatar(
//                                   radius: height*0.0145,
//                                   backgroundColor: Colors.white,
//                                   child: CircleAvatar(
//                                     radius: height*0.013,
//                                     backgroundColor: Color(bgcolors[index]),
//                                   ),
//                                 ),
//                               ),
//                             ):
//                             index==bgcolors.length-1?
//
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   desired_profile!.design_appearance!.BackgroundTheme=bgcolors[index];
//                                 });
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(left: width*0.02),
//                                 child: CircleAvatar(
//                                   radius: height*0.0145,
//                                   backgroundColor: Color(bgcolors[index]),
//                                   child: CircleAvatar(
//                                     radius: height*0.013,
//                                     backgroundColor: bgcolor,
//                                     child: Icon(Icons.add,color: Color(bgcolors[index]),size: height*0.02),
//                                   ),
//                                 ),
//                               ),
//                             )
//
//                                 :
//                             bgcolors[index]==  desired_profile!.design_appearance!.BackgroundTheme?Text(""):
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   desired_profile!.design_appearance!.BackgroundTheme=bgcolors[index];
//                                 });
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(left: width*0.02),
//                                 child: CircleAvatar(
//                                   radius: height*0.0145,
//                                   backgroundColor:Color(bgcolors[index]),
//                                 ),
//                               ),
//                             )
//
//                             ),
//                           )
//                         ]
//                     ),
//                   ),
//
//
//                   SizedBox(height: height*0.025,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//
//                       child: BuildWhiteMuiliTextBold(txt: "Text Colour",fontsize: 0.022)),
//
//                   Container(
//                     height: height*0.075,
//
//                     child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children:[
//
//                           desired_profile!.design_appearance!.TextColor==0xff000000?
//                           Container(
//                             margin: EdgeInsets.only(left: width*0.02),
//                             child: CircleAvatar(
//                               radius: height*0.02,
//                               backgroundColor: Colors.white,
//                               child: CircleAvatar(
//                                 radius: height*0.018,
//                                 backgroundColor: Color(0xff000000),
//                               ),
//                             ),
//                           ): Container(
//                             margin: EdgeInsets.only(left: width*0.02),
//                             child: CircleAvatar(
//                               radius: height*0.02,
//                               backgroundColor:Color(  desired_profile!.design_appearance!.TextColor!),
//                             ),
//                           ),
//                           Row(
//                             children:   List.generate(bgcolors.length, (index) =>
//                             bgcolors[index]==0xff000000?
//                             desired_profile!.design_appearance!.TextColor==0xff000000?
//                             Text("")
//                                 :
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   desired_profile!.design_appearance!.TextColor=bgcolors[index];
//                                 });
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(left: width*0.02),
//                                 child: CircleAvatar(
//                                   radius: height*0.0145,
//                                   backgroundColor: Colors.white,
//                                   child: CircleAvatar(
//                                     radius: height*0.013,
//                                     backgroundColor: Color(bgcolors[index]),
//                                   ),
//                                 ),
//                               ),
//                             ):
//                             index==bgcolors.length-1?
//
//                             InkWell(
//                               onTap: (){
//                                 // setState((){
//                                 //    desired_profile!.design_appearance!.TextColor=bgcolors[index];
//                                 // });
//                                 _pickcolor();
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(left: width*0.02),
//                                 child: CircleAvatar(
//                                   radius: height*0.0145,
//                                   backgroundColor: Color(bgcolors[index]),
//                                   child: CircleAvatar(
//                                     radius: height*0.013,
//                                     backgroundColor: bgcolor,
//                                     child: Icon(Icons.add,color: Color(bgcolors[index]),size: height*0.02),
//                                   ),
//                                 ),
//                               ),
//                             )
//
//                                 :
//                             bgcolors[index]==  desired_profile!.design_appearance!.TextColor?Text(""):
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   desired_profile!.design_appearance!.TextColor=bgcolors[index];
//                                 });
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(left: width*0.02),
//                                 child: CircleAvatar(
//                                   radius: height*0.0145,
//                                   backgroundColor:Color(bgcolors[index]),
//                                 ),
//                               ),
//                             )
//
//                             ),
//                           )
//                         ]
//                     ),
//                   ),
//
//                   SizedBox(height: height*0.025,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Button Colour",fontsize: 0.022)),
//
//                   Container(
//                     height: height*0.075,
//
//                     child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children:[
//
//                           desired_profile!.design_appearance!.ButtonColor ==0xff000000?
//                           Container(
//                             margin: EdgeInsets.only(left: width*0.02),
//                             child: CircleAvatar(
//                               radius: height*0.02,
//                               backgroundColor: Colors.white,
//                               child: CircleAvatar(
//                                 radius: height*0.018,
//                                 backgroundColor: Color(0xff000000),
//                               ),
//                             ),
//                           ): Container(
//                             margin: EdgeInsets.only(left: width*0.02),
//                             child: CircleAvatar(
//                               radius: height*0.02,
//                               backgroundColor:Color(  desired_profile!.design_appearance!.ButtonColor!),
//                             ),
//                           ),
//                           Row(
//                             children:   List.generate(bgcolors.length, (index) =>
//                             bgcolors[index]==0xff000000?
//                             desired_profile!.design_appearance!.ButtonColor==0xff000000?
//                             Text("")
//                                 :
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   desired_profile!.design_appearance!.ButtonColor=bgcolors[index];
//                                 });
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(left: width*0.02),
//                                 child: CircleAvatar(
//                                   radius: height*0.0145,
//                                   backgroundColor: Colors.white,
//                                   child: CircleAvatar(
//                                     radius: height*0.013,
//                                     backgroundColor: Color(bgcolors[index]),
//                                   ),
//                                 ),
//                               ),
//                             ):
//                             index==bgcolors.length-1?
//
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   desired_profile!.design_appearance!.ButtonColor=bgcolors[index];
//                                 });
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(left: width*0.02),
//                                 child: CircleAvatar(
//                                   radius: height*0.0145,
//                                   backgroundColor: Color(bgcolors[index]),
//                                   child: CircleAvatar(
//                                     radius: height*0.013,
//                                     backgroundColor: bgcolor,
//                                     child: Icon(Icons.add,color: Color(bgcolors[index]),size: height*0.02),
//                                   ),
//                                 ),
//                               ),
//                             )
//
//                                 :
//                             bgcolors[index]==  desired_profile!.design_appearance!.ButtonColor?Text(""):
//
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   desired_profile!.design_appearance!.ButtonColor=bgcolors[index];
//                                 });
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(left: width*0.02),
//                                 child: CircleAvatar(
//                                   radius: height*0.0145,
//                                   backgroundColor:Color(bgcolors[index]),
//                                 ),
//                               ),
//                             )
//
//                             ),
//                           )
//                         ]
//                     ),
//                   ),
//
//
//
//
//
//
//
//
//
//
//
//
//                   SizedBox(height: height*0.05,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Background Image",fontsize: 0.022)),
//
//                   SizedBox(height: height*0.015,),
//                   Row(
//                     children: [
//
//                       InkWell(
//                         onTap: ()async{
//                           await _show_my_Dialog("bgimage").then((value) async{
//                             await uploadFilelist(type: 'bgimage',myfile: bg_file).then((value) {
//                               setState((){
//
//                               });
//                             });
//                           });
//                         },
//                         child: Container(
//                           width: width*0.49,
//                           height: height*0.22,
//                           decoration: BoxDecoration(
//                               color: addbg,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                   color: mycolor
//                               ),
//                               image: DecorationImage(
//                                   fit: BoxFit.values[2],
//                                   image: NetworkImage(desired_profile!.Backgroundimage!)
//                               )
//                           ),
//
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   SizedBox(height: height*0.02,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Images",fontsize: 0.022)),
//
//                   SizedBox(height: height*0.015,),
//                   Container(
//                     height: height*0.23,
//                     child: ListView(
//                         scrollDirection: Axis.horizontal,
//
//                         children: List.generate(desired_profile!.images!.length+1, (index) => desired_profile!.images!.length==index?
//                         InkWell(
//                           onTap: ()async{
//                             await _show_my_Dialog("images").then((value) async{
//                               await uploadFilelist(type: 'images',myfile: image_file).then((value) {
//                                 setState((){
//
//                                 });
//                               });
//                             });
//                           },
//                           child: Container(
//                             margin: EdgeInsets.only(left: width*0.025),
//                             width: width*0.49,
//                             height: height*0.22,
//                             decoration: BoxDecoration(
//                               color: addbg,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                   color: mycolor
//                               ),
//                             ),
//                             child: Icon(Icons.add,color: mycolor,size: 65),
//                           ),
//                         ): Container(
//                           margin: EdgeInsets.only(right: width*0.025),
//
//                           width: width*0.49,
//                           height: height*0.22,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                   color: mycolor
//                               ),
//                               image: DecorationImage(
//                                   fit: BoxFit.fill,
//                                   image: NetworkImage(desired_profile!.images![index])
//                               )
//                           ),
//
//                         ),
//                         )
//                     ),
//                   ),
//
//                   SizedBox(height: height*0.015,),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Videos",fontsize: 0.022)),
//                   SizedBox(height: height*0.015,),
//                   Row(
//                     children: [
//
//                       Expanded(
//                         child:
//                         InkWell(
//                           onTap: ()async{
//                             await _show_my_Dialog("video").then((value) async{
//                               await uploadFilelist(myfile: videofile,type: 'video').then((value) {
//                                 setState((){
//
//                                 });
//                               });
//                             });
//                           },
//                           child: Container(
//
//                             height: height*0.15,
//                             decoration: BoxDecoration(
//                               color: addbg,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                   color: mycolor
//                               ),
//                             ),
//                             child: Icon(Icons.play_arrow,color: mycolor,size: 65),
//                           ),
//                         )
//                         ,
//                       ),
//                     ],
//                   ),
//
//                   SizedBox(height: height*0.05,),
//                   isloading?
//                   SpinKitRing(color: Colors.white)
//                       :
//                   InkWell(
//                       onTap: (){
//                         _submit();
//                         // Navigator.of(context).pushNamed(HomeScreen.routename);
//                       },
//                       child: BuildWhiteButton(text: "Save Changes")),
//                   SizedBox(height: height*0.075,),
//
//
//
//                 ],
//               ),
//             )
//
//           ],
//         ),
//       ),
//     );
//   }
// }

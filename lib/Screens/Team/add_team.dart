// import 'dart:io';
// import 'dart:typed_data';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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
// import 'package:path_provider/path_provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:screenshot/screenshot.dart';
//
// class Add_Team extends StatefulWidget {
//   static const routename="Add_Team";
//
//   @override
//   State<Add_Team> createState() => _Add_TeamState();
// }
//
// class _Add_TeamState extends State<Add_Team> {
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
//   Uint8List ? _imageFile;
//   bool team=false;
//
//
//
//   //Create an instance of ScreenshotController
//   ScreenshotController screenshotController = ScreenshotController();
//   File ? myfile;
//   String ? QRImage='';
//   Future show_bottomsheet({required bool personel}){
//     final height=MediaQuery.of(context).size.height;
//     final width=MediaQuery.of(context).size.width;
//     return showModalBottomSheet(
//       context: context,
//       isDismissible: true,
//       enableDrag: true,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         side: BorderSide(color: mycolor),
//         borderRadius: BorderRadius.vertical(
//             top: Radius.circular(60)
//         ),
//       ),
//       backgroundColor: addbg,
//       builder: (context) {
//         return Container(
//           height: height*0.5,
//
//           decoration: BoxDecoration(
//               color: Color(0xff2A2A2A),
//               boxShadow: [
//                 BoxShadow(
//                     color: Color(0xffDAC07A),
//                     blurRadius: 10
//                 )
//               ],
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(50),
//                   topRight: Radius.circular(50)
//               )
//           ),
//
//           child: Padding(
//             padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
//
//             child: ListView(
//
//               children: [
//
//
//
//
//                 Container(
//                   margin: EdgeInsets.only(right: width*0.025,top: height*0.025),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(""),
//
//                       Row(
//                         children: [
//                           Image.asset("images/logo.png",height: height*0.05,),
//                           SizedBox(width: width*0.025,),
//                           BuildItalicText(txt: "Connect", fontsize: 0.0358),
//                         ],
//                       ),
//
//
//                       InkWell(
//                           onTap: (){
//                             Navigator.of(context).pop();
//                           },
//                           child: Image.asset("images/close.png",color: Colors.white,height: height*0.025)),
//
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: height*0.05,),
//
//
//
//                 BuildItalicText(txt: "Add Social Media", fontsize: 0.0358),
//                 SizedBox(height: height*0.05,),
//                 Container(
//
//                   height: MediaQuery.of(context).size.height * 0.3,
//                   child: GridView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     itemBuilder: (ctx, index) {
//                       return
//
//                         InkWell(
//                           onTap: ()async{
//                             await _enter_media(choice: social[index],personel: personel);
//                           },
//                           child: Container(
//
//                             height: height*0.2,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image: AssetImage(social[index])
//                                 )
//                             ),
//                           ),
//                         );
//                     },
//                     itemCount:  social.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 4,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 15,
//                       mainAxisExtent: 70,
//                       //emoji height
//                     ),
//                     padding: EdgeInsets.all(5),
//                   ),
//                 ),
//
//
//
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//   TextEditingController _media_url=TextEditingController();
//
//   Future<File?> _enter_media({required String ? choice,required bool personel}) async{
//     final height=MediaQuery.of(context).size.height;
//     final width=MediaQuery.of(context).size.width;
//     File ? choosedfile;
//     await  showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//             title: BuildBlackMuiliText(txt: "Enter Media url", fontsize: 0.05),
//             content: Container(
//               height: MediaQuery.of(context).size.height * 0.2,
//               child: Column(
//                 children: [
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
//                         child:  TextField(
//                           controller: _media_url,
//                           decoration: InputDecoration(
//                               hintText: "Enter url",
//                               hintStyle: TextStyle(color: Colors.black)
//                           ),
//                         )
//                     ),
//
//                   ),
//                   SizedBox(height: height*0.025,),
//                   InkWell(
//                     onTap: (){
//                       if(personel){
//                         if(!personal_connections!.contains(SocialMedia(
//                             media: choice,
//                         ))){
//                           personal_connections!.add(SocialMedia(
//                               media: choice,
//                               url: _media_url.text
//                           ));
//                           _media_url.dispose();
//                           Navigator.of(context).pop();
//                         }
//                         else{
//                           _media_url.dispose();
//                           Navigator.of(context).pop();
//                         }
//                       }
//                       else{
//                         if(!business_connections!.contains(SocialMedia(
//                             media: choice
//                         ))){
//                           business_connections!.add(SocialMedia(
//                               media: choice,
//                               url: _media_url.text
//                           ));
//                           _media_url.dispose();
//                           Navigator.of(context).pop();
//                         }
//                         else{
//                           _media_url.dispose();
//                           Navigator.of(context).pop();
//                         }
//                       }
//                     },
//                     child: Container(
//                       alignment: Alignment.centerLeft,
//                       child: Container(
//                         height: height*0.054,
//                         width: width*1,
//
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//
//                             borderRadius: BorderRadius.circular(10)
//                         ),
//
//                         child: Center(child: BuildBlackMuiliText(txt: "Save", fontsize: 0.025)),
//                       ),
//
//                     ),
//                   )
//
//
//                 ],
//               ),
//             )));
//     return choosedfile;
//   }
//
//   Widget Qrimage(){
//     return Screenshot(
//       controller: screenshotController,
//       child: QrImage(
//         data: currentuser!.uid!,
//         version: QrVersions.auto,
//         size: 200,
//         gapless: false,
//       ),
//     );
//   }
//   Future GenerateQRCode()async{
//
//     final Uint8List ? image=await screenshotController.captureFromWidget(Qrimage());
//
//     setState(() {
//       _imageFile = image;
//     });
//
//     if(image!=null){
//       final tempDir = await getTemporaryDirectory();
//       final file = await new File('${tempDir.path}/$user_id.jpg').create();
//       file.writeAsBytesSync(image);
//       setState(() {
//         myfile=file;
//       });
//       print("my lund"+myfile.toString());
//       await uploadQR();
//     }
//   }
//
//
//
//   Future uploadQR() async {
//     try{
//       ref = firebase_storage.FirebaseStorage.instance
//           .ref()
//           .child('QRCode/${Path.basename(myfile!.path)}');
//       await ref!.putFile(myfile!).whenComplete(() async {
//         await ref!.getDownloadURL().then((value) async{
//           QRImage=value;
//
//         });
//       });
//     }
//     catch(error){
//
//     }
//
//   }
//   CollectionReference ? imgRef;
//
//   firebase_storage.Reference ? ref;
//
//   Future uploadFilelist({List<File> ? mylist,String ? type,File ? myfile}) async {
//
//     List<String> data=[];
//
//     if(mylist!=null){
//       for (int i = 0; i < mylist.length; i++) {
//         ref = firebase_storage.FirebaseStorage.instance
//             .ref()
//             .child('${"profile"}/${Path.basename(mylist[i].path)}');
//         await ref!.putFile(mylist[i]).whenComplete(() async {
//           await ref!.getDownloadURL().then((imageurl) {
//             if(imageurl!=null){
//               if(type=="images"){
//                 images.add(imageurl.toString());
//               }
//               else if(type=="accreditation"){
//                 accreditation_images!.add(imageurl);
//               }
//               else if(type=="logo"){
//
//                 createprofile!.logo=imageurl;
//               }
//               else if(type=="myprofile"){
//                 createprofile!.profile_image=imageurl;
//               }
//               else if(type=="bgimage"){
//                 createprofile!.Backgroundimage=imageurl;
//               }
//               else if(type=="video"){
//                 createprofile!.video=imageurl;
//               }
//             }
//           });
//         });
//       }
//     }
//     else{
//       print("khan baba"+myfile.toString());
//       ref = firebase_storage.FirebaseStorage.instance
//           .ref()
//           .child('${"profile"}/${Path.basename(myfile!.path)}');
//       await ref!.putFile(myfile).whenComplete(() async {
//         await ref!.getDownloadURL().then((imageurl) {
//           if(imageurl!=null){
//
//             if(type=="logo"){
//               createprofile!.logo=imageurl;
//             }
//             else if(type=="myprofile"){
//               createprofile!.profile_image=imageurl;
//             }
//             else if(type=="bgimage"){
//
//               createprofile!.Backgroundimage=imageurl;
//             }
//             else if(type=="video"){
//               createprofile!.video=imageurl;
//             }
//           }
//         });
//       });
//     }
//
//   }
//   MyProfile ? createprofile=MyProfile(profile_image: '', logo: '', your_details: YourDetails(
//       email: '',
//       name: '',
//
//       title: '',
//       location: '',
//       contact_no: '',
//       intro_heading: '',
//       paragraph: ''
//   ), personal_connection: [],
//       business_connection: [],
//       Accreditation: [], business_details: BusinessDetails(
//           Business_name: '',
//           company_contact_no: '',
//           company_sector: '',
//           website: ''
//       ), design_appearance: Design_Appearance(
//           BackgroundTheme: CustomColor( hexcode: "0xff000000"),
//           ButtonColor: CustomColor( hexcode: "0xff000000"),
//           TextColor:CustomColor( hexcode: "0xff000000")
//       ), Backgroundimage: '', images: [],
//       video: '');
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
//     if(percentage<0.99){
//       setState(() {
//         isloading=false;
//       });
//       _showErrorDialog("Incomplete");
//     }
//
//     else{
//       await uploadFilelist(myfile: profile_file,type: 'myprofile',).then((value) async{
//
//
//         await uploadFilelist(myfile: logo_file,type: 'logo',).then((value2) async{
//
//
//
//           await uploadFilelist(myfile: bg_file,type: 'bgimage').then((value5) async{
//
//
//             await uploadFilelist(mylist: accreditation_file,type: 'accreditation').then((value) async{
//               await uploadFilelist(mylist: images_file!,type:  'images');
//             });
//
//           });
//         });
//       }).then((value) async{
//         await GenerateQRCode().then((value) async{
//           createprofile=MyProfile(
//               business_connection: business_connections,
//               profile_image:    createprofile!.profile_image,
//               logo:    createprofile!.logo,
//               your_details: mydetail, personal_connection:
//           personal_connections, Accreditation: accreditation_images, business_details: businessdetail, design_appearance: design_appearance, Backgroundimage:    createprofile!.Backgroundimage, images: images,
//               video:    createprofile!.video,
//               uid: currentuser!.uid,
//               qrcode: QRImage,
//           );
//           //This will add new team
//           createprofile!.qrcode=QRImage;
//           await database.add_team (createprofile).then((value) async{
//
//             setState(() {
//               isloading=false;
//             });
//
//             Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routename, (route) => false);
//
//           });
//         });
//
//
//
//
//
//         //This will add new team
//         // await GenerateQRCode().then((value) async{
//         //         createprofile!.qrcode=QRImage;
//         //   await database.add_team (createprofile!).then((value) async{
//         //
//         //     setState(() {
//         //       isloading=false;
//         //     });
//         //
//         //     Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routename, (route) => false);
//         //
//         //   });
//         // });
//
//
//
//       });
//
//
//     }
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
//   String ? selectedoption;
//   List<SocialMedia> ? business_connections=[];
//   List<SocialMedia> ? personal_connections=[];
//   void _show_my_Dialog(String ? choice) {
//     showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//             content: Container(
//               height: MediaQuery.of(context).size.height * 0.2,
//               child: Column(
//                 children: [
//                   ListTile(
//                     onTap: () {
//                       getfilename(1,choice).then((value) {
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
//                     onTap: () {
//                       getfilename(2,choice).then((value) {
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
//   // Future _show_socialmedia_options() async{
//   //   final height=MediaQuery.of(context).size.height;
//   //   final width=MediaQuery.of(context).size.width;
//   //   await showDialog(
//   //       context: context,
//   //       builder: (ctx) => StatefulBuilder(builder: (context,setState){
//   //         return AlertDialog(
//   //             shape: RoundedRectangleBorder(
//   //                 side: BorderSide(
//   //                     color: Colors.white
//   //                 )
//   //             ),
//   //             backgroundColor: bgcolor,
//   //
//   //             content: Container(
//   //               color: bgcolor,
//   //
//   //               height: MediaQuery.of(context).size.height * 0.3,
//   //               child: Column(
//   //                 mainAxisAlignment: MainAxisAlignment.center,
//   //                 children: [
//   //                   Container(
//   //                     alignment: Alignment.centerLeft,
//   //                     child: Container(
//   //                         height: height*0.054,
//   //                         width: width*1,
//   //
//   //                         decoration: BoxDecoration(
//   //                             color: Colors.white,
//   //
//   //                             borderRadius: BorderRadius.circular(10)
//   //                         ),
//   //                         padding: EdgeInsets.only(left: width*0.05),
//   //                         child:DropdownButton(
//   //                           value: selectedoption,
//   //                           dropdownColor: Colors.white,
//   //                           onChanged: (value) {
//   //                             setState(() {
//   //                               selectedoption = value as String;
//   //                             });
//   //                           },
//   //                           underline: DropdownButtonHideUnderline(child: Text("")),
//   //                           icon: Icon(Icons.arrow_drop_down,color: bgcolor),
//   //                           isExpanded: true,
//   //
//   //                           hint: Container(
//   //                               alignment: Alignment.center,
//   //                               child: Text("Select Media")),
//   //                           items: social
//   //                               .map((e) => DropdownMenuItem(
//   //                               value: e, child: Padding(
//   //                             padding: const EdgeInsets.all(8.0),
//   //                             child: Container(
//   //
//   //                                 alignment: Alignment.center,
//   //                                 child: Image.asset(e)),
//   //                           )))
//   //                               .toList(),
//   //                         )
//   //                     ),
//   //
//   //                   ),
//   //
//   //                   SizedBox(height: height*0.025,),
//   //                   InkWell(
//   //                     onTap: (){
//   //                       if(!business_connections!.contains(selectedoption)){
//   //                         business_connections!.add(selectedoption!);
//   //                         Navigator.of(context).pop();
//   //                       }
//   //                       else{
//   //                         Navigator.of(context).pop();
//   //                       }
//   //                     },
//   //                     child: Container(
//   //                       alignment: Alignment.centerLeft,
//   //                       child: Container(
//   //                         height: height*0.054,
//   //                         width: width*1,
//   //
//   //                         decoration: BoxDecoration(
//   //                             color: Colors.white,
//   //
//   //                             borderRadius: BorderRadius.circular(10)
//   //                         ),
//   //
//   //                         child: Center(child: BuildBlackMuiliText(txt: "Save", fontsize: 0.025)),
//   //                       ),
//   //
//   //                     ),
//   //                   )
//   //
//   //
//   //                 ],
//   //               ),
//   //             ));
//   //       }));
//   // }
//   // Future _show_personal_socialmedia_options() async{
//   //   final height=MediaQuery.of(context).size.height;
//   //   final width=MediaQuery.of(context).size.width;
//   //   await showDialog(
//   //       context: context,
//   //       builder: (ctx) => StatefulBuilder(builder: (context,setState){
//   //         return AlertDialog(
//   //             shape: RoundedRectangleBorder(
//   //                 side: BorderSide(
//   //                     color: Colors.white
//   //                 )
//   //             ),
//   //             backgroundColor: bgcolor,
//   //
//   //             content: Container(
//   //               color: bgcolor,
//   //
//   //               height: MediaQuery.of(context).size.height * 0.3,
//   //               child: Column(
//   //                 mainAxisAlignment: MainAxisAlignment.center,
//   //                 children: [
//   //                   Container(
//   //                     alignment: Alignment.centerLeft,
//   //                     child: Container(
//   //                         height: height*0.054,
//   //                         width: width*1,
//   //
//   //                         decoration: BoxDecoration(
//   //                             color: Colors.white,
//   //
//   //                             borderRadius: BorderRadius.circular(10)
//   //                         ),
//   //                         padding: EdgeInsets.only(left: width*0.05),
//   //                         child:DropdownButton(
//   //                           value: selectedoption,
//   //                           dropdownColor: Colors.white,
//   //                           onChanged: (value) {
//   //                             setState(() {
//   //                               selectedoption = value as String;
//   //                             });
//   //                           },
//   //                           underline: DropdownButtonHideUnderline(child: Text("")),
//   //                           icon: Icon(Icons.arrow_drop_down,color: bgcolor),
//   //                           isExpanded: true,
//   //
//   //                           hint: Container(
//   //                               alignment: Alignment.center,
//   //                               child: Text("Select Media")),
//   //                           items: social
//   //                               .map((e) => DropdownMenuItem(
//   //                               value: e, child: Padding(
//   //                             padding: const EdgeInsets.all(8.0),
//   //                             child: Container(
//   //
//   //                                 alignment: Alignment.center,
//   //                                 child: Image.asset(e)),
//   //                           )))
//   //                               .toList(),
//   //                         )
//   //                     ),
//   //
//   //                   ),
//   //
//   //                   SizedBox(height: height*0.025,),
//   //                   InkWell(
//   //                     onTap: (){
//   //
//   //                       if(!personal_connections!.contains(selectedoption)){
//   //
//   //                         personal_connections!.add(selectedoption!);
//   //
//   //                         Navigator.of(context).pop();
//   //                       }
//   //                       else{
//   //                         Navigator.of(context).pop();
//   //                       }
//   //                     },
//   //                     child: Container(
//   //                       alignment: Alignment.centerLeft,
//   //                       child: Container(
//   //                         height: height*0.054,
//   //                         width: width*1,
//   //
//   //                         decoration: BoxDecoration(
//   //                             color: Colors.white,
//   //
//   //                             borderRadius: BorderRadius.circular(10)
//   //                         ),
//   //
//   //                         child: Center(child: BuildBlackMuiliText(txt: "Save", fontsize: 0.025)),
//   //                       ),
//   //
//   //                     ),
//   //                   )
//   //
//   //
//   //                 ],
//   //               ),
//   //             ));
//   //       }));
//   // }
//
//   File ? profile_file;
//
//   File ? logo_file;
//
//   List<File>  accreditation_file=[];
//   List<String> ? accreditation_images=[];
//   List<File> ? images_file=[];
//   List<String>  images=[];
//
//
//   File ? bg_file;
//   TextEditingController videocontroller=TextEditingController();
//   String ? _showvideoDialog()
//   {
//     showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: Text("Enter Video URL"),
//           content: TextField(
//             decoration: InputDecoration(
//                 label: Text("Enter URL")
//             ),
//             controller: videocontroller,
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Okay'),
//               onPressed: (){
//                 Navigator.of(ctx).pop();
//               },
//             )
//           ],
//         )
//     );
//   }
//
//   void calculatepercentage(){
//     percentage=0.0;
//     if(profile_file!=null){
//       setState((){
//         print("yaar");
//         percentage=percentage+0.1;
//       });
//
//     }
//     if(videocontroller.text.isNotEmpty){
//
//       setState((){
//
//         percentage=percentage+0.1;
//       });
//     }
//     if(logo_file!=null){
//       print("yaar2");
//       setState((){
//         percentage=percentage+0.1;
//       });
//     }
//
//     if(mydetail!.name!.isNotEmpty &&
//         mydetail!.email!.isNotEmpty &&
//         mydetail!.contact_no!.isNotEmpty &&
//         mydetail!.title!.isNotEmpty  &&
//         mydetail!.location!.isNotEmpty &&
//         mydetail!.intro_heading!.isNotEmpty &&
//         mydetail!.paragraph!.isNotEmpty ){
//
//       setState((){
//         percentage=percentage+0.1;
//       });
//
//     }
//
//     if(businessdetail!.company_contact_no !.isNotEmpty &&
//         businessdetail!.company_sector!.isNotEmpty &&
//         businessdetail!.website!.isNotEmpty &&
//         businessdetail!.Business_name!.isNotEmpty){
//
//       setState((){
//         percentage=percentage+0.1;
//       });
//
//     }
//     if(personal_connections!.length>0){
//       setState((){
//         percentage=percentage+0.1;
//       });
//     }
//     if(business_connections!.length>0){
//       setState((){
//         percentage=percentage+0.1;
//       });
//     }
//     if(accreditation_file.length>0){
//       setState((){
//         percentage=percentage+0.1;
//       });
//     }
//     if(images_file!.length>0){
//       setState((){
//         percentage=percentage+0.1;
//       });
//     }
//
//     if(bg_file!=null){
//       setState((){
//         percentage=percentage+0.1;
//       });
//     }
//
//   }
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
//           accreditation_file.add(File(image!.path));
//         }
//         else  if(operation=="images"){
//           images_file!.add( File(image!.path));
//         }
//
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
//           accreditation_file.add(File(image!.path));
//         }
//         else  if(operation=="images"){
//           images_file!.add( File(image!.path));
//         }
//
//         else  if(operation=="bgimage"){
//           bg_file= File(image!.path);
//         }
//       });
//     }
//   }
//
//
//
//
//   YourDetails  ? mydetail=YourDetails(
//       email: '',
//       name: '',
//       title: '',
//       location: '',
//       contact_no: '',
//       intro_heading: '',
//       paragraph: ''
//   );
//   BusinessDetails ? businessdetail=BusinessDetails(
//       Business_name: '',
//       company_contact_no: '',
//       company_sector: '',
//       website: ''
//   );
//
//   Design_Appearance ? design_appearance=Design_Appearance(
//       BackgroundTheme: CustomColor( hexcode: "0xff000000"),
//       ButtonColor: CustomColor( hexcode: "0xff000000"),
//       TextColor:CustomColor( hexcode: "0xff000000"),
//   );
//
//   double percentage=0;
//   @override
//   Widget build(BuildContext context) {
//     final height=MediaQuery.of(context).size.height;
//     final width=MediaQuery.of(context).size.width;
//     calculatepercentage();
//     if(ModalRoute.of(context)!.settings.arguments!=null){
//       final data=ModalRoute.of(context)!.settings.arguments as String;
//       if(data!=null){
//         if(data=="true"){
//           team=true;
//         }
//         else{
//
//         }
//       }
//
//
//
//     }
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
//             Container(
//               margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
//               child:   Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//
//                   SizedBox(height: height*0.025,),
//                   BuildItalicText(txt: "Create Team Profile!", fontsize: 0.0358),
//                   SizedBox(height: height*0.02,),
//                   LinearProgressIndicator(
//                     value:percentage ,
//                     backgroundColor: Colors.white,
//                     color: mycolor,
//                     minHeight: height*0.023,
//                   ),
//                   SizedBox(height: height*0.02,),
//                   BuildItalicText(txt: '${(percentage*100).toStringAsFixed(1)}% Complete', fontsize: 0.0358),
//                   SizedBox(height: height*0.075,),
//
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       child: BuildWhiteMuiliTextBold(txt: "Complete Your Profile",fontsize: 0.028)),
//                   SizedBox(height: height*0.05,),
//
//                   Row(
//                     children: [
//                       InkWell(
//                         onTap: (){
//                           _show_my_Dialog("profile");
//                         },
//                         child: Container(
//                           height: height*0.14,
//                           width: width*0.23,
//                           child: Stack(
//                             children: [
//                               profile_file==null?
//
//                               CircleAvatar(
//                                 radius:width*0.2,
//                                 backgroundColor: Color(0xff111111),
//                                 child: Image.asset("images/logo.png",width: width*0.1,),
//                               )
//                                   :
//                               CircleAvatar(
//                                 radius:width*0.2,
//                                 backgroundImage: FileImage(profile_file!),
//                               ),
//
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
//                         onTap: (){
//                           _show_my_Dialog("logo");
//                         },
//                         child: Container(
//                           height: height*0.14,
//                           width: width*0.23,
//                           child: Stack(
//                             children: [
//                               logo_file==null?
//
//                               CircleAvatar(
//                                 radius:width*0.2,
//                                 backgroundColor: Color(0xff111111),
//                                 child: Image.asset("images/logo.png",width: width*0.1,),
//                               )
//                                   :
//                               CircleAvatar(
//                                 radius:width*0.2,
//                                 backgroundImage: FileImage(logo_file!),
//                               ),
//
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
//
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
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             mydetail!.name=value;
//                           },
//                           onFieldSubmitted: (value){
//                             mydetail!.name=value;
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
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             mydetail!.email=value;
//                           },
//                           onFieldSubmitted: (value){
//                             mydetail!.email=value;
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
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             mydetail!.contact_no=value;
//                           },
//                           onFieldSubmitted: (value){
//                             mydetail!.contact_no=value;
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
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             mydetail!.title=value;
//                           },
//                           onFieldSubmitted: (value){
//                             mydetail!.title=value;
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
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             mydetail!.location=value;
//                           },
//                           onFieldSubmitted: (value){
//                             mydetail!.location=value;
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
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             mydetail!.intro_heading=value;
//                           },
//                           onFieldSubmitted: (value){
//                             mydetail!.intro_heading=value;
//                           },
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//
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
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             mydetail!.paragraph=value;
//                           },
//                           onFieldSubmitted: (value){
//                             mydetail!.paragraph=value;
//                           },
//                           keyboardType: TextInputType.multiline,
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//                           decoration: InputDecoration(
//                               hintText: "Introduce yourself",
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
//                   SizedBox(height: height*0.075,),
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
//                           index==personal_connections!.length?
//
//                           InkWell(
//                             onTap: ()async{
//
//
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
//                                     image: AssetImage(personal_connections![index].media!)
//                                 )
//                             ),
//                           );
//                       },
//                       itemCount:  personal_connections!.length+1,
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
//
//                           index==accreditation_file.length? InkWell(
//                             onTap: (){
//                               _show_my_Dialog("accreditation");
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
//                                     image: FileImage(accreditation_file[index])
//                                 )
//                             ),
//                           );
//                       },
//                       itemCount:  accreditation_file.length+1,
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
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             businessdetail!.Business_name=value;
//                           },
//                           onFieldSubmitted: (value){
//                             businessdetail!.Business_name=value;
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
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             businessdetail!.company_sector=value;
//                           },
//                           onFieldSubmitted: (value){
//                             businessdetail!.company_sector=value;
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
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             businessdetail!.website=value;
//                           },
//                           onFieldSubmitted: (value){
//                             businessdetail!.website=value;
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
//                           validator: (value){
//                             if(value!.isEmpty){
//                               return 'invalid';
//                             }
//                           },
//                           onSaved: (value){
//                             businessdetail!.company_contact_no=value;
//                           },
//                           onFieldSubmitted: (value){
//                             businessdetail!.company_contact_no=value;
//                           },
//                           style: TextStyle(
//                             color: Color(0xff5D5D5D),
//                             fontFamily: 'Muli-Regular',
//
//                           ),
//                           keyboardType: TextInputType.number,
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
//                   Container(
//
//                     height: MediaQuery.of(context).size.height * 0.3,
//                     child: GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (ctx, index) {
//                         return
//
//                           index==business_connections!.length? InkWell(
//                             onTap: ()async{
//                               await  show_bottomsheet(personel: false);
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
//                                     image: AssetImage(business_connections![index].media!)
//                                 )
//                             ),
//                           );
//                       },
//                       itemCount:  business_connections!.length+1,
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
//                           design_appearance!.BackgroundTheme==0xff000000?
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
//                           ):
//                           Container(
//                             margin: EdgeInsets.only(left: width*0.02),
//                             child: CircleAvatar(
//                               radius: height*0.02,
//                               backgroundColor:Color(int.parse(design_appearance!.BackgroundTheme!.hexcode!)),
//                             ),
//                           ),
//                           Row(
//                             children:   List.generate(bgcolors.length, (index) =>
//                             bgcolors[index]==0xff000000?
//                             design_appearance!.BackgroundTheme==0xff000000?
//                             Text("")
//                                 :
//
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   design_appearance!.BackgroundTheme=CustomColor(
//                                       hexcode: bgcolors[index].toString());
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
//                                   design_appearance!.BackgroundTheme=CustomColor(hexcode: bgcolors[index].toString());
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
//                             bgcolors[index]==design_appearance!.BackgroundTheme?Text(""):
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   design_appearance!.BackgroundTheme=CustomColor(hexcode: bgcolors[index].toString());
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
//                       child: BuildWhiteMuiliTextBold(txt: "Text Colour",fontsize: 0.022)),
//
//                   Container(
//                     height: height*0.075,
//
//                     child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children:[
//
//                           design_appearance!.TextColor==0xff000000?
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
//                               backgroundColor:Color(int.parse(design_appearance!.TextColor!.hexcode!)),
//                             ),
//                           ),
//                           Row(
//                             children:   List.generate(bgcolors.length, (index) =>
//                             bgcolors[index]==0xff000000?
//                             design_appearance!.TextColor==0xff000000?
//                             Text("")
//                                 :
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   design_appearance!.TextColor=CustomColor( hexcode: bgcolors[index].toString());
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
//                                   design_appearance!.TextColor=CustomColor( hexcode: bgcolors[index].toString());
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
//                             bgcolors[index]==design_appearance!.TextColor?Text(""):
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   design_appearance!.TextColor=CustomColor( hexcode: bgcolors[index].toString() );
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
//                           design_appearance!.ButtonColor ==0xff000000?
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
//                               backgroundColor:Color(int.parse(design_appearance!.ButtonColor!.hexcode!)),
//                             ),
//                           ),
//                           Row(
//                             children:   List.generate(bgcolors.length, (index) =>
//                             bgcolors[index]==0xff000000?
//                             design_appearance!.ButtonColor==0xff000000?
//                             Text("")
//                                 :
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   design_appearance!.ButtonColor=CustomColor( hexcode: bgcolors[index].toString());
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
//                                   design_appearance!.ButtonColor=CustomColor( hexcode: bgcolors[index].toString())
//                                   ;
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
//                             bgcolors[index]==design_appearance!.ButtonColor?Text(""):
//
//                             InkWell(
//                               onTap: (){
//                                 setState((){
//                                   design_appearance!.ButtonColor=CustomColor( hexcode: bgcolors[index].toString());
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
//                       bg_file==null?
//                       InkWell(
//                         onTap: (){
//                           _show_my_Dialog("bgimage");
//                         },
//                         child: Container(
//                           width: width*0.49,
//                           height: height*0.22,
//                           decoration: BoxDecoration(
//                             color: addbg,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(
//                                 color: mycolor
//                             ),
//                           ),
//                           child: Icon(Icons.add,color: mycolor,size: 65),
//                         ),
//                       )
//                           :
//                       InkWell(
//                         onTap: (){
//                           _show_my_Dialog("bgimage");
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
//                                   image: FileImage(bg_file!)
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
//                         children: List.generate(images_file!.length+1, (index) => images_file!.length==index?
//                         InkWell(
//                           onTap: (){
//                             _show_my_Dialog("images");
//                           },
//                           child: Container(
//                             margin: EdgeInsets.only(right: width*0.025),
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
//                                   image: FileImage(images_file![index])
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
//                         videocontroller.text.isEmpty?
//                         InkWell(
//                           onTap: (){
//                             // _show_my_Dialog("video");
//                             _showvideoDialog();
//
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
//                             child: Icon(Icons.add,color: mycolor,size: 65),
//                           ),
//                         ):
//
//                         InkWell(
//                           onTap: (){
//                             // _show_my_Dialog("video");
//                             _showvideoDialog();
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
//
//                         if(videocontroller.text.isEmpty){
//                           _showErrorDialog("Please Enter video url");
//                         }
//                         else{
//
//                           calculatepercentage();
//                           _submit();
//
//                         }
//
//
//                       },
//                       child: BuildWhiteButton(text: "Create Profile")),
//                   SizedBox(height: height*0.075,),
//
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

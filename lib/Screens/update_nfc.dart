import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:saintconnect/Database/database.dart';
import 'package:saintconnect/Database/profile.dart';
import 'package:saintconnect/Screens/HomePage.dart';
import 'package:saintconnect/Screens/ProfileSuccess.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/MyProfile.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:url_launcher/url_launcher.dart';
class update_NFC extends StatefulWidget {
  static const routename="update_NFC";

  @override
  State<update_NFC> createState() => _update_NFCState();
}

class _update_NFCState extends State<update_NFC> {
    String cardtype='';
  bool trouble=false;
  bool holdcard=false;
  bool writing=false;
  String imageurl='';

  MyProfile ? connect_profile;
  @override
  void dispose() {
    // TODO: implement dispose
    NfcManager.instance.stopSession();
    super.dispose();
  }
  bool isloading=false;
  Future<Uint8List> get_unit8list_format(String url)async{
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
        .buffer
        .asUint8List();
    return bytes;
  }
  Future _ndefWrite(String docid) async{
    try{

      await  NfcManager.instance.startSession(

          onDiscovered: (NfcTag tag) async {
            setState(() {
              holdcard=true;
            });
            var ndef = Ndef.from(tag);
            if (ndef == null || !ndef.isWritable) {
              setState(() {
                holdcard=false;
              });
              NfcManager.instance.stopSession(errorMessage: "Tag is not ndef writable");
              return;
            }


            setState(() {
              writing=true;
              holdcard=false;
            });
            NdefMessage message = NdefMessage(
                [
                  // NdefRecord.createText("NFC Tag is written"
                  // ),
                  NdefRecord.createUri(Uri.parse(
                      'https://www.saintconnect.info/profile?uid=${docid}'

                  )),
                ]);


            try {
              await ndef.write(message);
              NfcManager.instance.stopSession();
              String result = 'Success to "Ndef Write"';

              await database.update_card(
                docid: docid,connected_profile_uid:connect_profile!.docid ,
                connected_profile_username: connect_profile!.your_details!.name,
              ).then((value) {

                NfcManager.instance.stopSession();

                Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routename, (route) => false);

              });


            } catch (e) {
              setState(() {

                holdcard=false;
                writing=false;
              });
              NfcManager.instance.stopSession(errorMessage: e.toString());
              launchUrl(Uri.parse("https://saintconnect.info/troubleshooting"));
              return;

            }
          });

    }catch( error){
      PlatformException e=error as PlatformException;
      setState(() {
        isloading=false;
        holdcard=false;
        writing=false;
      });
      _showErrorDialog(e.message.toString());

    }

  }


  Future _showErrorDialog(String msg) async{
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    await showDialog(
        context: context,
        builder: (ctx) =>

            AlertDialog(
              backgroundColor: Color(0xff111111),
              title: BuildItalicText(txt: "An Error Occured", fontsize: 0.028),
              content: BuildWhiteMuiliText(txt: msg, fontsize: 0.018),
              actions: <Widget>[
                TextButton(
                  child: BuildItalicTextwhite(txt: "Okay", fontsize: 0.023),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            )

    );

  }

   String ? docid;






  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    List<dynamic> data=ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    if(data!=null && data.length>0){
      cardtype=data[0].toString();
      imageurl=data[1].toString();
      connect_profile=data[2];
      docid=data[3];
    }

    return Scaffold(

      backgroundColor: bgcolor,

      body:


      ListView(

        children: [
          SizedBox(height: height*0.025,),
          Container(

            height: height*0.05,
            child: Row(

              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Container(
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.088),
                  child: IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.arrow_back,color: Colors.white,size: width*0.075,)),
                ),



              ],
            ),
          ),
          SizedBox(height: height*0.05,),
          Container(
              margin: EdgeInsets.only(left: width*0.15,right: width*0.15),
              child: BuildWhiteMuiliTextBold(txt: "Tap the button below to begin activation.", fontsize: 0.0305)),
          SizedBox(height: height*0.05,),

          Container(

            height: height*0.5,
            width: width*0.9,

            child: Stack(
              children: [
                Positioned(
                  bottom: height*0.02,
                  right: 0,
                  child:   Container(
                      alignment: Alignment.centerRight,
                      width: width*1,
                      height: height*0.4,
                      margin: EdgeInsets.only(right: width*0.1,
                          left: width*0.1
                      ),
                      color: bgcolor,


                      child: Image.asset("images/welcome.gif",)

                  ),

//                   child: Container(
// height: height*0.38,
//                       width: width*0.5,
//                       margin: EdgeInsets.only(left: width*0.05),
//                   decoration: BoxDecoration(
//
//                     image: DecorationImage(image: AssetImage("images/5cb0633d80f2cf201a4c3253.png"),
//                     fit: BoxFit.fill
//                     )
//                   ),
//
//                     child: Column(
//                       children: [
//                         Container(
//
//                           height: height*0.35,
//                           width: width*0.5,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                             image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: AssetImage("images/welcome.gif")
//                             )
//                           ),
//                             alignment: Alignment.bottomCenter,
//
//                             margin: EdgeInsets.only(left: width*0.08,right: width*0.1,top: height*0.01),
//
//
//
//                         ),
//                       ],
//                     ),
//                   ),
                ),
                // (cardtype=="White Connect Card" )?
                // Container(
                //   height: height*0.2,
                //   width: width*0.65,
                //   margin: EdgeInsets.only(left: width*0.1),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     boxShadow: [
                //       BoxShadow(
                //           color: Color(0xffDAC07A),
                //           blurRadius: 10
                //       )
                //     ],
                //
                //   ),
                //   padding: EdgeInsets.only(bottom: width*0.1,left: height*0.015),
                //   child: RotatedBox (
                //       quarterTurns: 3,
                //       child: BuildText(txt: "Connect",fontsize: 0.03))
                // ):
                // cardtype=="Black Connect Card"?
                // Container(
                //   height: height*0.195,
                //   width: width*(1-0.4),
                //   margin: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.0075,bottom: height*0.01),
                //   child: AspectRatio(
                //     aspectRatio: 17/11,
                //     child: Center(
                //       child: Container(
                //         // height: height*0.16,
                //         // width: width*1,
                //         decoration: BoxDecoration(
                //           color: Colors.black,
                //           boxShadow: [
                //             BoxShadow(
                //                 color: Color(0xffDAC07A),
                //                 blurRadius: 10
                //             )
                //           ],
                //
                //         ),
                //
                //         padding: EdgeInsets.only(left: height*0.015),
                //         child:
                //
                //
                //         Container(
                //
                //           alignment: Alignment.centerLeft,
                //
                //           child: RotatedBox (
                //               quarterTurns: 1,
                //               child: BuildItalicText(txt: "Connect",fontsize: 0.025)),
                //         )
                //         ,
                //       ),
                //     ),
                //   ),
                // ):
                // Container(
                //   height: height*0.2,
                //   width: width*(1),
                //   margin: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.0075,bottom: height*0.01),
                //   child: AspectRatio(
                //     aspectRatio: 17/11,
                //     child: Center(
                //       child: Container(
                //         // height: height*0.16,
                //         // width: width*1,
                //         decoration: BoxDecoration(
                //           color: Colors.black,
                //           boxShadow: [
                //             BoxShadow(
                //                 color: Color(0xffDAC07A),
                //                 blurRadius: 10
                //             )
                //           ],
                //
                //         ),
                //
                //
                //         child:
                //
                //
                //         AspectRatio(
                //           aspectRatio: 17/11,
                //           child: Image.network(imageurl,fit: BoxFit.cover,),
                //         )
                //         ,
                //       ),
                //     ),
                //   ),
                // )
                //
                // ,


              ],
            ),
          ),
          SizedBox(height: height*0.05,),

          holdcard?
          Container(
              margin: EdgeInsets.only(bottom: height*0.1),
              alignment: Alignment.bottomCenter,
              height: height*0.1,

              child: Column(
                  children: [
                    Container(

                        child: BuildButton(text: "Hold Card to device",fontsize: 0.0253,)),
                    SizedBox(height: height*0.015,),
                    InkWell(
                        onTap: (){
                          launchUrl(Uri.parse("https://saintconnect.info/troubleshooting"));
                        },
                        child: BuildWhiteMuiliText(txt: "Trouble Activating?",
                          fontsize: 0.012,
                        )),
                  ]
                //   BuildButton(text: "Hold Card to device",fontsize: 0.0253,),
                //   SizedBox(height: height*0.02,),
                //   InkWell(
                //       onTap: (){
                //         launchUrl(Uri.parse("https://saintconnect.info/troubleshooting"));
                //       },
                //       child: BuildWhiteMuiliText(txt: "Troubleshooting",
                //       fontsize: height*0.012,
                //       ))
                // ],
              )):
          writing?
          Center(child: BuildButton(text: "Writing",fontsize: 0.0253,))
              :
          InkWell(

              onTap: () async {

                setState((){
                  isloading=true;
                  holdcard=true;
                });

                await  _ndefWrite(docid!).then((value) {

                });

              },
              child: Column(
                children: [
                  BuildButton(text: "Begin Activation",fontsize: 0.0253,),
                  if(trouble)
                    SizedBox(height: height*0.015,),
                  if(trouble)
                    InkWell(
                        onTap: (){
                          launchUrl(Uri.parse("https://saintconnect.info/troubleshooting"));
                        },
                        child: BuildWhiteMuiliText(txt: "Trouble Activating?",
                          fontsize: 0.012,
                        )),
                ],
              ))


        ],
      ),
    );
  }
}


// class update_NFC extends StatefulWidget {
//   static const routename="update_NFC";
//
//   @override
//   State<update_NFC> createState() => _update_NFCState();
// }
//
// class _update_NFCState extends State<update_NFC> {
//   String cardtype='';
//   bool trouble=false;
//   bool holdcard=false;
//   bool writing=false;
//   String imageurl='';
//
//   MyProfile ? connect_profile;
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     NfcManager.instance.stopSession();
//     super.dispose();
//   }
//   bool isloading=false;
//   Future<Uint8List> get_unit8list_format(String url)async{
//     Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
//         .buffer
//         .asUint8List();
//     return bytes;
//   }
//   Future _ndefWrite(String docid) async{
//     try{
//
//       await  NfcManager.instance.startSession(
//
//           onDiscovered: (NfcTag tag) async {
//             setState(() {
//               holdcard=true;
//             });
//             var ndef = Ndef.from(tag);
//             if (ndef == null || !ndef.isWritable) {
//               setState(() {
//                 holdcard=false;
//               });
//               NfcManager.instance.stopSession(errorMessage: "Tag is not ndef writable");
//               return;
//             }
//
//
//             setState(() {
//               writing=true;
//               holdcard=false;
//             });
//             NdefMessage message = NdefMessage(
//                 [
//                   // NdefRecord.createText("NFC Tag is written"
//                   // ),
//                   NdefRecord.createUri(Uri.parse('https://saint-connect.webflow.io/profile?uid?${docid.toString()}')),
//                   // NdefRecord.createMime(
//                   //     'text/plain', Uint8List.fromList("https://saint-connect.webflow.io/profile?uid?${docid.toString()}".toString().codeUnits)),
//
//                 ]);
//
//
//             try {
//               await ndef.write(message);
//               NfcManager.instance.stopSession();
//               String result = 'Success to "Ndef Write"';
//
//               await database.update_card(
//                 docid: docid,connected_profile_uid:connect_profile!.docid ,
//                 connected_profile_username: connect_profile!.your_details!.name,
//               ).then((value) {
//
//                 NfcManager.instance.stopSession();
//
//                 Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routename, (route) => false);
//
//               });
//
//
//             } catch (e) {
//               setState(() {
//
//                 holdcard=false;
//                 writing=false;
//               });
//               NfcManager.instance.stopSession(errorMessage: e.toString());
//               launchUrl(Uri.parse("https://saintconnect.info/troubleshooting"));
//               return;
//
//             }
//           });
//
//     }catch( error){
//       PlatformException e=error as PlatformException;
//       setState(() {
//         isloading=false;
//         holdcard=false;
//         writing=false;
//       });
//       _showErrorDialog(e.message.toString());
//
//     }
//
//   }
//
//   Future<void> _launchUrl(String url) async {
//     if (!await launchUrl(Uri.parse(url))) {
//       throw 'Could not launch $url';
//     }
//   }
//   Future _showErrorDialog(String msg) async{
//     final height=MediaQuery.of(context).size.height;
//     final width=MediaQuery.of(context).size.width;
//     await showDialog(
//         context: context,
//         builder: (ctx) =>
//
//             AlertDialog(
//               backgroundColor: Color(0xff111111),
//               title: BuildItalicText(txt: "An Error Occured", fontsize: 0.028),
//               content: BuildWhiteMuiliText(txt: msg, fontsize: 0.018),
//               actions: <Widget>[
//                 TextButton(
//                   child: BuildItalicTextwhite(txt: "Okay", fontsize: 0.023),
//                   onPressed: () {
//                     Navigator.of(ctx).pop();
//                   },
//                 )
//               ],
//             )
//
//     );
//
//   }
//   Future<String> addPosts() async {
//
//
//     Map<String, dynamic> data = {
//       'card_type':cardtype,
//       'card_image':imageurl,
//       'userid':currentuser!.uid,
//       'connected_profile_uid':connect_profile!.docid,
//       'connected_profile_username':connect_profile!.your_details!.name,
//
//     };
//
//     CollectionReference collection =
//     FirebaseFirestore.instance.collection('Cards');
//     DocumentReference result=await  collection.add(data);
//     return result.id;
//   }
//
//   String ? docid;
//
//   @override
//   Widget build(BuildContext context) {
//     final height=MediaQuery.of(context).size.height;
//     final width=MediaQuery.of(context).size.width;
//     List<dynamic> data=ModalRoute.of(context)!.settings.arguments as List<dynamic>;
//     if(data!=null && data.length>0){
//       cardtype=data[0].toString();
//       imageurl=data[1].toString();
//       connect_profile=data[2];
//       docid=data[3];
//     }
//     return Scaffold(
//       backgroundColor: bgcolor,
//
//       body
//
//
//           :
//       holdcard?
//       Container(
//           margin: EdgeInsets.only(bottom: height*0.1),
//           alignment: Alignment.bottomCenter,
//           child: BuildButton(text: "Hold Card to device",fontsize: 0.0253,)):
//       writing?
//       Center(child: BuildButton(text: "Writing",fontsize: 0.0253,)):
//       trouble?
//       Center(child: InkWell(
//           onTap: (){
//             launchUrl(Uri.parse("https://saintconnect.info/troubleshooting"));
//           },
//           child: BuildButton(text: "Trouble Activating?",fontsize: 0.0253,)))
//           :
//
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: height*0.05,),
//           Container(
//             margin: EdgeInsets.only(left: width*0.1),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 IconButton(onPressed: (){
//                   Navigator.of(context).pop();
//                 }, icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,)),
//               ],
//             ),
//           ),
//           SizedBox(height: height*0.05,),
//           Container(
//               margin: EdgeInsets.only(left: width*0.15,right: width*0.15),
//               child: BuildWhiteMuiliTextBold(txt: "Tap the button below to begin activation.", fontsize: 0.0305)),
//           SizedBox(height: height*0.05,),
//
//           Container(
//
//             height: height*0.5,
//             width: width*0.9,
//
//             child: Stack(
//               children: [
//                 Container(
//                     height: height*0.2,
//                     width: width*0.65,
//                     margin: EdgeInsets.only(left: width*0.1),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                             color: Color(0xffDAC07A),
//                             blurRadius: 10
//                         )
//                       ],
//
//                     ),
//                     padding: EdgeInsets.only(bottom: width*0.1,left: height*0.015),
//                     child: RotatedBox (
//                         quarterTurns: 3,
//                         child: BuildText(txt: "Connect",fontsize: 0.03))
//                 ),
//                 Positioned(
//                   bottom: height*0.02,
//                   right: 0,
//
//                   child: Container(
//                     height: height*0.38,
//                     width: width*0.5,
//                     margin: EdgeInsets.only(left: width*0.05),
//                     decoration: BoxDecoration(
//
//                         image: DecorationImage(image: AssetImage("images/5cb0633d80f2cf201a4c3253.png"),
//                             fit: BoxFit.fill
//                         )
//                     ),
//
//                     child: Column(
//                       children: [
//                         Container(
//
//                           height: height*0.35,
//                           width: width*0.5,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20),
//                               image: DecorationImage(
//                                   fit: BoxFit.fill,
//                                   image: AssetImage("images/Saint-Animation.gif")
//                               )
//                           ),
//                           alignment: Alignment.bottomCenter,
//
//                           margin: EdgeInsets.only(left: width*0.08,right: width*0.1,top: height*0.01),
//
//
//
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//           SizedBox(height: height*0.05,),
//
//           holdcard?
//           Container(
//               margin: EdgeInsets.only(bottom: height*0.1),
//               alignment: Alignment.bottomCenter,
//               child: BuildButton(text: "Hold Card to device",fontsize: 0.0253,)):
//           writing?
//           Center(child: BuildButton(text: "Writing",fontsize: 0.0253,))
//               :
//           InkWell(
//
//               onTap: () async {
//
//                 setState((){
//                   isloading=true;
//                   holdcard=true;
//                 });
//
//
//
//
//                   await  _ndefWrite(docid!).then((value) {
//
//
//                   });
//
//
//               },
//               child: BuildButton(text: "Begin Activation",fontsize: 0.0253,))
//
//
//         ],
//       ),
//     );
//   }
// }

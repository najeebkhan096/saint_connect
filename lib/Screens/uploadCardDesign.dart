import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:saintconnect/Screens/MyCardStage2.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/widgets/bottomnavigattionbar.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;


class UploadCardDesign extends StatefulWidget {

  static const routename="UploadCardDesign";

  @override
  State<UploadCardDesign> createState() => _UploadCardDesignState();
}

class _UploadCardDesignState extends State<UploadCardDesign> {


  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text("Post Body is Empty"),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ));
  }

  String ? email;

  final picker = ImagePicker();
  Future<File?> _show_my_Dialog() async{
    File ? choosedfile;
    await  showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            backgroundColor: Color(0xff111111),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    onTap: () async{
                      await  getfilename(1).then((value) async {
                        choosedfile=value;
                        Navigator.pop(context,value);
                      });
                    },
                    leading: Icon(
                      Icons.camera,
                      color: Color(0xffDAC07A),
                    ),
                    title: BuildItalicText(txt: "Camera", fontsize: 0.025),
                  ),
                  ListTile(
                    onTap: () async{
                      await getfilename(2).then((value) {
                        choosedfile=value;
                        Navigator.pop (context,value);
                      });
                    },
                    leading: Icon(
                      Icons.image,
                      color: Color(0xffDAC07A),
                    ),
                    title: BuildItalicText(txt: "Gallery", fontsize: 0.025),
                  )
                ],
              ),
            )));
    return choosedfile;
  }


  File ? filename;

  bool uploading=false;

  Future getfilename(int choice) async {
    if (choice == 1) {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.camera);
      setState(() {
        filename = File(image!.path);
      });
    } else {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        filename = File(image!.path);
      });
    }
  }

  double percentage=0;

  String ? image_url;

  CollectionReference ? imgRef;

  firebase_storage.Reference ? ref;

  Future uploadFile() async {

    print("upload file fnc "+image_url.toString());
    setState(() {
      uploading=true;
    });
    try{
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('post/${Path.basename(filename!.path)}');


      await ref!.putFile(filename!).whenComplete(() async {
        await ref!.getDownloadURL().then((value) async {
          image_url=value;

        });
      });



    }
    catch(error){
      setState(() {
        setState(() {
          uploading=false;
        });
        isloading=false;
      });
    }

  }
bool isloading=false;
  String cardtype='';
  @override

  Widget build(BuildContext context) {

    final height=MediaQuery.of(context).size.height;

    final width=MediaQuery.of(context).size.width;

    cardtype=ModalRoute.of(context)!.settings.arguments as String;
    print(cardtype);

    return Scaffold(

backgroundColor: bgcolor,

      body: ListView(

        children: [
          SizedBox(height: height*0.01,),
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

                Image.asset("images/logo.png",height: height*0.05,fit: BoxFit.fill,),

                SizedBox(width: width*0.025,),

                BuildItalicText(txt: "Connect", fontsize: 0.0358),

              ],
            ),
          ),

          SizedBox(height: height*0.1,),

          Center(child: BuildWhiteMuiliTextBold(txt: "Upload your Card Design", fontsize: 0.0305)),

          SizedBox(height: height*0.05,),

          InkWell(
              onTap: (){
                _show_my_Dialog();
              },
              child:

              filename==null?
              BuildUploadCardDesign(context):
              Container(
                height: height*0.275,
                width: width*1,
                decoration: BoxDecoration(
                    color: bgcolor,
                    border: Border.all(
                        color: mycolor,
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                child: Image.file(filename!,fit: BoxFit.cover),
              )
          )
          ,

          SizedBox(height: height*0.1,),
uploading?
    SpinKitCircle(color: Colors.white,)
    :
          InkWell(

            onTap: () async {

             if(filename!=null){
             await   uploadFile().then((value) {
               if(image_url!.isNotEmpty){
                 Navigator.of(context).pushNamed(MyCardStage2.routename,arguments: [
                   cardtype,
                   image_url
                 ]);
               }
             });
             }

              },

            child: BuildButton(text: "Continue",fontsize: 0.0253),
          )

        ],

      ),
bottomNavigationBar: Home_Bottom_Navigation_BAr(),
    );


  }

  Widget BuildUploadCardDesign(BuildContext context){

    final height=MediaQuery.of(context).size.height;

    final width=MediaQuery.of(context).size.width;

    return   Container(
      height: height*0.275,
      width: width*1,
      decoration: BoxDecoration(
        color: bgcolor,
        border: Border.all(
          color: mycolor,
          width: 0.5
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Image.asset("images/uplaod.png"),
          SizedBox(height: height*0.025,),

          Text("Upload your Card Design",style: TextStyle(
            color: Color(0xffDAC07A),
            fontFamily: 'Muli-Regular',
            fontSize: height*(0.0215),

          ),),

          SizedBox(height: height*0.01,),
          Container(
              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
              child: Text( "This will be displayed on the MyCards Section. Upload 1050x600px for best results. Otherwise there might be blurring or cut-outs.  ",
                  style: TextStyle(
                    color: Color(0xffDAC07A),
                    fontFamily: 'Muli-Regular',
                    fontSize: height*(0.0145),

                  )
              ))
        ],
      ),
    );
  }
}
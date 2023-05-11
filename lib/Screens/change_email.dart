import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saintconnect/Database/database.dart';
import 'package:saintconnect/Screens/HomePage.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/MyProfile.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:saintconnect/widgets/wrapper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:saintconnect/auth/auth.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:saintconnect/widgets/wrapper.dart';

class ChangeEmail extends StatefulWidget {

  static const routename="ChangeEmail";

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {



  String ? ChangeEmail;

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isloading=false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      isloading=true;
    });

    _changeEmail(current_email: currentuser!.email!, newEmail: ChangeEmail!,password: password);
  }


  String ? _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error Accured'),
          content: Text(msg.toString()),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }

String password='';
  void _changeEmail({required String current_email,required String newEmail,String ?password}) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: password!);
    print("Hello");
    await  user.reauthenticateWithCredential(cred).then((value) async{
      print("step2 "+value.toString() );

      await user.updateEmail(ChangeEmail!).then((_) async{
        //Success, do something

       await  database.update_email(newEmail).then((value) {
          currentuser!.email=newEmail;
          print("done succesfully");

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text("Email Successfully Changed")));
          Navigator.of(context).pop();
        });

      }).catchError((error) {
        //Error, show something
        setState(() {
          isloading=false;
        });
        print("failed "+error.toString());
        _showErrorDialog(error.toString());
      });
    }).catchError((err) {
      setState(() {
        isloading=false;
      });
      _showErrorDialog(err.toString());
    });}

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgcolor,

      body: Form(
        key: _formKey,
        child: ListView(
          children: [

            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width*0.05,right: width*0.075),
              child: IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,)),
            ),
            SizedBox(height: height*0.02,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
              child:       Image.asset("images/logo.png",height: height*0.05,),
            ),
            SizedBox(height: height*0.01,),

            Container(
              margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
              child: BuildItalicText(txt: "Change Email",fontsize: 0.035,),
            ),

            SizedBox(height: height*0.05,),
            //current pass
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
              child: BuildWhiteMuiliTextBold(txt: "Current Email", fontsize: 0.02),
            ),

            SizedBox(height: height*0.015,),

            Container(
                height: height*0.06,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                decoration: BoxDecoration(
                    color: Color(0xff2A2A2A),
                    border: Border.all(
                      color: mycolor,
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.only(left: width*0.05),
                alignment: Alignment.centerLeft,
                child:Text(
                  currentuser!.email!,
                  style: TextStyle(
                      color: Color(0xffffffff),
                      fontFamily: 'Muli-Regular',
                      fontSize: width*(0.038),
                      fontWeight: FontWeight.bold

                  ),
                )
            ),

            //new


            SizedBox(height: height*0.05),

            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
              child: BuildWhiteMuiliTextBold(txt: "New Email", fontsize: 0.02),
            ),

            SizedBox(height: height*0.015,),

            Container(
                height: height*0.06,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                decoration: BoxDecoration(
                    color: Color(0xff2A2A2A),
                    border: Border.all(
                      color: mycolor,
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.only(left: width*0.05),
                child:TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "invalid";
                    }
                  },
                  onSaved: (value){
                    ChangeEmail=value;
                  },
                  onFieldSubmitted: (value){
                    ChangeEmail=value;
                  },
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xffffffff),
                      fontFamily: 'Muli-Regular',
                      fontSize: width*(0.038),
                      fontWeight: FontWeight.bold

                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelStyle:TextStyle(
                          color: Color(0xff000000),
                          fontFamily: 'Muli-Regular',
                          fontSize: width*(0.025),
                          fontWeight: FontWeight.bold

                      )
                  ),
                )
            ),

            SizedBox(height: height*0.015,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
              child: BuildWhiteMuiliTextBold(txt: "Current Password", fontsize: 0.02),
            ),

            SizedBox(height: height*0.015,),

            Container(
                height: height*0.06,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                decoration: BoxDecoration(
                    color: Color(0xff2A2A2A),
                    border: Border.all(
                      color: mycolor,
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.only(left: width*0.05),
                child:TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "invalid";
                    }
                  },
                  onSaved: (value){
                    password=value!;
                  },
                  onFieldSubmitted: (value){
                    password=value;
                  },
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xffffffff),
                      fontFamily: 'Muli-Regular',
                      fontSize: width*(0.038),
                      fontWeight: FontWeight.bold

                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelStyle:TextStyle(
                          color: Color(0xff000000),
                          fontFamily: 'Muli-Regular',
                          fontSize: width*(0.025),
                          fontWeight: FontWeight.bold

                      )
                  ),
                )
            ),


            SizedBox(height: height*0.05),

            isloading?
            SpinKitRing(color: Colors.white)
                :
            InkWell(
                onTap: (){
                  _submit();
                },

                child: Container(
                    margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                    child: BuildWhiteButton(text: "Change Email"))),


            SizedBox(height: height*0.025,),

          ],
        ),
      ),
    );
  }
}

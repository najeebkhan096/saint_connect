import 'package:google_sign_in/google_sign_in.dart';
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

class DeleteAccountScreen extends StatefulWidget {

  static const routename="DeleteAccountScreen";

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {


  String ? password;


  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isloading=false;

  Future<void> googleSignIn(BuildContext context) async {
    print("Google Sign function");
    final googleSignIn = GoogleSignIn();
    final signInAccount = await googleSignIn.signIn();

    final googleAccountAuthentication = await signInAccount!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAccountAuthentication.accessToken,
        idToken: googleAccountAuthentication.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        print('Google Authentication Successful');
        print('${FirebaseAuth.instance.currentUser!.displayName} signed in.');

        FirebaseAuth _auth = FirebaseAuth.instance;
        User? newuser = _auth.currentUser;


      } else {
        print('Unable to sign in');
      }
    } catch (error) {

    }
  }
  // Get the current Firebase user
  final FirebaseAuth auth = FirebaseAuth.instance;
   User ? user ;
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
bool fetched=false;
  bool isGoogleSignIn = false;
  bool isEmailSignIn = false;
@override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies

  if(fetched==false){
  user= auth.currentUser;
    if (user != null) {
      final List<UserInfo> providerData = user!.providerData;

      for (UserInfo userInfo in providerData) {
        if (userInfo.providerId == 'google.com') {

          setState(() {
            isGoogleSignIn = true;
            fetched=true;
          });
        } else if (userInfo.providerId == 'password') {

          setState(() {
            fetched=true;
            isEmailSignIn = true;
          });
        }
      }



      // Additional checks for other providers if needed

    } else {
      // No signed-in user
      print('No user is currently signed in');
    }


  }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgcolor,
      body: Form(
        key: _formKey,
        child:

        fetched==false?
            Container(
              height: height*1,
              width: width*1,
              child: Center(
                child: SpinKitCircle(
                  color: Colors.white,
                ),
              ),
            )
            :
        ListView(
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
              child: BuildItalicText(txt: "Delete Account",fontsize: 0.035,),
            ),

            SizedBox(height: height*0.05,),

            //current pass
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
              child: BuildWhiteMuiliTextBold(txt: "Email", fontsize: 0.02),
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
                child:Text(currentuser!.email.toString(),
                style:  TextStyle(
                    color: Color(0xffffffff).withOpacity(0.5),
                    fontFamily: 'Muli-Regular',
                    fontSize: width*(0.038),
                    fontWeight: FontWeight.bold

                ),
                )
            ),

            //new


            SizedBox(height: height*0.05),
if(isEmailSignIn==true)
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
              child: BuildWhiteMuiliTextBold(txt: "Password", fontsize: 0.02),
            ),

            SizedBox(height: height*0.015,),
            if(isEmailSignIn==true)
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
                  onChanged: (val){
                    password=val;
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "invalid";
                    }
                  },
                  onSaved: (value){
                    password=value;
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

            SizedBox(height: height*0.015,),



            SizedBox(height: height*0.05),

            isloading?
            SpinKitRing(color: Colors.white)
                :
            InkWell(
                onTap: ()async{

                  if (isGoogleSignIn) {

                    // User signed in with Google
                    print('User is signed in with Google');
                    // Get the Google Sign-In authentication credentials
                    print("Google Sign function");
                    final googleSignIn = GoogleSignIn();
                    final googleSignInAccount = await googleSignIn.signIn();

                    if (googleSignInAccount != null) {
                      final GoogleSignInAuthentication googleAuth =
                      await googleSignInAccount.authentication;

                      // Refresh the Firebase authentication token
                      final AuthCredential credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      );

                      await user!.reauthenticateWithCredential(credential).then((value) async {

                        final User? user = value.user;

// Delete the user account
                        if (user != null) {
                          await user.delete().then((value) async {

                            await database. delete_user_docid(user: user,context: context,

                                googlesigned_in: true
                            ).then((res) async{
                              if(res!=null){
                                if(res=='success'){

                                }
                                else{
                                  _showErrorDialog(res.toString());
                                }
                              }
                            });
                          });
                        }
                      });

                      // Now you can proceed with the desired sensitive operation
                    }
                    else{

                    }


                  }

                  if (isEmailSignIn) {
                    // User signed in with email/password
                    print('User is signed in with email/password');
                    if(password!=null && password!.isNotEmpty){
                      setState(() {
                        isloading=true;
                      });
                      await database.deleteUserwith_password(
                          password: password,
                          context:
                          context).then((value) {
                        print("done");
                        setState(() {
                          isloading=false;
                        });

                      });
                    }
                    else{
                      _showErrorDialog("Please Enter password");
                    }
                  }



                },

                child: Container(
                    margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                    child: BuildWhiteButton(text: "Delete Account"))),


            SizedBox(height: height*0.025,),

          ],
        ),
      ),
    );
  }
}

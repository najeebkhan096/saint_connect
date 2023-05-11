import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:saintconnect/Database/database.dart';
import 'package:saintconnect/Screens/CreateProfile.dart';
import 'package:saintconnect/Screens/forget_password/enter_email.dart';
import 'package:saintconnect/Screens/webview.dart';
import 'package:saintconnect/auth/auth.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:saintconnect/widgets/wrapper.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateAccount extends StatefulWidget {
  static const routename="CreateAccount";

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
bool secure=true;
  bool isloading=false;
  bool isloginloading=false;
bool fb=false;
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  File ? myfile;
  String ? QRImage='';

  Widget Qrimage(){
    return Screenshot(
      controller: screenshotController,
      child: Container(
        height: MediaQuery.of(context).size.height*0.25,
        width: MediaQuery.of(context).size.width*0.5,
        child: QrImage(
          foregroundColor: Color(0xffDAC07A),
          data: "https://saint-connect.webflow.io/profile?uid=${currentuser!.uid.toString()}",
          version: QrVersions.auto,
          size: MediaQuery.of(context).size.height*0.25,
          gapless: false,
        ),
      ),
    );
  }

  Future GenerateQRCode(String documentid)async{

    final Uint8List ? image=await screenshotController.captureFromWidget(Qrimage());

    if(image!=null){
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/$user_id.jpg').create();
      file.writeAsBytesSync(image);
      setState(() {
        myfile=file;
      });

      await database.uploadQR(docid: documentid);
    }
  }



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

        Database _database = Database();
        bool ? data = await _database.finduserByEmail(email: newuser!.email!);
        if (data==true) {
          Fluttertoast.showToast(
              msg: "Succesfully logged in",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pushNamedAndRemoveUntil(
              context, Wrapper.routename, (route) => false);
        }
        else {
          await database.adduser(userid: newuser.uid,

            imageurl: newuser.photoURL.toString(),
            email: newuser.email,

          ).then((value) async {
            await GenerateQRCode( value).then((value) async {
              Fluttertoast.showToast(
                  msg: "Account is Created",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              Navigator.pushNamedAndRemoveUntil(
                  context, Wrapper.routename, (route) => false);
            });
          });
        }
      } else {
        print('Unable to sign in');
      }
    } catch (error) {

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
              title: BuildItalicText(txt: "An Error Occured", fontsize: 0.025),
              content: BuildWhiteMuiliText(txt: msg, fontsize: 0.02),
              actions: <Widget>[
                TextButton(
                  child: BuildItalicTextwhite(txt: "Okay", fontsize: 0.025),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            )

    );

  }

  AuthService _auth=AuthService();


  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();


    if(email==null || email!.isEmpty){
      _showErrorDialog("Please Enter valid email");
    }
    else if(password==null || password!.isEmpty){
      _showErrorDialog("Please Enter Password");
    }
    else{
      setState(() {
        isloginloading=true;
      });
      try {
        final  User result =await  _auth.signInWithEmailAndPassword(email!, password!);
        Navigator.pushNamedAndRemoveUntil(context, Wrapper.routename, (route) => false);
      } catch (error) {
        setState(() {
          isloginloading=false;
        });
        if(error.toString().contains("The password is invalid or the user does not have a password.")){
          _showErrorDialog("The password is invalid or this user already exists. Please try again or log in.");
        }
        else{
          print("error isss "+error.toString());
          if(error.toString()=="The email address is badly formatted."){
            _showErrorDialog("The email address is poorly formatted.");

          }
          else{
            _showErrorDialog(error.toString());

          }
        }
      }
    }


  }

  String ? name;

  String ? email='';

  String ? password='';

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
              margin: EdgeInsets.only(left: width*0.05,right: width*0.075,),
              child: IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: Icon(Icons.arrow_back,color: Colors.white,size: width*0.075,)),
            ),
            SizedBox(height: height*0.01,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
              child:       Image.asset("images/logo.png",height: height*0.05,),
            ),



            SizedBox(height: height*0.01,),

            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
              child: BuildItalicText(txt: "Welcome Back",fontsize: 0.032,),
            ),









            SizedBox(height: height*0.05),

            Container(
              alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                child: BuildWhiteText(txt: "Email Address", fontsize: 0.025)),

            SizedBox(height: height*0.015,),

            Container(
                height: height*0.055,
                // width: width*1,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                decoration: BoxDecoration(
                    color: Color(0xff2A2A2A),
                    border: Border.all(
                      color: mycolor,
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.only(left: width*0.05,bottom: height*0.01),
                child:TextFormField(
                  validator: (value){

                  },
                  onSaved: (value){
                    email=value;
                  },
                  onFieldSubmitted: (value){
                    email=value;
                  },
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Muli-Regular',

                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                )
            ),

            SizedBox(height: height*0.015,),

            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                child: BuildWhiteText(txt: "Password", fontsize: 0.025),
            ),

            SizedBox(height: height*0.015,),


            Container(
                height: height*0.055,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                decoration: BoxDecoration(
                    color: Color(0xff2A2A2A),
                    border: Border.all(
                      color: mycolor,
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.only(left: width*0.05,bottom: height*0.005,
                right: width*0.025
                ),
alignment: Alignment.center,
                child:TextFormField(
                  obscureText: secure,
                  validator: (value){

                  },
                  onSaved: (value){
                    password=value;
                  },
                  onFieldSubmitted: (value){
                    password=value;
                  },
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Muli-Regular',

                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                    suffixIcon:
                    InkWell(
                        onTap: (){
                          setState(() {
                            secure=!secure;
                          });
                        },
                        child:
                        secure?
                        Container(

                          height: height*0.055,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.visibility,color: goldencolor),
                            ],
                          ),
                        ):
                        Container(
                          height: height*0.055,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.visibility_off,color: goldencolor),
                            ],
                          ),
                        )


                    ),

                  ),
                )
            ),

            SizedBox(height: height*0.025,),

            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return EnterEmail();
                }));
              },
              child: Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                child: BuildWhiteText(txt: "Forgot Password?", fontsize: 0.015),
              ),
            ),


            SizedBox(height: height*0.05,),


            isloginloading ?

            SpinKitRing(color: Colors.white)

                :

            InkWell(
                onTap: (){
                  _submit();
                },

                child: Container(
                    margin: EdgeInsets.only(left: width*0.075,right:width*0.075 ),
                    child: BuildWhiteButton(text: "Login"))),

            SizedBox(height: height*0.025,),


            SizedBox(height: height*0.06,),

            isloading?
            SpinKitRing(color: Colors.white)
                :
            InkWell(
                onTap: () async {

                  setState((){

                    isloading=true;

                  });

                 await googleSignIn(context);

                },

                child: BuildSocialButon(text: "Sign in with Google",image: "google.png")),

            SizedBox(height: height*0.025,),

            fb?


            SpinKitRing(color: Colors.white): InkWell(

                onTap: ()async{
                  setState(() {
                    fb=true;
                  });
                  try{

                    await database.signInWithFacebook(context);
                  }catch(error){
                    setState(() {
                      fb=false;
                    });
                  }


                },
                child: BuildSocialButon(text: "Sign in with Facebook",image: "fb3.webp")),

            SizedBox(height: height*0.025,),

            InkWell(

              onTap: () async {

                await  launchUrl(Uri.parse("https://saintconnect.info/terms-and-privacy-policy",

                ),
                    mode: LaunchMode.externalApplication
                );
              },
              child: Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BuildMuliLightWhite(txt: "By logging in with Saint, you are agreeing to", fontsize: 0.016,
                      ),

                      BuildMuliLightWhite(txt: " our Terms & Privacy Policy", fontsize: 0.016,
                      ),
                    ],
                  )),
            )



          ],
        ),
      ),
    );
  }
}

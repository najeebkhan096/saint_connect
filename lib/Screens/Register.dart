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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saintconnect/auth/auth.dart';


class RegisterScreen extends StatefulWidget {
  static const routename="RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  String ? email;

  String ? password;

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isloading=false;
  bool googlesignisloading=false;
  bool fb=false;

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
            email: newuser.email,).then((value) async {
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
        }
      } else {
        print('Unable to sign in');
      }
    } catch (error) {

    }
  }


  CollectionReference ? imgRef;

  firebase_storage.Reference ? ref;


  AuthService _auth=AuthService();

  Future _showErrorDialog(String msg) async{

    await showDialog(
        context: context,
        builder: (ctx) =>

            AlertDialog(
              backgroundColor: Color(0xff111111),
              title: BuildItalicText(txt: "An Error Occured", fontsize: 0.025),
              content: BuildWhiteMuiliText(txt: msg, fontsize: 0.018),
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    RegExp regex =
    RegExp(r'^(?=.*?[!@#\$&*~])');
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if(email==null || email!.isEmpty


    ){
      _showErrorDialog("Please Enter valid email");
    }

    else if(password==null || password!.isEmpty){
      _showErrorDialog("Please Enter Password");
    }
    else if(password!.length<8 || !regex.hasMatch(password!)) {

      _showErrorDialog("Passwords should be of 8 characters and include at least one symbol.");
    }
    else if (!emailRegex.hasMatch(email!)){
      setState(() {
        isloading=false;
      });
      _showErrorDialog("Invalid Email");
    }

    else{

      setState(() {
        isloading=true;
      });

      try {
        final User user = await _auth.registerWithEmailAndPassword(email!, password!);
        print(user.runtimeType);




        await database.adduser(userid: user.uid,email: email!,imageurl: "",).then((value) async {
          Navigator.pushNamedAndRemoveUntil(context, Wrapper.routename, (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.white,
              content: Text("Account Created",style: TextStyle(color: Colors.white),)));


        });
      } catch (error) {

        if(error.toString().contains("The email address is already in use by another account")){
          try {
            final  User result =await  _auth.signInWithEmailAndPassword(email!, password!);
            Navigator.pushNamedAndRemoveUntil(context, Wrapper.routename, (route) => false);
          } catch (error) {
            setState(() {
              isloading=false;
            });

            if(error.toString().contains("The password is invalid or the user does not have a password.")){
              _showErrorDialog("The password is invalid or this user already exists. Please try again or log in.");
            }
            else{
              _showErrorDialog(error.toString());
            }

          }
        }
        else{
          if(error.toString().contains("The password is invalid or the user does not have a password.")){
            _showErrorDialog("The password is invalid or this user already exists. Please try again or log in.");
          }
          else{
            _showErrorDialog(error.toString());
          }
        }


      }
    }

  }




  Uint8List ? _imageFile;
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  File ? myfile;
  String ? QRImage='';
  bool secure=true;

  Widget Qrimage(){
    return Screenshot(
      controller: screenshotController,
      child: Container(
        height: MediaQuery.of(context).size.height*0.25,
        width: MediaQuery.of(context).size.width*0.5,
        child: QrImageView
          (
          foregroundColor: Color(0xffDAC07A),
          data: "https://saint-connect.webflow.io/profile?${currentuser!.uid!}",
          version: QrVersions.auto,
          size: MediaQuery.of(context).size.height*0.25,
          gapless: false,
        ),
      ),
    );
  }
  // Future GenerateQRCode(String documentid)async{
  //
  //   final Uint8List ? image=await screenshotController.captureFromWidget(Qrimage());
  //
  //   setState(() {
  //     _imageFile = image;
  //   });
  //
  //   if(image!=null){
  //     final tempDir = await getTemporaryDirectory();
  //     final file = await new File('${tempDir.path}/$user_id.jpg').create();
  //     file.writeAsBytesSync(image);
  //     setState(() {
  //       myfile=file;
  //     });
  //
  //     await uploadQR(docid: documentid);
  //   }
  // }



  // Future uploadQR({String ? docid}) async {
  //   try{
  //     ref = firebase_storage.FirebaseStorage.instance
  //         .ref()
  //         .child('QRCode/${Path.basename(myfile!.path)}');
  //     await ref!.putFile(myfile!).whenComplete(() async {
  //       await ref!.getDownloadURL().then((value) async{
  //         QRImage=value;
  //         await  database.updateqrcode(QRImage.toString(), docid.toString()).then((value) {
  //
  //         });
  //       });
  //     });
  //   }
  //   catch(error){
  //
  //   }
  //
  // }


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgcolor,

      body: Container(
        height: height*1,
        width: width*1,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              Container(
                alignment: Alignment.centerLeft,
             margin: EdgeInsets.only(left: width*0.05,right: width*0.075),
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
                  child: BuildItalicText(txt: "Get Started with Saint",fontsize: 0.032,),
              ),

              SizedBox(height: height*0.04),



              Container(
                  alignment: Alignment.centerLeft,
               margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                  child: BuildWhiteMuiliTextBold(txt: "Email Address", fontsize: 0.02),
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
                  padding: EdgeInsets.only(left: width*0.05,right: width*0.025),
                  alignment: Alignment.centerLeft,
                  child:TextFormField(

                    onEditingComplete: (){

                    },
                    textAlignVertical: TextAlignVertical.center,
                    validator: (value){

                    },
                    onSaved: (value){
                      email=value;
                    },
                    onFieldSubmitted: (value){
                      email=value;
                    },
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontFamily: 'Muli-Regular',
                        fontSize: width*(0.038),
                        fontWeight: FontWeight.bold

                    ),
                    decoration: InputDecoration(
                      hintText: "",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: Color(0xff5D5D5D),
                          fontFamily: 'Corporate A Italic',
                          fontSize: 15

                      )
                      ,

                    ),
                  )
              ),

              SizedBox(height: height*0.015,),

              Container(
                alignment: Alignment.centerLeft,
             margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                child: BuildWhiteMuiliTextBold(txt: "Password", fontsize: 0.02),
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
                  padding: EdgeInsets.only(left: width*0.05,right: width*0.025),
                 alignment: Alignment.centerLeft,
                  child:TextFormField(
obscureText: secure,
                    onEditingComplete: (){

                    },
                    textAlignVertical: TextAlignVertical.center,
                    validator: (value){

                    },
                    onSaved: (value){
                      password=value;
                    },
                    onFieldSubmitted: (value){
                      password=value;
                    },
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontFamily: 'Muli-Regular',
                        fontSize: width*(0.038),
                        fontWeight: FontWeight.bold

                    ),
                    decoration: InputDecoration(
                        hintText: "",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Color(0xff5D5D5D),
                            fontFamily: 'Corporate A Italic',
                            fontSize: 15

                        )
,
                      suffixIcon:
                      InkWell(
                          onTap: (){
                            setState(() {
                              secure=!secure;
                            });
                          },
                          child:
                          secure?
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.visibility,color: goldencolor),
                            ],
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


Container(
  margin: EdgeInsets.only(left: width*0.1,right: width*0.1,top: height*0.015),
  child:   BuildWhiteMuiliText(txt: "Passwords should be of 8 characters and include at least one symbol.",
      fontsize: 0.0125),
),
              SizedBox(height: height*0.1),




              isloading?
                  SpinKitRing(color: Colors.white)
                  :
              InkWell(
                  onTap: (){

                    _submit();
                  },

                  child: Container(
                      margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                      child: BuildWhiteButton(text: "Continue"))),



              SizedBox(height: height*0.05,),
              googlesignisloading?
              SpinKitRing(color: Colors.white)
                  :
              InkWell(
                  onTap: ()async{
                    setState(() {
                      googlesignisloading=true;
                    });
                    try{
                      await googleSignIn(context);
                    }catch(error){
                      setState(() {
                        googlesignisloading=false;
                      });
                    }


                  },
                  child: BuildSocialButon(text: "Sign in with Google",image: "google.png")),
              SizedBox(height: height*0.025,),

                 fb?
                 SpinKitRing(color: Colors.white):
                 InkWell(
                     onTap: ()async{
                       setState(() {
                         fb=true;
                       });

                       try{
                       await   database.signInWithFacebook(context);

                       }
                       catch(error){
                         setState(() {
                           fb=false;
                         });

                       _showErrorDialog(error.toString());

                       }

                     },
                     child: BuildSocialButon(text: "Sign in with Facebook ",image: "fb3.webp")),

              SizedBox(height: height*0.025,),

           Container(
          margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
          child: InkWell(
          onTap: ()async{
            await  launchUrl(Uri.parse("https://saintconnect.info/terms-and-privacy-policy",
            ),
                mode: LaunchMode.externalApplication
            );

          },

          child: BuildMuliLightWhite(txt: "By signing up with Saint, you agree to our Terms & Privacy Policy", fontsize: 0.015))),

            ],
          ),
        ),
      ),
    );
  }
}


import 'package:email_auth/email_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saintconnect/Screens/forget_password/otp.dart';
import 'package:saintconnect/auth/auth.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:saintconnect/widgets/wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class EnterEmail extends StatefulWidget {
  static const routename="EnterEmail";

  @override
  State<EnterEmail> createState() => _EnterEmailState();
}

class _EnterEmailState extends State<EnterEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey();

   Future<void> forgotYourPassword(String email) async {
    try {
      final _auth = FirebaseAuth.instance;
      await _auth.sendPasswordResetEmail(email: email).then((value) {

      });
      setState(() {
        isloginloading=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(
              backgroundColor: Colors.white,
              content: BuildBlackMuiliText(txt: "Further instructions have been sent to your email", fontsize: 0.02)));

      // await openEmail().then((value) {
      //
      // });

    } catch (e) {
    print("my error is "+e.toString());
    setState(() {
      isloginloading=false;
    });
if(e.toString().contains("There is no user record corresponding to this identifier")){
  _showErrorDialog("There is no user record corresponding to this identifier. The user may have been deleted.");

}
 else{
  _showErrorDialog(e.toString());
}
    }
  }

  EmailAuth ? emailAuth= new  EmailAuth(sessionName: "Sample session");
  Future sendOtp() async {
    print("here the value is");
    print(email);



    ///a boolean value will be returned if the OTP is sent successfully
    var data = await emailAuth!.sendOtp(recipientMail: email!);
    if (data) {
      ///have your error handling logic here, like a snackbar or popup widget
      print("OTP sent");
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return EnterOtp(desiredemail: email,);
      }));

    } else {
      print("Could not send");
      setState(() {
        isloginloading=false;
      });
_showErrorDialog("Could not send");
    }
  }
  bool secure=false;

  bool isloginloading=false;
  bool fb=false;

  Future _showErrorDialog(String msg) async{
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    await showDialog(
        context: context,
        builder: (ctx) =>

            AlertDialog(
              backgroundColor: Color(0xff111111),
              title: BuildItalicText(txt: "Password Reset", fontsize: 0.025),
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

  AuthService _auth=AuthService();
Future<void> openEmail()async{
  final Uri params = Uri(
    scheme: 'mailto',
    path: '',
  );

  String url = params.toString();

  if (await canLaunch(url)) {
  await launch(url);
  } else {
  throw 'Could not launch $url';
  }

}

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();


    if(email==null || email!.isEmpty){
      _showErrorDialog("Please Enter valid email");
    }

    else{
      setState(() {
        isloginloading=true;
      });

      forgotYourPassword(email!);
      // sendOtp();


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

            SizedBox(height: height*0.025,),

            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
              child: BuildItalicText(txt: "Forget Password",fontsize: 0.032,),
            ),


            SizedBox(height: height*0.05,),


            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: width*0.075,right: width*0.075),
                child: BuildWhiteText(txt: "Enter Email Address", fontsize: 0.025)),

            SizedBox(height: height*0.01,),

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







            SizedBox(height: height*0.05),




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
                    child: BuildWhiteButton(text: "Submit"))),



            SizedBox(height: height*0.06,),





          ],
        ),
      ),
    );
  }
}


import 'package:email_auth/email_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:saintconnect/auth/auth.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:saintconnect/widgets/wrapper.dart';
import 'package:url_launcher/url_launcher.dart';
class EnterOtp extends StatefulWidget {
  final String ? desiredemail;
EnterOtp({this.desiredemail});
  @override
  State<EnterOtp> createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterOtp> {
  var otp_list = [];
  String otp_string='';

  final GlobalKey<FormState> _formKey = GlobalKey();


  Future<void> _submit() async
  {
    if(!_formKey.currentState!.validate())
    {
      return;
    }
    _formKey.currentState!.save();
    print(_fourth_index);
    otp_string=_first_index+_second_index+_third_index+_fourth_index+_fifth_index+_sixth_index;
    print(otp_string);
    verify();
  }
  TextEditingController textEditingController = TextEditingController();


  TextEditingController first_index = TextEditingController();
  String _first_index = '';
  String _second_index = '';
  String _third_index = '';
  String _fourth_index = '';
  String _fifth_index = '';
  String _sixth_index = '';
  final auth = FirebaseAuth.instance;
 String ? email;
  Future<void> Dialogue_message(BuildContext context){
    return showDialog(context: context, builder: (context)
    {
      return AlertDialog(
        title: Text("Check Your Email"),
        content: Text("Confirm New password from your provided gmail"),
        actions: [
          MaterialButton(onPressed: (){
            Navigator.of(context).pushReplacementNamed(Wrapper.routename);
          },child: Text("Okay"),)
        ],
      );

    }
    );
  }

  void resetpassword(){
    final response=auth.sendPasswordResetEmail(email: email.toString());
    Dialogue_message(context);
  }
  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
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
  EmailAuth ? emailAuth;
  ///create a bool method to validate if the OTP is true
  void verify() {
    print(email);
    print(otp_string);
    var respons= (emailAuth!.validateOtp(recipientMail: email!, userOtp: otp_string)); //pass in the OTP typed in
    ///This will return you a bool, and you can proceed further after that, add a fail case and a success case (result will be true/false)
    if(respons){
      Fluttertoast.showToast(
          msg:
          "verified",
          toastLength:
          Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: mycolor,
          textColor: Colors.white,
          fontSize: 16.0);
      print("verified");
      resetpassword();
      // Navigator.of(context).pushReplacementNamed(Enter_new_password.routenam);
    }
    else{
      print("invalid otp");
      _showErrorDialog("invalid otp");
    }
  }
  AuthService _auth=AuthService();

bool isloginloading=false;

  String ? name;



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
                child: BuildWhiteText(txt: "Enter OTP", fontsize: 0.025)),

            SizedBox(height: height*0.01,),

            Form (
              key: _formKey,
              child: PinCodeTextField(appContext: context, length: 6,onChanged: (value){
                print(value);
              },
                onCompleted: (value){

                setState(() {
                  otp_string=value;
                });

              },
                keyboardType: TextInputType.number,
                onAutoFillDisposeAction: AutofillContextAction.cancel,
                controller: textEditingController,
                autoDisposeControllers: true,
                cursorColor: Colors.black,
                pinTheme: PinTheme(
                    activeColor: Colors.black,
                    selectedColor: Colors.black,
                    inactiveFillColor: Colors.black,
                    disabledColor: Colors.black,
                    activeFillColor: Colors.black,
                    inactiveColor: Colors.black

                ),
              ),
            ),





            SizedBox(height: height*0.05),




            SizedBox(height: height*0.05,),


            isloginloading ?

            SpinKitRing(color: Colors.white)

                :

            InkWell(
                onTap: (){

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

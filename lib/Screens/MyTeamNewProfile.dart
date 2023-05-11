import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:flutter/material.dart';
import 'package:saintconnect/Database/database.dart';
import 'package:saintconnect/Screens/CreateAccount.dart';
import 'package:saintconnect/Screens/CreateProfile.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/widgets/buildpacage.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
class MyTeamNewProfile extends StatefulWidget {
  static const routename="MyTeamNewProfile";

  @override
  State<MyTeamNewProfile> createState() => _MyTeamNewProfileState();
}

class _MyTeamNewProfileState extends State<MyTeamNewProfile> {
bool year=true;

  Map<String, dynamic>? paymentIntentData;
double totalamount=0;
  Future<void> makePayment() async {
    try {

      paymentIntentData = await createPaymentIntent(
          amount:totalamount.toString(),
          currency: 'USD',

      ); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');


      await stripe.Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: stripe.SetupPaymentSheetParameters(
              paymentIntentClientSecret:
              paymentIntentData!['client_secret'],
              customerId: 'customer',
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'USA',
              merchantDisplayName: 'Saint Connect'))
          .then((value) {});

      ///now finally display payment sheeet

      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {

    try {
      await stripe.Stripe.instance
          .presentPaymentSheet(
          parameters: stripe.PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],
            confirmPayment: true,
          ))
          .then((newValue) async {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("paid successfully"),
          backgroundColor: Colors.green,
        ));

        paymentIntentData = null;
        Navigator.pop(context,true);
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on stripe.StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

//  Future<Map<String, dynamic>>
  createPaymentIntent({String ? amount, String ? currency}) async {

    Map<String, dynamic> body = {
      'amount': calculateAmount(totalamount),
      'currency': currency,
      'payment_method_types[]': 'card'
    };

    print(body);
    var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':
          'Bearer sk_test_51K1GtiD5z0PA4b4f4tH4F98PGYq0ZsR95vIQzpKUffJ4NNbutHLSJaqrgZ7KiC5wrj2hDCMZc5sItlmXrwaTqNY700vFOcMCoX',
          'Content-Type': 'application/x-www-form-urlencoded'
        });

    print('Create Intent reponse ===> ${response.body.toString()}');
    return jsonDecode(response.body);

  }

  calculateAmount(double amount) {
    final a = amount.toInt() * 100;
    return a.toString();
  }



  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: bgcolor,

      body: Container(
        height: height*1,
        margin: EdgeInsets.only(top: height*0.05),
        decoration: BoxDecoration(
          color: Color(0xff2A2A2A),
            boxShadow: [
              BoxShadow(
                  color: Color(0xffDAC07A),
                  blurRadius: 10
              )
            ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50)
          )
        ),

        child: Stack(

          children: [
            Padding(
              padding: EdgeInsets.only(left: width*0.05,right: width*0.05),

              child: ListView(

                children: [


                  Container(
                    margin: EdgeInsets.only(right: width*0.025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
Text(""),

                        Row(
                          children: [
                            Image.asset("images/logo.png",height: height*0.05,),
                            SizedBox(width: width*0.025,),
                            BuildItalicText(txt: "Connect", fontsize: 0.0358),
                          ],
                        ),


                    InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Image.asset("images/close.png",color: Colors.white,height: height*0.025)),

                      ],
                    ),
                  ),

                  SizedBox(height: height*0.05,),



                  BuildItalicText(txt: "Add a new member", fontsize: 0.0358),
                  SizedBox(height: height*0.01,),
                  BuildWhiteMuiliText(txt: "Add a new profile to your team! You have access to add your new profile to any existing physical card or just stick to the digital life! ", fontsize: 0.02),

                  SizedBox(height: height*0.025,),
                  Container(

                      width: width*0.6,
                      height: height*0.23,
                      decoration: BoxDecoration(

                        border: Border.all(
                            color: mycolor
                        ),
                      ),

                      child: Image.asset("images/Saint-Animation.gif.gif",fit: BoxFit.fill,)
                  ),
                  SizedBox(height: height*0.05,),

                  BuildItalicText(txt: "Access to all of the benefits", fontsize: 0.0358),
                  SizedBox(height: height*0.01,),
                  BuildWhiteMuiliText(txt: "Add a new profile to your team! You have access to add your new profile to any existing physical card or just stick to the digital life! ", fontsize: 0.02),
                  SizedBox(height: height*0.05,),
                  Container(

                      width: width*0.6,
                      height: height*0.23,
                      decoration: BoxDecoration(

                        border: Border.all(
                            color: mycolor
                        ),
                      ),

                      child: Image.asset("images/Saint-Animation.gif.gif",fit: BoxFit.fill,)

                  ),
                  SizedBox(height: height*0.05,),

                  BuildItalicText(txt: "Cancel Anytime", fontsize: 0.0358),
                  SizedBox(height: height*0.01,),
                  BuildWhiteMuiliText(txt: "Worried about the member leaving? No need to worries as with Saint Connect you can cancel any time. No commitment, no contracts. ", fontsize: 0.02),
                  SizedBox(height: height*0.025,),



                  BuildItalicText(txt: "Get Started", fontsize: 0.0358),
                  SizedBox(height: height*0.01,),
                  BuildWhiteMuiliText(txt: "Worried about the member leaving? No need to worries as with Saint Connect you can cancel any time. No commitment, no contracts. ", fontsize: 0.02),
                  SizedBox(height: height*0.05,),
                  Container(

                      width: width*0.6,
                      height: height*0.23,
                      decoration: BoxDecoration(

                        border: Border.all(
                            color: mycolor
                        ),
                      ),
                      child: Image.asset("images/Saint-Animation.gif.gif",fit: BoxFit.fill,)
                  ),
                  SizedBox(height: height*0.3,),


                ],
              ),
            ),
          Positioned(
            bottom: 0,
            width: width*1,
            child: Container(
              padding: EdgeInsets.only(bottom: height*0.05,top: height*0.05),
              color: Color(0xff3D3D3D),
              child: Column(
                children: [

                  BuildPackage(),
                  SizedBox(height: height*0.05,),
                  InkWell(
                    onTap: ()async{
                      if(year){
                        totalamount=100;

                      }
                      else{
                        totalamount=50;
                      }
                     await makePayment();

                    },
                    child: Container(
                      height: height*0.07,
                      width: width*1,
                      margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("images/apple.png",height: height*0.05),
                          SizedBox(width: width*0.01,),
                          Text("Purchase",style: TextStyle(
                              color: Colors.black,
                              fontSize: height*0.025,
                              fontWeight: FontWeight.w400


                          )),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

          ],
        ),
      ),
    );

  }
Widget BuildPackage(){
  final height=MediaQuery.of(context).size.height;
  final width=MediaQuery.of(context).size.width;
    return  year?
    Container(
      margin: EdgeInsets.only(left: width*0.075,right: width*0.075),

      width: width*1,
      height: height*0.057,
      child: Stack(
        children: [

          Positioned(
            right: 0,
            child: InkWell(
              onTap: (){
                setState((){
                  year=false;
                });
              },
              child: Container(
                width: width*0.48,
                height: height*0.057,
                decoration: BoxDecoration(
                    color: Color(0xffE8E8E8),
                    borderRadius: BorderRadius.circular(20)
                ),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Monthly",

                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Muli-Regular',
                          fontSize: height*(0.02),
                          fontWeight: FontWeight.bold

                      ),),
                    Text("\$50 (20% off)",

                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Muli-Regular',
                        fontSize: height*(0.015),

                      ),),
                  ],
                ),
              ),
            ),
          ),


          Container(
            height: height*0.075,
            width: width*0.48,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Yearly",

                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Muli-Regular',
                      fontSize: height*(0.02),
                      fontWeight: FontWeight.bold

                  ),),
                Text("\$100 (20% off)",

                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Muli-Regular',
                    fontSize: height*(0.015),

                  ),),
              ],
            ),
          ),


        ],
      ),
    ):
    Container(
      margin: EdgeInsets.only(left: width*0.025,right: width*0.025),

      width: width*1,
      height: height*0.057,
      child: Stack(
        children: [


          InkWell(
            onTap: (){
              setState(
                      (){
                    year=true;
                  }
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: width*0.05),
              height: height*0.07,
              width: width*0.45,
              decoration: BoxDecoration(
                  color: Color(0xffE8E8E8),
                  borderRadius: BorderRadius.circular(20)
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Years",

                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Muli-Regular',
                      fontSize: height*(0.02),

                    ),),
                  Text("\$100 (20% off)",

                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Muli-Regular',
                      fontSize: height*(0.01),

                    ),),
                ],
              ),
            ),
          ),
          Positioned(
            right: width*0.05,
            child: Container(
              width: width*0.48,
              height: height*0.057,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Monthly",

                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Muli-Regular',
                      fontSize: height*(0.02),

                    ),),
                  Text("\$50 (20% off)",

                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Muli-Regular',
                      fontSize: height*(0.01),

                    ),),
                ],
              ),
            ),
          ),

        ],
      ),
    );
}
}

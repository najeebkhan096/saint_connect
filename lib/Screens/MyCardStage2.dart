import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:saintconnect/Database/database.dart';
import 'package:saintconnect/Screens/CreateProfile.dart';
import 'package:saintconnect/Screens/MyCardStage3.dart';
import 'package:saintconnect/Screens/Team/add_team.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/MyProfile.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/widgets/bottomnavigattionbar.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;


class MyCardStage2 extends StatefulWidget {
  static const routename="MyCardStage2";

  @override
  State<MyCardStage2> createState() => _MyCardStage2State();
}

class _MyCardStage2State extends State<MyCardStage2> {
  Map<String, dynamic>? paymentIntentData;
  bool year=true;
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
              merchantDisplayName: 'Saint Connect'
          )
      )
          .then((value) {});

      ///now finally display payment sheeet

      displayPaymentSheet(context);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(BuildContext context) async {

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

final data=ModalRoute.of(context)!.settings.arguments as List<String?>;

    return Scaffold(


      backgroundColor:bgcolor,

      body: ListView(

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

                Image.asset("images/logo.png",height: height*0.05,fit: BoxFit.fill,),

                SizedBox(width: width*0.025,),

                BuildItalicText(txt: "Connect", fontsize: 0.0358),

              ],
            ),
          ),
          SizedBox(height: height*0.05,),

          Container(

              margin: EdgeInsets.only(left: width*0.1,right: width*0.1) ,

              child: BuildWhiteMuiliTextBold(txt: "Who's profile would you like to connect?", fontsize: 0.0305 ) ) ,

          SizedBox(height: height*0.05,),

         FutureBuilder(

             future: database.fetch_profiles_by_desired_id(id:currentuser!.uid!),

             builder: (context,AsyncSnapshot<List<MyProfile?>>snapshot){

               return snapshot.connectionState == ConnectionState.waiting?

               SpinKitRing( color: Colors.white  ) :

           ( snapshot.hasData && snapshot . data! . length > 0 )?

           Container(

             margin: EdgeInsets.only(left: width*0.05,right: width*0.05),

              height:
              height * 0.22 *

                  (

                      (
                      (snapshot.data!.length/2)
                      +0.5
                      )
                          .toInt()
                  )
                      ,


             child:   GridView.builder(
                 physics: NeverScrollableScrollPhysics(),
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     mainAxisSpacing: height*0.025,
                     crossAxisCount: 2,
                     mainAxisExtent: height*0.1825,
                     crossAxisSpacing: width*0.025
                 ),
                 itemCount: snapshot.data!.length,
                 itemBuilder: (context , index ) {
                   return InkWell(
                     onTap: (){
                       Navigator.of(context).pushNamed(
                           MyCardStage3.routename,
                           arguments: [data[0],data[1],snapshot.data![index]!]
                       );
                     },
                     child: Container(
                       width: width*0.2,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color:Color(0xff2A2A2A),
                       ),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           CircleAvatar(
                             radius: 35,
                             backgroundColor: Color(0xffDAC07A),
                             child:
                             (snapshot.data![index]!.profile_image!=null && snapshot.data![index]!.profile_image!.isNotEmpty)?
                             CircleAvatar(
                               radius: 32.5,
                               backgroundImage: NetworkImage(snapshot.data![index]!.profile_image!),
                             ):

                             CircleAvatar(
                               radius:width*0.2,
                               backgroundColor: Color(0xff111111),
                               child: Image.asset("images/logo.png",width: width*0.1,),
                             )

                           ),

                           SizedBox(height: height*0.02,),

                           BuildWhiteMuiliTextBold(txt: snapshot.data![index]!.your_details!.name!, fontsize: 0.0228)

                         ],
                       ),
                       height: height*0.05,

                     ),
                   );

                 }),
           )
               :Container(
               height: height*0.2,
               child: Center(child: BuildWhiteMuiliText(txt: "No User", fontsize: 0.025)));
         }),
          SizedBox(height: height*0.05,),
          InkWell(
              onTap: ()async{

                List<String>  profiles=await  database.fetch_total_profile_by_userid(id: currentuser!.uid!);

                if(profiles.length>0){

                  if(currentuser!.payment==true){

                    Navigator.of(context).pushNamed(Createprofile.routename,arguments:

                    currentuser!.year!?

                    DateTime.now().add(Duration(
                        days: 365
                    )):  DateTime.now().add(Duration(
                        days: 30
                    ))
                    );

                  }
                  else{
                    showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      enableDrag: true,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(

                        // side: BorderSide(color: mycolor,width: 0.25,style: BorderStyle.none),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                      backgroundColor: addbg,
                      builder: (context) {
                        return StatefulBuilder(builder: (BuildContext context,StateSetter  setModalState){
                          return Container(
                            height: height*0.8,

                            decoration: BoxDecoration(
                                color: Color(0xff1d1b1e),
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

                                Container(
                                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.05),

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
                                      SizedBox(height: height*0.05,),

                                      Center(
                                        child: Container(
                                            // width: width*0.6,
                                            height: height*0.45,
                                            child: Image.asset("images/getstarted.gif",fit: BoxFit.fill,)
                                        ),
                                      ),
                                      SizedBox(height: height*0.05,),
                                      BuildItalicText(txt: "Access to all of the benefits", fontsize: 0.0358),
                                      SizedBox(height: height*0.01,),
                                      BuildWhiteMuiliText(txt: "Add a new profile to your team! You have access to add your new profile to any existing physical card or just stick to the digital life! ", fontsize: 0.02),
                                      SizedBox(height: height*0.05,),
                                      Center(
                                        child: Container(
                                            // width: width*0.6,
                                            height: height*0.45,


                                            child: Image.asset("images/Connect a card.gif",fit: BoxFit.fill,)

                                        ),
                                      ),
                                      SizedBox(height: height*0.05,),
                                      BuildItalicText(txt: "Cancel Anytime", fontsize: 0.0358),
                                      SizedBox(height: height*0.01,),
                                      BuildWhiteMuiliText(txt: "Worried about the member leaving? No need to worries as with Saint Connect you can cancel any time. No commitment, no contracts. ", fontsize: 0.02),
                                      SizedBox(height: height*0.025,),
                                      BuildItalicText(txt: "Get Started", fontsize: 0.0358),
                                      SizedBox(height: height*0.01,),
                                      BuildWhiteMuiliText(txt: "Worried about the member leaving? No need to worries as with Saint Connect you can cancel any time. No commitment, no contracts. ", fontsize: 0.02),

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
                                        year?
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
                                                    setModalState((){
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
                                                              fontWeight: FontWeight.w700

                                                          ),),
                                                        Text("\$4.46",

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
                                                          fontWeight: FontWeight.w700

                                                      ),),
                                                    Text("\$3.12 (20% off)",

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
                                        )
                                            :
                                        Container(
                                          margin: EdgeInsets.only(left: width*0.025,right: width*0.025),

                                          width: width*1,
                                          height: height*0.057,
                                          child: Stack(
                                            children: [


                                              InkWell(
                                                onTap: (){
                                                  setState((){
                                                    year=true;
                                                  });
                                                  setModalState((){
                                                    year=true;
                                                  });
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
                                                      Text("Yearly",

                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: 'Muli-Regular',
                                                            fontSize: height*(0.02),
                                                            fontWeight: FontWeight.w700

                                                        ),),
                                                      Text("\$3.12 (20% off)",

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
                                                            fontWeight: FontWeight.w700

                                                        ),),
                                                      Text("\$4.46",

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

                                            ],
                                          ),
                                        ),

                                        SizedBox(height: height*0.05,),
                                        InkWell(
                                          onTap: ()async{
                                            if(year){
                                              totalamount=3.12;

                                            }
                                            else{
                                              totalamount=4.46;
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

                                                Text("Create Profile",style: TextStyle(
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
                          );
                        });
                      },
                    )

                        .then((value) async{
                      if(value==true ){
                        await database.update_user_payment(
                            status: true,

                            year: year
                        ).then((value) {
                          currentuser!.payment=true;
                          currentuser!.year=year;
                          Navigator.of(context).pushNamed(Createprofile.routename,arguments:
                          year?
                          DateTime.now().add(Duration(
                              days: 365
                          )):  DateTime.now().add(Duration(
                              days: 30
                          ))
                          );
                        });

                      }
                    });

                  }

                }
                else{
                  Navigator.of(context).pushNamed(Createprofile.routename,arguments: null);
                }



              },
              child: BuildButton(text: "Create a New Profile",fontsize: 0.021)),
          SizedBox(height: height*0.05,),
        ],

      ),
      bottomNavigationBar: Home_Bottom_Navigation_BAr(),
    );


  }

  Widget BuildMyCardStage2(BuildContext context){

    final height=MediaQuery.of(context).size.height;

    final width=MediaQuery.of(context).size.width;

    return   Container(
      height: height*0.35,
      width: width*1,
      decoration: BoxDecoration(
          color: Color(0xff2A2A2A),
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
          BuildText(txt: "Upload your Card Design", fontsize: 0.028),
          SizedBox(height: height*0.01,),
          Container(
              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
              child: BuildText(txt: "This will be displayed on the MyCards Section. Upload 1050x600px for best results. Otherwise there might be blurring or cut-outs.  ", fontsize: 0.018))
        ],
      ),
    );

  }
}
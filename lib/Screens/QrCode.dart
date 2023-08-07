import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:saintconnect/Database/database.dart';
import 'package:saintconnect/Database/profile.dart';
import 'package:saintconnect/Screens/CreateProfile.dart';
import 'package:saintconnect/Screens/edit_profile.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/MyProfile.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/module/view.dart';
import 'package:saintconnect/widgets/Qr_Code_Bottom_Navigation_Bar.dart';
import 'package:saintconnect/widgets/bottomnavigattionbar.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/createButton.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_share/flutter_share.dart';

class QrCode extends StatefulWidget {

  static const routename="QrCode";

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  PageController controller  =PageController();
  String ? _show_reactivate({required String ?  desired_profiledocid})
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor:  Color(0xff2A2A2A),
          title: BuildItalicText(txt: "Failed payment", fontsize: 0.025),
          content:
          BuildWhiteMuiliText(txt: "This profile is currently unavailable due to failed payment", fontsize: 0.018),

          actions: <Widget>[

            Container(

              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        enableDrag: true,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(

                          side: BorderSide(color: mycolor,width: 0.25,style: BorderStyle.none),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40),
                          ),
                        ),
                        backgroundColor: addbg,
                        builder: (context) {
                          return StatefulBuilder(builder: (BuildContext context,StateSetter  setModalState){
                            final height=MediaQuery.of(context).size.height;

                            final width=MediaQuery.of(context).size.width;
                            return Container(
                              height: height*0.8,

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
                                          margin: EdgeInsets.only(right: width*0.025,top: height*0.025),
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
                                        Center(
                                          child: Container(

                                              width: width*0.6,
                                              height: height*0.23,
                                              decoration: BoxDecoration(

                                                border: Border.all(
                                                    color: mycolor
                                                ),
                                              ),

                                              child: Image.asset("images/Saint-Animation.gif",fit: BoxFit.fill,)
                                          ),
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

                                            child: Image.asset("images/Saint-Animation.gif",fit: BoxFit.fill,)

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
                                            child: Image.asset("images/Saint-Animation.gif",fit: BoxFit.fill,)
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
                                                                fontWeight: FontWeight.w500

                                                            ),),
                                                          Text("\£3.99",

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
                                                      Text("\£38.30 (20% off)",

                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w700,
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
                                                        Text("\£38.30 (20% off)",

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
                                                              fontWeight: FontWeight.w500

                                                          ),),
                                                        Text("\£3.99",

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
                                                totalamount=38.30;

                                              }
                                              else{
                                                totalamount=3.99;
                                              }
                                              await makePayment(context: context,desired_profiledocid: desired_profiledocid);

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
                      ).then((value) {
                        if(value==true ){
                          setState(() {

                          });
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
  margin: EdgeInsets.only(left: 15),
                      height:  MediaQuery.of(context).size.height*0.057,
                      width: MediaQuery.of(context).size.width*0.3,
                      decoration: BoxDecoration(
                          color: bgcolor,
                          border: Border.all(
                            color: Color(0xffDAC07A),
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text('Reactivate',style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ],
              ),
            ),


          ],
        )
    );
  }
  CarouselSlider ? carouselSlider;
@override
  void initState() {
    // TODO: implement initState
  current_index=2;
  super.initState();
  }
  bool year=true;

  Map<String, dynamic>? paymentIntentData;

  double totalamount=0;

  Future<void> makePayment({required BuildContext context,required String ? desired_profiledocid}) async {
    try {

      paymentIntentData = await createPaymentIntent(
        amount:totalamount.toString(),
        currency: 'gbp',

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

      displayPaymentSheet(context,desired_profiledocid);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(BuildContext context, String ? desired_profiledocid) async {

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
        await database.update_payment(profiledocid: desired_profiledocid,expirydate:  year?
        DateTime.now().add(Duration(
            days: 365
        )):  DateTime.now().add(Duration(
            days: 30
        ))).then((value) {
          // currentuser!.payment=true;
          Navigator.pop(context,true);
        });
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


  Future<void> share(String desireduserid) async {
    await FlutterShare.share(
        title: 'Saint Connect',
        text: '',
        linkUrl: 'https://www.saintconnect.info/profile?uid=${desireduserid}',
        chooserTitle: 'Saint Connect'
    );

  }
  String ? _show_delete ( String docid )
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Color(0xff111111),
          title: BuildItalicText(txt: "Delete Profile", fontsize: 0.025),
          content:
          BuildItalicTextwhite(txt: "Are you sure you want to remove this profile?", fontsize: 0.018),

          actions: <Widget>[

            Container(
              decoration: BoxDecoration(
                  color: Color(0xffDAC07A),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                child: Text('Yes',style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  await profileDatabase.delete_profile(docid: docid).then((value) {
                    setState(() {

                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });

                },
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                child: Text('No',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  Navigator.of(ctx).pop();
                },
              ),

            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.1,),
          ],
        )
    );
  }
  @override

  Widget build(BuildContext context) {

    final height=MediaQuery.of(context).size.height;

    final width=MediaQuery.of(context).size.width;
print("my id is "+currentuser!.uid.toString());
    return Scaffold(

      bottomNavigationBar: Qr_Code_bottom_Navigation_Bar(),

      backgroundColor: bgcolor,

      body: ListView(

        children: [

          SizedBox(height: height*0.025,),

          Container(
            height: height*0.05,

            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Image.asset("images/logo.png",height: height*0.05,fit: BoxFit.fill,),

                SizedBox(width: width*0.025,),

                BuildItalicText(txt: "Connect", fontsize: 0.0358),

              ],
            ),
          ),
          SizedBox(height: height*0.1,),
          FutureBuilder(
              future: database.fetch_profiles_by_desired_id(id: currentuser!.uid!),
              builder: (context,AsyncSnapshot<List<MyProfile?>>snapshot){
                return snapshot.connectionState==ConnectionState.waiting?
                SpinKitRing(color: Colors.white,):
                (snapshot.hasData && snapshot.data!.length>0)?
                Column(
                  children: [
                    Container(
                        height: height*0.52,
                        child: PageView.builder(
                            itemCount: snapshot.data!.length,
                            controller: controller,
                            itemBuilder: (context,index){
                              return BuildQrCode(context,snapshot.data![index]);
                            })
                    ),
                    SizedBox(height: height*0.05,),

                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: snapshot.data!.length,
                        effect: SlideEffect(
                            spacing: 8.0,
                            radius: 4.0,
                            dotWidth: 24.0,
                            dotHeight: 2.0,
                            paintStyle: PaintingStyle.fill,
                            strokeWidth: 1.5,
                            dotColor: Color(0xffA49D9D),
                            activeDotColor: mycolor),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: Duration(milliseconds: 500), curve: Curves.bounceOut),
                      ),
                    ),
                  ],
                )
                    :

                Container(
                  height: height*0.65,
                  child: Column(
                    children: [
                      Center(
                        child: Container(

                            width: width*1,

                            height: height*0.4,

                            padding: EdgeInsets.only(left: width*0.025,right: width*0.025,top: height*0.01,bottom: height*0.01),

                            margin: EdgeInsets.only(left: width*0.1,right: width*0.1,),

                            child: SvgPicture.asset("icons/nocard.svg",color: mycolor,)

                        ),
                      ),

                      Container(
                          margin: EdgeInsets.only(left: width*0.1,right: width*0.1,top: height*0.025),
                          child:
                          Text("You currently do not have any profiles created. Simply press the “plus” symbol below to get get started",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Muli-Regular',
                              fontSize: height*( 0.018),
                            ),
                          )
                      ),

                      SizedBox(height: height*0.035,),

                      InkWell(

                        onTap: ()async{
                          Navigator.of(context).pushNamed(Createprofile.routename,arguments: null);

                        },

                        child: Container(
                          height: height*0.07,
                          width: width*1,
                          margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                          decoration: BoxDecoration(
                              color: Color(0xff2A2A2A),
                              border: Border.all(
                                color: mycolor,
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Icon(Icons.add,color: mycolor,size: height*0.04),
                              SizedBox(width: width*0.025 ,),
                              Text("Create new profile",style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Muli-Regular',
                                  fontSize: height*0.023,
                                  fontWeight: FontWeight.w700
                              ),),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                );

              }),


        ],

      ),

    );


  }

  Widget BuildQrCode(BuildContext context,MyProfile ? myuser){

    final height=MediaQuery.of(context).size.height;

    final width=MediaQuery.of(context).size.width;

    return   Container(
      height: height*0.52,
      width: width*1,
      decoration: BoxDecoration(
          color: Color(0xff2A2A2A),

      ),
      margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
      child: Stack(
        children: [
          myuser!.uid==currentuser!.uid?
          Positioned(

            left: width*0.025,
            top: height*0.025,
            child: InkWell(
              onTap: ()async{

             await  _show_delete(myuser.docid!);

              },
              child: Container(
                  margin: EdgeInsets.only(right: width*0.025),
                  child: Icon(Icons.delete,color: mycolor,)),
            ),
          ):Text(""),

          myuser.uid==currentuser!.uid?
      Positioned(

        right: width*0.025,
        top: height*0.025,
        child: InkWell(
              onTap: (){
                // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                //   return Editprofile(desiredprofile: myuser);
                // })).then((value)  {
                //   setState(() {
                //
                //   });
                // });


if(myuser.ExpirayDate!.isAfter(DateTime.now())){

  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Editprofile(desiredprofile: myuser);
  })).then((value)  async{
    currentuser_MyProfile =
    await database.fetch_first_profile_userid(id: currentuser!.uid!);
    setState(() {

    });
  });
}
else{
  _show_reactivate(desired_profiledocid: myuser.docid);


}

              },
              child: Container(
                  margin: EdgeInsets.only(right: width*0.025),
                  child: Icon(Icons.edit,color: mycolor,)),
            ),
      ):Text(""),

          Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(

                margin: EdgeInsets.only(top: height*0.025),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: mycolor,
                  child:
                  (myuser.profile_image !=null && myuser.profile_image!.isNotEmpty)?
                  CircleAvatar(
                      radius: 28,
                      backgroundColor: bgcolor,
                      backgroundImage: NetworkImage(myuser.profile_image!)

                  ):
                  CircleAvatar(
                      radius: 28,
                    backgroundColor: Color(0xff111111),
                    child: Image.asset("images/logo.png",width: width*0.1,),

                  )
                ),
              ),
              SizedBox(height: height*0.01,),
              BuildWhiteMuiliTextBold(txt: myuser.your_details!.name !, fontsize: 0.0265),
              SizedBox(height: height*0.025,),

              (myuser.qrcode!.image!=null && myuser.qrcode!.image!.isNotEmpty)?

              InkWell(
                onTap: ()async{
                  await  launchUrl(Uri.parse("https://www.saintconnect.info/profile?uid=${myuser.docid}",
                  ),
                      mode: LaunchMode.externalApplication
                  );
                },
                child: Container(
                  height: 164,
                  width: 164,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(myuser.qrcode!.golden_image!),
                    fit: BoxFit.cover
                    )
                  ),
                ),
              )

                  :
              Container(
                height: 164,
                width: 164,
                child: Center(
                  child: Text("No Qr Code",
                    style: TextStyle(
                    color: Colors.white
                  ),
                  ),
                ),
              )
              ,
              SizedBox(height: height*0.025,),

    (myuser.ExpirayDate!.isAfter(DateTime.now()))

                  ?
              InkWell(

                onTap: () async {
                  database.update_profile_platform(profiledoc: myuser.docid,platforms: myuser.platforms!);
                await share(myuser.docid!);

                },
                child: Container(
                  height: height*0.05,
                  width: width*1,
                  margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                  decoration: BoxDecoration(
                    color: Color(0xff111111),
                      border: Border.all(
                        color: mycolor,
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     BuildWhiteMuiliTextBold(txt: "Share Profile", fontsize: 0.0175),
                     SizedBox(width: width*0.025,),
                       Icon(Icons.share,color: Colors.white,size: 14,)
                    ],
                  ),
                ),
              ):
    InkWell(

    onTap: () async {

      showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(

      side: BorderSide(color: mycolor,width: 0.25,style: BorderStyle.none),
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

                              width: width*0.6,
                              height: height*0.35,
                              decoration: BoxDecoration(

                                border: Border.all(
                                    color: mycolor
                                ),
                              ),
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
                              width: width*0.6,
                              height: height*0.35,
                              decoration: BoxDecoration(

                                border: Border.all(
                                    color: mycolor
                                ),
                              ),

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
                        SizedBox(height: height*0.05,),
                        Center(
                          child: Container(

                              width: width*0.6,
                              height: height*0.35,
                              decoration: BoxDecoration(

                                border: Border.all(
                                    color: mycolor
                                ),
                              ),
                              child: Image.asset("images/welcome.gif",fit: BoxFit.fill,)
                          ),
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
                                          Text("\£3.99",

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
                                      Text("\£38.30 (20% off)",

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
                                        Text("\£38.30 (20% off)",

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
                                        Text("\£3.99",

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
                                totalamount=38.30;

                              }
                              else{
                                totalamount=3.99;
                              }
                              await makePayment(desired_profiledocid:myuser.docid ,context:context );

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
      ).then((value) {
      if(value==true ){
      setState(() {

      });
      }
      });


    },
    child: Container(
    height: height*0.05,
    width: width*1,
    margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
    decoration: BoxDecoration(
    color: Color(0xff111111),
    border: Border.all(
    color: mycolor,
    ),
    borderRadius: BorderRadius.circular(10)
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    BuildWhiteMuiliTextBold(txt: "Reactivate Profile", fontsize: 0.0175),

    ],
    ),
    ),
    ),


            ],
          ),
        ],
      ),
    );

  }
}
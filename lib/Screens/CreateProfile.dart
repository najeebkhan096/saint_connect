import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as contacts;
import 'package:flutter_contacts/properties/address.dart';
import 'package:flutter_contacts/properties/phone.dart';
import 'package:saintconnect/Screens/profile_created.dart';
import 'package:saintconnect/widgets/bottomnavigattionbar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
// import 'package:vcard_maintained/vcard_maintained.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class Createprofile extends StatefulWidget {
  static const routename="Createprofile";

  @override
  State<Createprofile> createState() => _CreateprofileState();
}

class _CreateprofileState extends State<Createprofile> {
  List<String> bgcolors = [
    "0xff000000",
    "0xffFFFFFF",
    "0xffF3B2FB",
    "0xff70CEE2",
    "0xff70E292",
    "0xffC4E270",
    "0xff3652D9",
    "0xff9936D9",
    "0xffD98D36",
    "0xffD936A3",
    "0xffDAC07A",
  ];
  List<String> textcolors=[
    "0xff000000",
    "0xffFFFFFF",
    "0xffF3B2FB",
    "0xff70CEE2",
    "0xff70E292",
    "0xffC4E270",
    "0xff3652D9",
    "0xff9936D9",
    "0xffD98D36",
    "0xffD936A3",
    "0xffDAC07A",

  ];


  List<String> buttoncolors=[
    "0xff000000",
    "0xffFFFFFF",
    "0xffF3B2FB",
    "0xff70CEE2",
    "0xff70E292",
    "0xffC4E270",
    "0xff3652D9",
    "0xff9936D9",
    "0xffD98D36",
    "0xffD936A3",
    "0xffDAC07A",

  ];
  List<String> bordercolors=[
    "0xff000000",
    "0xffFFFFFF",
    "0xffF3B2FB",
    "0xff70CEE2",
    "0xff70E292",
    "0xffC4E270",
    "0xff3652D9",
    "0xff9936D9",
    "0xffD98D36",
    "0xffD936A3",
    "0xffDAC07A",

  ];


  // ///Create a new vCard
  // var mycard = VCard();
  List<String> social=[
    'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FFacebook.png?alt=media&token=c977d16c-d397-430a-a6fe-071f6b360a53',
    'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FInstagram.png?alt=media&token=de91ca17-da19-4dd4-809c-f089f1592aae',
    'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FSnapchat.png?alt=media&token=8823afc0-810e-49bd-bd6b-cfd084e21123',
    'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FTwitter.png?alt=media&token=e9715051-869b-4ce6-80e1-6cef50636d90',
    'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FWhatsapp.png?alt=media&token=b62ac0ff-e026-445d-82fe-68b252f44ed5',
    'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FSpotify.png?alt=media&token=147c2bee-31d4-41db-ab03-47ca1ebc3cff',
    'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FLinkedin.png?alt=media&token=2b83f447-51e5-434a-adc4-16c990238c75',
    'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FYoutube.png?alt=media&token=f199925a-e704-4f14-b781-60c8fab1a8c3',
    'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FSafari.png?alt=media&token=df49bbf4-49e5-41dd-ae3d-bc2e388584eb'

  ];

  Uint8List ? _imageFile;
  bool team=false;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  int ? picked_color_hex;
// ValueChanged<Color> callback
  void changeColor(Color color) {



    picked_color_hex=color.value;

    setState(() => pickerColor = color);
  }


  Future _pickcolor({required String ? title})async {

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          title: const Text('Pick a colour!'),
          content: SingleChildScrollView(
            child:  ColorPicker(

              hexInputBar: true,

              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),

          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {

                List data= pickerColor.toString().split("0xff");

                List data2= data[1].split(")");

                var splited="0xff"+data2[0].toString();
                if(title=="bg"){
                  setState(() {
                    bgcolors[0]=splited;
                  });
                }
                else if(title=="text"){
                  setState(() {
                    textcolors[0]=splited;
                  });
                }
                else if(title=="button"){
                  setState(() {
                    buttoncolors[0]=splited;
                  });
                }
                else if(title=="border"){
                  setState(() {
                    bordercolors[0]=splited;
                  });
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  FocusNode name=FocusNode();
  FocusNode email=FocusNode();
  FocusNode contact=FocusNode();
  FocusNode title=FocusNode();
  FocusNode location=FocusNode();
  FocusNode intro=FocusNode();
  FocusNode paragrpah=FocusNode();
  FocusNode bio=FocusNode();
  FocusNode final_button=FocusNode();
  FocusNode final_button_url=FocusNode();
  FocusNode personnelconn_title=FocusNode();
  FocusNode businessconn_title=FocusNode();
  FocusNode businessname=FocusNode();
  FocusNode contractor=FocusNode();
  FocusNode webiste=FocusNode();
  FocusNode businesscompany=FocusNode();
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  CollectionReference ? imgRef;
  firebase_storage.Reference ? ref;
  Future<String?> upload_my_file({File ? myfile}) async {
    String ? got_image;
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('${"profile"}/${Path.basename(myfile!.path)}');
    await ref!.putFile(myfile).whenComplete(() async {
      await ref!.getDownloadURL().then((imageurl) {
        if(imageurl!=null){
          got_image=imageurl;
        }
      });
    });

    return got_image;
  }

  Future<String?> upload_vcf_file({File ? myfile}) async {
    String ? got_image;
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('${"myvcf"}/${Path.basename(myfile!.path)}');
    await ref!.putFile(myfile).whenComplete(() async {
      await ref!.getDownloadURL().then((imageurl) {
        if(imageurl!=null){
          got_image=imageurl;
        }
      });
    });

    return got_image;
  }


  Future show_bottomsheet({required bool personel}){
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return showModalBottomSheet(
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
        return Container(
          height: height*0.6,

          decoration: BoxDecoration(
              color: Color(0xff2A2A2A),
              boxShadow: [
                BoxShadow(
                    color: Color(0xffDAC07A),
                    blurRadius: 20,
                    spreadRadius: 2
                )
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40)
              )
          ),

          child: Padding(
            padding: EdgeInsets.only(left: width*0.05,right: width*0.05),

            child: ListView(

              children: [



                SizedBox(height: height*0.025,),

                Center(
                  child: Container(
                    width: width*1,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("images/logo.png",height: height*0.04,),
                        SizedBox(width: width*0.025,),
                        BuildItalicText(txt: "Connect", fontsize: 0.03),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: height*0.05,),



                BuildItalicText(txt: "Add Social Media", fontsize: 0.0358),
                SizedBox(height: height*0.05,),
                Container(

                  height: MediaQuery.of(context).size.height * 0.35,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return

                        InkWell(
                          onTap: ()async{

                            if(social.length==index+1) {
                              _media_url.text="https://";
                              await _custom_media( choice: 'Custom URL',personel: personel);

                            }
                            else{

                              if(index!=4){
                                _media_url.text="https://";
                              }
                              else{
                                _media_url.clear();
                              }

                              await _enter_media(choice: social[index], personel: personel,social_media_name:
                              index==0?"Facebook":
                              index==1?"Instagram":
                              index==2?"Snapchat":
                              index==3?"Twitter":
                              index==4?"WhatsApp":
                              index==5?"Spotify":
                              index==6?"LinkedIn":
                              index==7?"YouTube":
                              "Custom URL"
                              );

                            }
                          },
                          child:


                          Container(
                            height: height*0.2,
                            decoration: BoxDecoration(
                              // color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(social[index])
                                )
                            ),
                          ),
                        );
                    },
                    itemCount:  social.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1/1,
                      crossAxisSpacing: width*0.025,
                      mainAxisSpacing: 15,

                      //emoji height
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                ),



              ],
            ),
          ),
        );
      },
    );
  }

  MyProfile ? createprofile=MyProfile(
      personal_connection_title: '',
      ExpirayDate: DateTime.now().add(Duration(
          days: 365
      )),
      businesss_connection_title: '',
      final_button: FinalButton(
          url: '',
          title: ''
      ),
      profile_image: '', logo: '', your_details: YourDetails(
      email: '',
      name: '',
      title: '',
      bio: '',

      finalbutton: '',
      location: '',
      contact_no: '',
      intro_heading: '',
      paragraph: ''
  ), personal_connection: [],
      business_connection: [],
      Accreditation: [], business_details: BusinessDetails(
      Business_name: '',
      company_contact_no: '',
      company_sector: '',
      website: ''
  ), design_appearance: Design_Appearance(
      BackgroundTheme:
      CustomColor(

          hexcode:"0xff000000"
      )
      ,
      ButtonColor: CustomColor(

          hexcode:"0xff000000"
      ),
      TextColor:CustomColor(

          hexcode:"0xff000000"
      )
  ), Backgroundimage: '', images: [],
      video: '',
      // year:true
  );
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isloading=false;

  Future<void> _submit() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    calculatepercentage();
    RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');



    if(mydetail!.name!.isEmpty || mydetail!.email!.isEmpty){
      setState(() {
        isloading=false;
      });
      _showErrorDialog("Complete the required fields\n -Your Name\n -Your Email");
    }

    else if (!emailRegex.hasMatch(mydetail!.email!)){
      setState(() {
        isloading=false;
      });
      _showErrorDialog("Invalid Email");
    }

    else if(businessdetail!.website!.isNotEmpty && (!businessdetail!.website!.toUpperCase().startsWith("HTTPS://")

    )){
      setState(() {
        isloading=false;
      });
      _showErrorDialog("Please enter a valid link. For example https://www.saintconnect.info");
    }
    else if( createprofile!.final_button!.url!.isNotEmpty &&  (!createprofile!.final_button!.url!.toUpperCase().startsWith("HTTPS://"))
    ){

      setState(() {
        isloading=false;
      });
      _showErrorDialog("Please enter a valid link. For example https://www.saintconnect.info");
    }
    else{
      setState(() {
        isloading=true;
      });

      if(videocontroller.text.isNotEmpty){
        createprofile!.video=videocontroller.text;
      }
      else{
        createprofile!.video='';
      }
      setState(() {
        createpercentage=0.1;
      });
if(profile_file!=null || logo_file!=null){

if(profile_file!=null){

  await  upload_my_file(myfile: profile_file).then((value) async{

    profile_url=value;


    setState(() {
      createpercentage=0.25;
    });

    if(logo_file!=null){
      setState(() {
        createpercentage=0.25;
      });
      await  upload_my_file(myfile: logo_file).then((logovalue) async {

        company_logo=logovalue;

        setState(() {
          createpercentage=0.4;
        });
      createprofile=
          MyProfile(
            personal_connection_title: createprofile!.personal_connection_title,
            businesss_connection_title: createprofile!.businesss_connection_title,
            final_button: createprofile!.final_button,
            payment: true,
            // year: team?false:true,
            business_connection: business_connections,
            profile_image:    profile_url,
            ExpirayDate: createprofile!.ExpirayDate,
            logo:    company_logo,
            your_details: mydetail,
            personal_connection:
            personal_connections,
            Accreditation: accreditation_images,
            business_details: businessdetail, design_appearance: design_appearance,
            Backgroundimage:    bg_image_url,
            images: images_url,
            video:  createprofile!.video,
            uid: currentuser!.uid,
            vcf_url: ''
            // qrcode: currentuser!.qr_image,
          );


//This will add new profile for desired uid
            await database.add_profile (createprofile!).then((profiledocid) async{
              setState(() {
                createpercentage=0.6;
              });

              await writeCounter(profiledocid!).then((myvcfile)async {
                try {


                  ///save to file

                  await  upload_vcf_file(myfile: myvcfile).then((vcf_image_url) async{

                    createprofile!.vcf_url=vcf_image_url.toString();
                    database.update_profile_vcf(vcfurl: vcf_image_url!, docid: profiledocid  );
                    setState(() {
                      createpercentage=0.5;
                    });
                  });


                } catch (e) {
                  // If encountering an error, return 0

                }
              });


              //second color
              await database.GenerateQRCode( documentid: profiledocid,context: context,
              qrcolor: Color(int.parse(bordercolors[0])),
                backgroundgcolor: Color(int.parse(bgcolors[0])),
              ).then((secondary_file) async {

                //golden qr
                await database.GenerateGoldenQRCode( documentid: profiledocid,context: context,

                ).then((golden_img_file) async{

                  await database.uploadGoldenprofileQR
                    (mycode:
                  MyQrCode(docid: profiledocid,
                    image: '', secondarycolor: bordercolors[0],
                    backgroundcolor: bgcolors[0],
                  ),
                      myfile: golden_img_file

                  ).then((golden_img_url) async{
                    setState(() {
                      createpercentage=0.7;
                    });
                    await database.uploadprofileQR
                      (mycode:
                    MyQrCode(docid: profiledocid,
                      image: '', secondarycolor: bordercolors[0],
                      backgroundcolor: bgcolors[0],
                    ),
                        myfile: secondary_file

                    ).then((secondory_qr_image_url) async{

                      await database.update_profile_qrcode(mycode:
                      MyQrCode(docid: profiledocid,
                        image: secondory_qr_image_url, secondarycolor: bordercolors[0],
                        backgroundcolor: bgcolors[0],
                        golden_image: golden_img_url
                      )
                      )
                          .then((value) {

                      });
                      setState(() {
                        createpercentage=0.75;
                      });
                      await database.update_user_payment(
                        status: false,
                        profile_created: true,
                      ).then((value) {
                        setState(() {
                          createpercentage=0.8;
                        });
                        setState(() {
                          isloading=false;
                          createpercentage=1;
                        });
                        currentuser!.payment=false;

                        Navigator.of(context).pushReplacementNamed(ProfileCreated.routename,
                            arguments: createprofile);


                      });
                    });

                  })  ;
                });


              });


            });





      });
    }
    else{
      setState(() {
        createpercentage=0.4;
      });
      createprofile=
          MyProfile(
              personal_connection_title: createprofile!.personal_connection_title,
              businesss_connection_title: createprofile!.businesss_connection_title,
              final_button: createprofile!.final_button,
              payment: true,
              // year: team?false:true,
              business_connection: business_connections,
              profile_image:    profile_url,
              ExpirayDate: createprofile!.ExpirayDate,
              logo:    company_logo,
              your_details: mydetail,
              personal_connection:
              personal_connections,
              Accreditation: accreditation_images,
              business_details: businessdetail, design_appearance: design_appearance,
              Backgroundimage:    bg_image_url,
              images: images_url,
              video:  createprofile!.video,
              uid: currentuser!.uid,
              vcf_url: ''
            // qrcode: currentuser!.qr_image,
          );


//This will add new profile for desired uid
      await database.add_profile (createprofile!).then((profiledocid) async{
        setState(() {
          createpercentage=0.6;
        });

        await writeCounter(profiledocid!).then((myvcfile)async {
          try {



            ///save to file

            await  upload_vcf_file(myfile: myvcfile).then((vcf_image_url) async{

              createprofile!.vcf_url=vcf_image_url.toString();
              database.update_profile_vcf(vcfurl: vcf_image_url!, docid: profiledocid  );
              setState(() {
                createpercentage=0.5;
              });
            });


          } catch (e) {
            // If encountering an error, return 0
_showErrorDialog(e.toString());
          }
        });


        //second color
        await database.GenerateQRCode( documentid: profiledocid,context: context,
          qrcolor: Color(int.parse(bordercolors[0])),
          backgroundgcolor: Color(int.parse(bgcolors[0])),
        ).then((secondary_file) async {

          //golden qr
          await database.GenerateGoldenQRCode( documentid: profiledocid,context: context,

          ).then((golden_img_file) async{

            await database.uploadGoldenprofileQR
              (mycode:
            MyQrCode(docid: profiledocid,
              image: '', secondarycolor: bordercolors[0],
              backgroundcolor: bgcolors[0],
            ),
                myfile: golden_img_file

            ).then((golden_img_url) async{
              setState(() {
                createpercentage=0.7;
              });
              await database.uploadprofileQR
                (mycode:
              MyQrCode(docid: profiledocid,
                image: '', secondarycolor: bordercolors[0],
                backgroundcolor: bgcolors[0],
              ),
                  myfile: secondary_file

              ).then((secondory_qr_image_url) async{

                await database.update_profile_qrcode(mycode:
                MyQrCode(docid: profiledocid,
                    image: secondory_qr_image_url, secondarycolor: bordercolors[0],
                    backgroundcolor: bgcolors[0],
                    golden_image: golden_img_url
                )
                )
                    .then((value) {

                });
                setState(() {
                  createpercentage=0.75;
                });
                await database.update_user_payment(
                  status: false,
                  profile_created: true,
                ).then((value) {
                  setState(() {
                    createpercentage=0.8;
                  });
                  setState(() {
                    isloading=false;
                    createpercentage=1;
                  });
                  currentuser!.payment=false;

                  Navigator.of(context).pushReplacementNamed(ProfileCreated.routename,
                      arguments: createprofile);


                });
              });

            })  ;
          });


        });


      });


    }

  });
}else{
  if(logo_file!=null){
    setState(() {
      createpercentage=0.25;
    });

    await  upload_my_file(myfile: logo_file).then((logovalue) async{

      company_logo=logovalue;
      setState(() {
        createpercentage=0.4;
      });

      createprofile=
          MyProfile(
            personal_connection_title: createprofile!.personal_connection_title,
            businesss_connection_title: createprofile!.businesss_connection_title,
            final_button: createprofile!.final_button,
            payment: true,
            // year: team?false:true,
            business_connection: business_connections,
            profile_image:    profile_url,
            ExpirayDate: createprofile!.ExpirayDate,
            logo:    company_logo,
            your_details: mydetail,
            personal_connection:
            personal_connections,
            Accreditation: accreditation_images,
            business_details: businessdetail, design_appearance: design_appearance,
            Backgroundimage:    bg_image_url,
            images: images_url,
            video:  createprofile!.video,
            uid: currentuser!.uid,
            // qrcode: currentuser!.qr_image,
          );



            await database.add_profile (createprofile!).then((profiledocid) async{

              await writeCounter(profiledocid!).then((myvcfile)async {

                try {

                  await  upload_vcf_file(myfile: myvcfile).then((vcf_image_url) async{

                    createprofile!.vcf_url=vcf_image_url.toString();
                    database.update_profile_vcf(vcfurl: vcf_image_url!, docid: profiledocid  );
                    setState(() {
                      createpercentage=0.5;
                    });
                  });


                } catch (e) {

                  // If encountering an error, return 0
print("some ting went wrong "+e.toString());
                }
              });

              setState(() {
                createpercentage=0.5;
              });

              //second qr
              await database.GenerateQRCode( documentid: profiledocid,context: context,
              qrcolor: Color(int.parse(bordercolors[0])),
                backgroundgcolor: Color(int.parse(bgcolors[0])),
              ).then((secondary_file) async {


                //golden qr
                await database.GenerateGoldenQRCode( documentid: profiledocid,context: context)
                    .then((golden_file) async {



                  await database.uploadGoldenprofileQR(
                      myfile: golden_file,
                      mycode:     MyQrCode(docid: profiledocid,
                        image: '', secondarycolor: createprofile!.design_appearance!.BorderColor!.hexcode!,
                        backgroundcolor: createprofile!.design_appearance!.BackgroundTheme!.hexcode!,
                      )).then((golden_image_url) async{

                    setState(() {
                      createpercentage=0.6;
                    });

                    await database.uploadprofileQR(
                        myfile: secondary_file,
                        mycode:     MyQrCode(docid: profiledocid,
                          image: '', secondarycolor: createprofile!.design_appearance!.BorderColor!.hexcode!,
                          backgroundcolor: createprofile!.design_appearance!.BackgroundTheme!.hexcode!,
                        )).then((secondory_qr_image_url) async{

                      await database.update_profile_qrcode(mycode:
                      MyQrCode(docid: profiledocid,
                        image: secondory_qr_image_url, secondarycolor: bordercolors[0],
                        backgroundcolor: bgcolors[0],
                        golden_image: golden_image_url
                      )
                      ).then((value) async{

                        await database.update_user_payment(
                          status: false,
                          profile_created: true,
                        ).then((value) {
                          setState(() {
                            createpercentage=0.85;
                          });
                          setState(() {
                            isloading=false;
                            createpercentage=1;
                          });
                          currentuser!.payment=false;
                          Navigator.of(context).pushReplacementNamed(ProfileCreated.routename,
                              arguments: createprofile);


                        });
                        setState(() {
                          createpercentage=0.7;
                        });
                      });

                    });
                  });
                });



              });


            });



    });
  }

}

}

else{
  setState(() {
    createpercentage=0.35;
  });
        createprofile=
          MyProfile(
            personal_connection_title: createprofile!.personal_connection_title,
            businesss_connection_title: createprofile!.businesss_connection_title,
            final_button: createprofile!.final_button,
            payment: true,
            // year: team?false:true,
            business_connection: business_connections,
            profile_image:    profile_url,
            ExpirayDate: createprofile!.ExpirayDate,
            logo:    company_logo,
            your_details: mydetail,
            personal_connection:
            personal_connections,
            Accreditation: accreditation_images,
            business_details: businessdetail, design_appearance: design_appearance,
            Backgroundimage:    bg_image_url,
            images: images_url,
            video:  createprofile!.video,
            uid: currentuser!.uid,
            // qrcode: currentuser!.qr_image,
          );


//This will add new profile for desired uid
            await database.add_profile (createprofile!).then((profiledocid) async{
              await writeCounter(profiledocid!).then((myvcfile)async {
                try {


                  await  upload_vcf_file(myfile: myvcfile).then((vcf_image_url) async{

                    createprofile!.vcf_url=vcf_image_url.toString();
                    database.update_profile_vcf(vcfurl: vcf_image_url!, docid: profiledocid  );
                    setState(() {
                      createpercentage=0.5;
                    });
                  });


                } catch (e) {
                  // If encountering an error, return 0

                }
              });

              setState(() {
                createpercentage=0.5;
              });
              await database.GenerateQRCode( documentid: profiledocid,context: context,
              qrcolor: Color(int.parse(bordercolors[0])),
                backgroundgcolor: Color(int.parse(bgcolors[0])),
              ).then((secondary_file) async {

                //golden qr
                await database.GenerateGoldenQRCode( documentid: profiledocid,context: context,

                ).then((golden_file) async {
                  await database.uploadGoldenprofileQR(
                      myfile: golden_file,
                      mycode:     MyQrCode(docid: profiledocid,
                        image: '', secondarycolor: createprofile!.design_appearance!.BorderColor!.hexcode!,
                        backgroundcolor: createprofile!.design_appearance!.BackgroundTheme!.hexcode!,
                      ),
                  ).then((golden_img) async{
                    setState(() {
                      createpercentage=0.6;
                    });
                    await database.uploadprofileQR(
                        myfile: secondary_file,
                        mycode:     MyQrCode(docid: profiledocid,
                          image: '', secondarycolor: createprofile!.design_appearance!.BorderColor!.hexcode!,
                          backgroundcolor: createprofile!.design_appearance!.BackgroundTheme!.hexcode!,
                        )

                    ).then((secondory_qr_image_url) async{

                      await database.update_profile_qrcode(mycode:
                      MyQrCode(docid: profiledocid,
                        image: secondory_qr_image_url, secondarycolor: bordercolors[0],
                        backgroundcolor: bgcolors[0],
                        golden_image: golden_img
                      )
                      );
                      await database.update_user_payment(
                        status: false,
                        profile_created: true,
                      ).then((value) {
                        setState(() {
                          createpercentage=0.9;
                        });
                        setState(() {
                          isloading=false;
                          createpercentage=1;
                        });
                        currentuser!.payment=false;
                        Navigator.of(context).pushReplacementNamed(ProfileCreated.routename,
                            arguments: createprofile);


                      });

                      setState(() {
                        createpercentage=0.75;
                      });
                    });
                  });
                });



              });



            });


}

    }




  }





  final picker = ImagePicker();
  String ? selectedoption;
  List<SocialMedia> ? business_connections=[];
  List<SocialMedia> ? personal_connections=[];

  String ? profile_url='';
  String ? company_logo='';
  String ? bg_image_url='';
  String ? accreditation='';
  String ? images='';

  TextEditingController _media_url=TextEditingController();
  TextEditingController _profile_handle=TextEditingController();
  TextEditingController _media_title=TextEditingController();










  Future<File?> _edit_media(
      {required SocialMedia editmedia, required bool personel}) async {

    _media_url.text=editmedia.url.toString();

    _profile_handle.text=editmedia.profile_handle.toString();
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    File ? choosedfile;

    await showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
                backgroundColor: Color(0xff111111),
                title: BuildItalicText(txt: editmedia.title, fontsize: 0.025),
                content: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.3,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: height * 0.054,
                            width: width * 1,

                            decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.only(left: width * 0.05),
                            child: TextField(
                              controller: _media_url,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  hintText:    editmedia.media=="WhatsApp"?"Enter your Whatsapp no":
                                  'Enter your ${editmedia.media} URL',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Color(0xff5D5D5D),
                                      fontFamily: 'Corporate A Italic',
                                      fontSize: 15

                                  )
                              ),
                            )
                        ),

                      ),
                      SizedBox(height: height*0.025,),


                      Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: height*0.054,
                            width: width*1,

                            decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.only(left: width*0.05),
                            child:  TextField(
                              controller: _profile_handle,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  hintText: 'Enter profile handle',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Color(0xff5D5D5D),
                                      fontFamily: 'Corporate A Italic',
                                      fontSize: 15

                                  )
                              ),
                            )
                        ),

                      ),

                      SizedBox(height: height * 0.05,),



                      InkWell(
                        onTap: (){

                          if(_profile_handle.text.isNotEmpty){

                            if(personel){

                              if(editmedia.title=="WhatsApp"){

                                for (int i=0;i<personal_connections!.length;i++){
                                  if(personal_connections![i].media==editmedia.media){
                                    personal_connections![i]=SocialMedia(
                                        media: editmedia.media,
                                        url: _media_url.text,
                                        title:editmedia.title,
                                        profile_handle: _profile_handle.text
                                    );

                                    _media_url.clear();
                                    _profile_handle.clear();
                                    _media_title.clear();
                                    Navigator.of(context).pop();
                                  }
                                }

                              }
                              else{

                                if(_media_url.text.isNotEmpty && (_media_url.text.startsWith("HTTPS://") || _media_url.text.startsWith("https://"))){

                                  for (int i=0;i<personal_connections!.length;i++){
                                    if(personal_connections![i].media==editmedia.media){
                                      personal_connections![i]=SocialMedia(
                                          media: editmedia.media,
                                          url: _media_url.text,
                                          title:editmedia.title,
                                          profile_handle: _profile_handle.text
                                      );

                                      _media_url.clear();
                                      _profile_handle.clear();
                                      _media_title.clear();
                                      Navigator.of(context).pop();
                                    }
                                  }

                                }
                                else{
                                  print("kala 4");
                                  _showErrorDialog("Please enter a valid link. For example https://www.saintconnect.info");

                                }
                              }



                            }
                            else{

                              if(editmedia.title=="WhatsApp"){
                                for (int i=0;i<business_connections!.length;i++){
                                  if(business_connections![i].media==editmedia.media){
                                   business_connections![i]=SocialMedia(
                                        media: editmedia.media,
                                        url: _media_url.text,
                                        title:editmedia.title,
                                        profile_handle: _profile_handle.text
                                    );

                                  }
                                }
                                _media_url.clear();
                                _profile_handle.clear();
                                _media_title.clear();

                                Navigator.of(context).pop();

                              }
                              else{
                                if(_media_url.text.isNotEmpty && (_media_url.text.startsWith("HTTPS://") || _media_url.text.startsWith("https://"))){

                                  for (int i=0;i<business_connections!.length;i++){
                                    if(business_connections![i].media==editmedia.media){
                                      business_connections!=SocialMedia(
                                          media: editmedia.media,
                                          url: _media_url.text,
                                          title:editmedia.title,
                                          profile_handle: _profile_handle.text
                                      );
                                    }
                                  }

                                  _media_url.clear();
                                  _profile_handle.clear();
                                  _media_title.clear();
                                  Navigator.of(context).pop();
                                }
                                else{
                                  _showErrorDialog("Please enter a valid link. For example https://www.saintconnect.info");

                                }
                              }




                            }

                          }

                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: height*0.054,
                            width: width*1,
                            decoration: BoxDecoration(
                                color: Color(0xff111111),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.fromBorderSide(BorderSide(color: mycolor))
                            ),
                            child: Center(child: BuildText(txt: "Save", fontsize: 0.025)),
                          ),

                        ),
                      )


                    ],
                  ),
                ))).then((value) {
      _media_url.clear();
      _profile_handle.clear();
      _media_title.clear();
    });
    return choosedfile;
  }

  Future<File?> _edit_custom_media(
      {required SocialMedia editmedia, required bool personel}) async {
    _media_url.text=editmedia.url.toString();

    _profile_handle.text=editmedia.title.toString();
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    File ? choosedfile;

    await showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
                backgroundColor: Color(0xff111111),
                title: BuildItalicText(txt: editmedia.title, fontsize: 0.025),
                content: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.3,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: height * 0.054,
                            width: width * 1,

                            decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.only(left: width * 0.05),
                            child: TextField(
                              controller: _media_url,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  hintText:    editmedia.media=="WhatsApp"?"Enter your Whatsapp no":
                                  'Enter your ${editmedia.media} URL',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Color(0xff5D5D5D),
                                      fontFamily: 'Corporate A Italic',
                                      fontSize: 15

                                  )
                              ),
                            )
                        ),

                      ),
                      SizedBox(height: height*0.025,),


                      Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: height*0.054,
                            width: width*1,

                            decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.only(left: width*0.05),
                            child:  TextField(
                              controller: _profile_handle,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  hintText: 'Enter title ',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Color(0xff5D5D5D),
                                      fontFamily: 'Corporate A Italic',
                                      fontSize: 15

                                  )
                              ),
                            )
                        ),

                      ),

                      SizedBox(height: height * 0.05,),



                      InkWell(
                        onTap: (){
                          if(_profile_handle.text.isNotEmpty){




                            if(personel){

                              if(editmedia.media=="WhatsApp"){
                                for (int i=0;i<personal_connections!.length;i++){
                                  if(personal_connections![i].media==editmedia.media){
                                    personal_connections![i]=SocialMedia(
                                        media: editmedia.media,
                                        url: _media_url.text,
                                        title:_profile_handle.text,
                                        profile_handle: ""
                                    );

                                    _media_url.clear();
                                    _profile_handle.clear();
                                    _media_title.clear();
                                    Navigator.of(context).pop();
                                  }
                                }
                              }
                              else{
                                if(_media_url.text.isNotEmpty && (_media_url.text.startsWith("HTTPS://") || _media_url.text.startsWith("https://"))){

                                  for (int i=0;i<personal_connections!.length;i++){
                                    if(personal_connections![i].media==editmedia.media){
                                      personal_connections![i]=SocialMedia(
                                          media: editmedia.media,
                                          url: _media_url.text,
                                          title:_profile_handle.text,
                                          profile_handle: ""
                                      );

                                      _media_url.clear();
                                      _profile_handle.clear();
                                      _media_title.clear();
                                      Navigator.of(context).pop();
                                    }
                                  }
                                }
                                else{
                                  _showErrorDialog("Please enter a valid link. For example https://www.saintconnect.info");

                                }

                              }


                            }
                            else{

                              if(editmedia.media=="WhatsApp"){
                                for (int i=0;i<business_connections!.length;i++){
                                  if(business_connections![i].media==editmedia.media){
                                    business_connections![i]=SocialMedia(
                                        media: editmedia.media,
                                        url: _media_url.text,
                                        title:_profile_handle.text,
                                        profile_handle: ""
                                    );


                                  }
                                }
                                _media_url.clear();
                                _profile_handle.clear();
                                _media_title.clear();
                                Navigator.of(context).pop();
                              }
                              else{
                                if(_media_url.text.isNotEmpty && (_media_url.text.startsWith("HTTPS://") || _media_url.text.startsWith("https://"))){

                                  for (int i=0;i<business_connections!.length;i++){
                                    if(business_connections![i].media==editmedia.media){
                                      business_connections![i]=SocialMedia(
                                          media: editmedia.media,
                                          url: _media_url.text,
                                          title:_profile_handle.text,
                                          profile_handle: ""
                                      );

                                    }
                                  }

                                  _media_url.clear();
                                  _profile_handle.clear();
                                  _media_title.clear();
                                  Navigator.of(context).pop();


                                }
                                else{
                                  _showErrorDialog("Please enter a valid link. For example https://www.saintconnect.info");

                                }
                              }





                            }

                          }

                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: height*0.054,
                            width: width*1,
                            decoration: BoxDecoration(
                                color: Color(0xff111111),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.fromBorderSide(BorderSide(color: mycolor))
                            ),
                            child: Center(child: BuildText(txt: "Save", fontsize: 0.025)),
                          ),

                        ),
                      )


                    ],
                  ),
                ))).then((value) {
      _media_url.clear();
      _profile_handle.clear();
      _media_title.clear();
    });
    return choosedfile;
  }












  Future<File?> _enter_media({required String social_media_name, required String ? choice,required bool personel}) async{
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    File ? choosedfile;
    await  showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            backgroundColor: Color(0xff111111),
            title: BuildItalicText(txt:social_media_name, fontsize: 0.025),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.27,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        height: height*0.054,
                        width: width*1,

                        decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.only(left: width*0.05),
                        child:  TextField(
                          controller: _media_url,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              hintText:    social_media_name=="WhatsApp"?"Enter your Whatsapp no":
                              'Enter your ${social_media_name} URL'
                              ,
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Color(0xff5D5D5D),
                                  fontFamily: 'Corporate A Italic',
                                  fontSize: 15

                              )
                          ),
                        )
                    ),

                  ),

                  SizedBox(height: height*0.025,),


                  Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        height: height*0.054,
                        width: width*1,

                        decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.only(left: width*0.05),
                        child:  TextField(
                          controller: _profile_handle,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              hintText: 'Enter profile handle',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Color(0xff5D5D5D),
                                  fontFamily: 'Corporate A Italic',
                                  fontSize: 15

                              )
                          ),
                        )
                    ),

                  ),

                  SizedBox(height: height*0.05,),
                  InkWell(
                    onTap: (){
                   if(_profile_handle.text.isNotEmpty){


                     if(personel){
                       if(_media_url.text.isNotEmpty){

                         if( social_media_name=="WhatsApp"){

                           personal_connections!.add(SocialMedia(
                               media: choice,
                               url: _media_url.text,
                               title:social_media_name,
                               profile_handle: _profile_handle.text
                           ));
                           _media_url.clear();
                           _profile_handle.clear();
                           _media_title.clear();
                           Navigator.of(context).pop();

                         }
                         else{
                           if(  (_media_url.text.startsWith("HTTPS://") || _media_url.text.startsWith("https://"))){

                             personal_connections!.add(SocialMedia(
                                 media: choice,
                                 url: _media_url.text,
                                 title:social_media_name,
                                 profile_handle: _profile_handle.text
                             ));
                             _media_url.clear();
                             _profile_handle.clear();
                             _media_title.clear();
                             Navigator.of(context).pop();


                           }
                           else{
                             _showErrorDialog("Please enter a valid link. For example https://www.saintconnect.info");

                           }
                         }


                       }



                     }
                     else{

                       if(_media_url.text.isNotEmpty){
                         if( social_media_name=="WhatsApp"){

                           business_connections!.add(SocialMedia(
                               media: choice,
                               url: _media_url.text,
                               title: social_media_name,
                               profile_handle: _profile_handle.text
                           ));
                           _media_url.clear();
                           _media_title.clear();
                           _profile_handle.clear();

                           Navigator.of(context).pop();
                         }
                         else{
                           if( (_media_url.text.startsWith("HTTPS://") || _media_url.text.startsWith("https://"))) {


                             business_connections!.add(SocialMedia(
                                 media: choice,
                                 url: _media_url.text,
                                 title: social_media_name,
                                 profile_handle: _profile_handle.text
                             ));
                             _media_url.clear();
                             _media_title.clear();
                             _profile_handle.clear();

                             Navigator.of(context).pop();
                           }
                           else{
                             _showErrorDialog("Please enter a valid link. For example https://www.saintconnect.info");

                           }
                         }

                       }





                     }

                   }

                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: height*0.054,
                        width: width*1,
                        decoration: BoxDecoration(
                            color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.fromBorderSide(BorderSide(color: mycolor))
                        ),
                        child: Center(child: BuildText(txt: "Save", fontsize: 0.025)),
                      ),

                    ),
                  )


                ],
              ),
            )));
    return choosedfile;
  }
  Future<File?> _custom_media({required String ? choice,required bool personel}) async{
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    File ? choosedfile;
    String  ? choosedfile_url='';

    bool saving=false;

    await  showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(builder: (context,mysetState){

          return AlertDialog(
              backgroundColor: Color(0xff111111),
              title: BuildItalicText(txt:"Custom URL", fontsize: 0.025),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.43,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.054,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05),
                          child:  TextField(
                            controller: _media_url,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                hintText: "Custom URL"
                                ,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )
                            ),
                          )
                      ),

                    ),
                    SizedBox(height: height*0.025,),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height * 0.054,
                          width: width * 1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width * 0.05),
                          child: TextField(
                            controller: _media_title,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                hintText: "Enter title"
                                ,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )
                            ),
                          )
                      ),

                    ),
                    SizedBox(height: height * 0.025,),

                    Container(

                      child: Column(

                        children: [
                          BuildItalicText(txt:"Pick an Image", fontsize: 0.025),
                          SizedBox(height: height*0.025,),


                          InkWell(
                            onTap: ()async{
                              await  _show_my_Dialog('social_url').then((value) async{
                                if(value!=null){

                                  double filelength=0;
                                  filelength=(value.lengthSync()/1000000);
                                  if(filelength<4){
                                    mysetState(() {
                                      choosedfile=value;
                                      saving=true;
                                    });
                                    await  upload_my_file(myfile: choosedfile).then((value) {
                                      choosedfile_url=value;

                                      mysetState((){
                                        saving=false;
                                      });
                                    });

                                  }
                                  else{
                                    _showErrorDialog('File should be of less than 4 MB size');
                                  }
                                }
                              });
                            },
                            child:
                            choosedfile==null?
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: addbg,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: mycolor
                                ),
                              ),
                              child: Icon(Icons.add,color: mycolor,size: 35),
                            ):
                            Center(
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(image: FileImage(choosedfile!),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.05,),
                    saving==true? BuildItalicText(txt:"Please wait a moment", fontsize: 0.025):
                    InkWell(
                      onTap: (){
                        if(_media_url.text.isNotEmpty){

                          if(personel){
                            personal_connections!.forEach((element) {
                              if(element.media==choice){

                                int desiredindex= personal_connections!.indexWhere((element) => element.media==choice);
                                personal_connections![desiredindex]=SocialMedia(
                                    media:
                                    choosedfile_url!.isEmpty?"https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FSafari.png?alt=media&token=df49bbf4-49e5-41dd-ae3d-bc2e388584eb":
                                    choosedfile_url,
                                    url: _media_url.text.isEmpty?"Custom URL": _media_url.text,
                                  title: "Custom",
                                  profile_handle: _profile_handle.text
                                );
                              }
                            }
                            );

                            personal_connections!.add(SocialMedia(
                                media:
                                choosedfile_url!.isEmpty?"https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FSafari.png?alt=media&token=df49bbf4-49e5-41dd-ae3d-bc2e388584eb":
                                choosedfile_url,
                                url: _media_url.text.isEmpty?"Custom URL": _media_url.text,
                                title:  "Custom",
                                profile_handle: _profile_handle.text
                            ));
                            _media_url.clear();
                            _media_title.clear();
                            _profile_handle.clear();
                            Navigator.of(context).pop();
                          }

                          else{
                            business_connections!.forEach((element) {
                              if(element.media==choice){

                                int desiredindex= business_connections!.indexWhere((element) => element.media==choice);
                                business_connections![desiredindex]=SocialMedia(
                                    media:
                                    choosedfile_url!.isEmpty?"https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FSafari.png?alt=media&token=df49bbf4-49e5-41dd-ae3d-bc2e388584eb":
                                    choosedfile_url,
                                    url: _media_url.text.isEmpty?"Custom URL": _media_url.text,
                                  title:  "Custom",
                                  profile_handle: _profile_handle.text
                                );
                              }
                            });

                            business_connections!.add(SocialMedia(
                                media:
                                choosedfile_url!.isEmpty?"https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FSafari.png?alt=media&token=df49bbf4-49e5-41dd-ae3d-bc2e388584eb":
                                choosedfile_url,
                                url: _media_url.text.isEmpty?"Custom URL": _media_url.text,
                                title: "Custom",
                                profile_handle: _profile_handle.text
                            ));
                            _media_url.clear();
                            _media_title.clear();
                            _profile_handle.clear();
                            Navigator.of(context).pop();
                          }

                        }


                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: height*0.054,
                          width: width*1,
                          decoration: BoxDecoration(
                              color: Color(0xff111111),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.fromBorderSide(BorderSide(color: mycolor))
                          ),
                          child: Center(child: BuildText(txt: "Save", fontsize: 0.025)),
                        ),

                      ),
                    )


                  ],
                ),
              ));
        }));
    return choosedfile;
  }

  Future<String?>  _showvideoDialog() async{
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    await showDialog(
        context: context,
        builder: (ctx) =>

            AlertDialog(
                backgroundColor: Color(0xff111111),
                title: BuildItalicText(txt: "Enter Video URL", fontsize: 0.025),
                content: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: height*0.054,
                            width: width*1,

                            decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.only(left: width*0.05),
                            child:  TextField(
                              controller: videocontroller,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  hintText: "Enter URL",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Color(0xff5D5D5D),
                                      fontFamily: 'Corporate A Italic',
                                      fontSize: 15

                                  )
                              ),
                            )
                        ),

                      ),
                      SizedBox(height: height*0.05,),
                      InkWell(
                        onTap: (){
                          if((videocontroller.text.startsWith("HTTPS://") || videocontroller.text.startsWith("https://"))){

                          Navigator.of(context).pop();
                          }
                          else {
                          videocontroller.clear();
                            _showErrorDialog("Please enter a valid link. For example https://www.saintconnect.info");
                          }

                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: height*0.054,
                            width: width*1,
                            decoration: BoxDecoration(
                                color: Color(0xff111111),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.fromBorderSide(BorderSide(color: mycolor))
                            ),
                            child: Center(child: BuildText(txt: "Save", fontsize: 0.025)),
                          ),

                        ),
                      )


                    ],
                  ),
                ))

    );
  }
  Future<File?> _show_my_Dialog(String ? choice) async{
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
                      await  getfilename(1,choice).then((value) async {
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
                      await getfilename(2,choice).then((value) {
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


  File ? profile_file;

  File ? logo_file;

  List<File>  accreditation_file=[];
  List<String> ? accreditation_images=[];
  List<File> ? images_file=[];
  List<String>  images_url=[];



  File ? bg_file;
  TextEditingController videocontroller=TextEditingController();
  String ? thumbnail;



  void calculatepercentage(){
    percentage=14.284;
    if(profile_file!=null){
      print("rimsha gashti 1");
      setState((){

        percentage=percentage+3.571428571428571;
      });

    }

    if(logo_file!=null){
      print("rimsha gashti 2");
      setState((){
        percentage=percentage+3.571428571428571;
      });
    }

    if(mydetail!.name!.isNotEmpty
    ){
      print("rimsha gashti 3");
      setState((){
        percentage=percentage+3.571428571428571;
      });
    }
    if(
    mydetail!.email!.isNotEmpty
    ){
      setState((){
        print("rimsha gashti 5");
        percentage=percentage+3.571428571428571;
      });
    }

    if(
    mydetail!.bio!.isNotEmpty
    ){
      print("rimsha gashti 4");
      setState((){
        percentage=percentage+3.571428571428571;
      });
    }
    if(
    mydetail!.contact_no!.isNotEmpty
    ){
      print("rimsha gashti 6");
      setState((){
        percentage=percentage+3.571428571428571;
      });
    }
    if(
    mydetail!.title!.isNotEmpty
    ){
      print("rimsha gashti 7");
      setState((){
        percentage=percentage+3.571428571428571;
      });
    }
    if(
    mydetail!.location!.isNotEmpty
    ){
      print("rimsha gashti 8");
      setState((){
        percentage=percentage+3.571428571428571;
      });
    }
    if(
    mydetail!.intro_heading!.isNotEmpty
    ){
      setState((){
        print("rimsha gashti 9");
        percentage=percentage+3.571428571428571;
      });
    }
    if(
    mydetail!.paragraph!.isNotEmpty
    ){
      print("rimsha gashti 10");
      setState((){
        percentage=percentage+3.571428571428571;
      });
    }
    if(
    createprofile!.personal_connection_title!.isNotEmpty
    ){
      setState((){
        print("rimsha gashti 11");
        percentage=percentage+3.571428571428571;
      });
    }

    if(personal_connections!.length>0){
      print("rimsha gashti 17");
      setState((){
        percentage=percentage+3.571428571428571;
      });
    }
    if(accreditation_file.length>0){
      print("rimsha gashti 19");
      setState((){
        percentage=percentage+3.571428571428571;
      });
    }
    if(

    businessdetail!.Business_name!.isNotEmpty){
      print("rimsha gashti 12");
      setState((){
        percentage=percentage+3.571428571428571;
      });

    }
    if(

    businessdetail!.company_sector!.isNotEmpty){
      print("rimsha gashti 13");
      setState((){
        percentage=percentage+3.571428571428571;
      });

    }
    if(

    businessdetail!.website!.isNotEmpty){
      print("rimsha gashti 14");
      setState((){
        percentage=percentage+3.571428571428571;
      });

    }
    if(

    businessdetail!.company_contact_no!.isNotEmpty){
      print("rimsha gashti 15");
      setState((){
        percentage=percentage+3.571428571428571;
      });

    }

    if(
    createprofile!.businesss_connection_title!.isNotEmpty
    ){
      print("rimsha gashti 16");
      setState((){
        percentage=percentage+3.571428571428571;
      });
    }

    if(business_connections!.length>0){
      print("rimsha gashti 18");
      setState((){
        percentage=percentage+3.571428571428571;
      });
    }
    if(bg_file!=null){
      print("rimsha gashti 21");
      setState((){
        percentage=percentage+3.571428571428571;
      });
      if(images_file!.length>0){
        print("rimsha gashti 20");
        setState((){
          percentage=percentage+3.571428571428571;
        });
      }



    }
    if(videocontroller.text.isNotEmpty){
      print("rimsha gashti 22");
      setState((){

        percentage=percentage+3.571428571428571;
      });
    }


    if(

    createprofile!.final_button!.title!.isNotEmpty){
      print("rimsha gashti 12");
      setState((){
        percentage=percentage+3.571428571428571;
      });

    }
    if(

    createprofile!.final_button!.url!.isNotEmpty){
      print("rimsha gashti 12");
      setState((){
        percentage=percentage+3.571428571428571;
      });

    }
  }
  Future<bool?> _show_personel_deleteion()
  async{
    bool ? status;
    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Color(0xff111111),
          title: BuildItalicText(txt: "Alert", fontsize: 0.028),
          content:
          BuildItalicTextwhite(txt: "Are you sure you want to delete it?", fontsize: 0.018),

          actions: <Widget>[

            Container(
              decoration: BoxDecoration(
                  color: Color(0xff9A0303),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                child: Text('Yes',style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  Navigator.pop(context,true);
                },
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff20C997),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                child: Text('No',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  Navigator.pop(context,false);
                },
              ),

            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.1,),
          ],
        )
    ).then((value) {
      if(value!=null){
        status=value;
      }
    });
    return status;
  }
  double createpercentage=0;
  Future<File?> getfilename(int choice,String ?operation) async {
    File ? selected_file;
    if (choice == 1) {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.camera);
      await    image!.length().then((value) {

      });

      setState(() {
        if(operation=="profile"){
          profile_file = File(image.path);
          selected_file=File(image.path);
        }
        else if(operation=="logo"){
          logo_file = File(image.path);
          selected_file=File(image.path);
        }
        else if(operation=="accreditation"){
          double filelength=(File(image.path).lengthSync()/1000000);
          if(filelength<4){
            accreditation_file.add(File(image.path));
          }


          selected_file=File(image.path);
        }
        else  if(operation=="images"){
          double filelength=(File(image.path).lengthSync()/1000000);
          if(filelength<4){

            images_file!.add( File(image.path));
          }



          selected_file=File(image.path);

        }

        else  if(operation=="bgimage"){
          bg_file= File(image.path);
          selected_file=File(image.path);
        }

        else if (operation=="social_url"){
          selected_file=File(image.path);
        }

      });


    } else {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        if(operation=="profile"){
          profile_file = File(image!.path);
          selected_file=File(image.path);
        }
        else if(operation=="logo"){
          logo_file = File(image!.path);
          selected_file=File(image.path);
        }
        else if(operation=="accreditation"){

          double filelength=(File(image!.path).lengthSync()/1000000);
          if(filelength<4){
            accreditation_file.add(File(image.path));
          }
          selected_file=File(image.path);

        }
        else  if(operation=="images"){

          double filelength=(File(image!.path).lengthSync()/1000000);
          if(filelength<4){
            images_file!.add( File(image.path));
          }
          selected_file=File(image.path);
        }

        else  if(operation=="bgimage"){
          bg_file= File(image!.path);
          selected_file=File(image.path);
        }
        else if (operation=="social_url"){
          selected_file=File(image!.path);
        }
      });
    }
    return selected_file;
  }




  YourDetails  ? mydetail=YourDetails(
      email: '',
      name: '',
      title: '',
      finalbutton: '',
      location: '',
      contact_no: '',
      intro_heading: '',
      paragraph: '',
      bio: ''
  );
  BusinessDetails ? businessdetail=BusinessDetails(
      Business_name: '',
      company_contact_no: '',
      company_sector: '',
      website: ''
  );

  Design_Appearance ? design_appearance=Design_Appearance(
      BackgroundTheme: CustomColor(

          hexcode:"0xff000000"
      ),
      ButtonColor: CustomColor(

          hexcode:"0xff000000"
      ),
      TextColor:CustomColor(

          hexcode:"0xff000000"
      ),
      BorderColor: CustomColor(

          hexcode:"0xff000000"
      )
  );

  double percentage=0;


 @override
  void initState() {
    // TODO: implement initState

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;

    if(ModalRoute.of(context)!.settings.arguments!=null){
      final data=ModalRoute.of(context)!.settings.arguments as DateTime;
      if(data!=null){
        team=true;
        createprofile!.ExpirayDate=data;
      }



    }


    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },

      child: Scaffold(

        backgroundColor: bgcolor,
        body: Form(
          key: _formKey,
          child: ListView(

            children: [

              SizedBox(height: height*0.02,),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: width*0.1),
                child:       Image.asset("images/logo.png",height: height*0.05,),),
              Container(
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                child:   Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    SizedBox(height: height*0.025,),
                    BuildItalicText(txt: "Create Your Profile!", fontsize: 0.0358),
                    SizedBox(height: height*0.02,),
                    LinearProgressIndicator(
                      value:percentage/100,
                      backgroundColor: Colors.white,
                      color: mycolor,
                      minHeight: height*0.023,
                    ),
                    SizedBox(height: height*0.02,),
                    BuildItalicText(txt: '${(percentage.roundToDouble()).toStringAsFixed(1)}% Complete', fontsize: 0.0358),
                    SizedBox(height: height*0.075,),

                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Complete Your Profile",fontsize: 0.028)),

                    SizedBox(height: height*0.05,),

                    Row(
                      children: [
                        InkWell(
                          onTap: ()async{
                            double filelength=0;
                            await _show_my_Dialog("profile").then((value) async{
                              if(profile_file!=null){


                                filelength=(profile_file!.lengthSync()/1000000);
                                if(filelength<4){

                                }
                                else{
                                  profile_file=null;
                                  _showErrorDialog('File should be of less than 4 MB size');
                                }

                              }
                            });

                          },
                          child: Container(
                            height: height*0.14,
                            width: width*0.23,
                            child: Stack(
                              children: [
                                profile_file==null?

                                CircleAvatar(
                                  radius:width*0.2,
                                  backgroundColor: Color(0xff111111),
                                  child: Image.asset("images/logo.png",width: width*0.1,),
                                )
                                    :
                                CircleAvatar(
                                  radius:width*0.2,
                                  backgroundImage: FileImage(profile_file!),
                                ),

                                Positioned(
                                  bottom: 0,
                                  right: 0,

                                  child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: mycolor,
                                    child: CircleAvatar(
                                        radius:15,
                                        backgroundColor: Colors.black,
                                        child: Icon(Icons.edit,color: mycolor,size: 14,)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding:  EdgeInsets.only(left: width*0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BuildWhiteMuiliTextBold(txt: "Your Profile Picture", fontsize: 0.022),
                                BuildWhiteMuiliText(txt: "Upload a picture of yourself.", fontsize: 0.0185)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: height*0.025,),

                    Row(
                      children: [
                        InkWell(
                          onTap: ()async{
                            double filelength=0;
                            await _show_my_Dialog("logo").then((value) async{
                              if(logo_file!=null){

                                filelength=(logo_file!.lengthSync()/1000000);
                                if(filelength<4){

                                  calculatepercentage();
                                  setState(() {

                                  });
                                }
                                else{
                                  logo_file=null;
                                  _showErrorDialog('File should be of less than 4 MB size');
                                }

                              }
                            });
                          },
                          child: Container(
                            height: height*0.14,
                            width: width*0.23,
                            child: Stack(
                              children: [
                                logo_file==null?

                                CircleAvatar(
                                  radius:width*0.2,
                                  backgroundColor: Color(0xff111111),
                                  child: Image.asset("images/comp logo.png",width: width*0.2,),
                                )
                                    :
                                CircleAvatar(
                                  radius:width*0.2,
                                  backgroundImage: FileImage(logo_file!),
                                ),

                                Positioned(
                                  bottom: 0,
                                  right: 0,

                                  child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: mycolor,
                                    child: CircleAvatar(
                                        radius:15,
                                        backgroundColor: Colors.black,
                                        child: Icon(Icons.edit,color: mycolor,size: 14,)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding:  EdgeInsets.only(left: width*0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BuildWhiteMuiliTextBold(txt: "Company Logo", fontsize: 0.022),
                                BuildWhiteMuiliText(txt: "Upload your Company Logo.", fontsize: 0.018)
                              ],
                            ),
                          ),
                        )


                      ],
                    ),
                    SizedBox(height: height*0.065,),

                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Your Details", fontsize: 0.028)),

                    SizedBox(height: height*0.015,),
                    Container(

                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Name", fontsize: 0.022)),
                    SizedBox(height: height*0.015,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.054,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05,bottom: height*0.0),
                          child:TextFormField(
                            focusNode: name,
                            onEditingComplete: (){
                              calculatepercentage();
                              FocusScope.of(context).requestFocus(bio);
                            },
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value){

                            },
                            onSaved: (value){
                              mydetail!.name=value;
                            },
                            onFieldSubmitted: (value){
                              mydetail!.name=value;
                            },
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),
                            decoration: InputDecoration(
                                hintText: "Your Name",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),



                    //Bio
                    SizedBox(height: height*0.015,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Bio", fontsize: 0.022)),
                    SizedBox(height: height*0.015,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.16,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05,bottom: height*0.015,right: width*0.025),
                          child:TextFormField(
                            onEditingComplete: (){

                              calculatepercentage();
                              FocusScope.of(context).requestFocus(email);
                            },
                            keyboardType: TextInputType.text,
                            focusNode: bio,
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 5,
                            validator: (value){

                            },
                            onSaved: (value){
                              mydetail!.bio=value;
                            },
                            onFieldSubmitted: (value){
                              mydetail!.bio=value;
                            },

                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),

                            decoration: InputDecoration(

                                hintText: "Write your Bio Here",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),
                    SizedBox(height: height*0.015,),

                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Email", fontsize: 0.022)),
                    SizedBox(height: height*0.015,),

                    Container(

                      alignment: Alignment.centerLeft,

                      child: Container(

                          height: height*0.054,

                          width: width*1,

                          decoration: BoxDecoration(

                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)

                          ),

                          padding: EdgeInsets.only(left: width*0.05),

                          child:TextFormField(

                            maxLines: 1,

                            onEditingComplete: (){

                              calculatepercentage();

                              FocusScope.of(context).requestFocus(contact);

                            },

                            focusNode: email,

                            textAlignVertical: TextAlignVertical.center,

                            onSaved: (value){
                              mydetail!.email=value;
                            },
                            onFieldSubmitted: (value){
                              mydetail!.email=value;
                            },
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),
                            decoration: InputDecoration(
                                hintText: "Hello@SaintConnect.info",

                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),
                    SizedBox(height: height*0.015,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Contact Number", fontsize: 0.022)),
                    SizedBox(height: height*0.015,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.054,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05,),
                          child:TextFormField(
                            onEditingComplete: (){
                              calculatepercentage();
                              FocusScope.of(context).requestFocus(title);
                            },
                            focusNode: contact,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            validator: (value){

                            },
                            onSaved: (value){
                              mydetail!.contact_no=value;
                            },
                            onFieldSubmitted: (value){
                              mydetail!.contact_no=value;
                            },
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),
                            decoration: InputDecoration(
                                hintText: "020 8187 4998",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),

                    SizedBox(height: height*0.015,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Title/Company Position", fontsize: 0.022)),
                    SizedBox(height: height*0.015,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.054,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05),
                          child:TextFormField(
                            onEditingComplete: (){
                              calculatepercentage();
                              FocusScope.of(context).requestFocus(location);
                            },
                            focusNode: title,
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value){

                            },
                            onSaved: (value){
                              mydetail!.title=value;
                            },
                            onFieldSubmitted: (value){
                              mydetail!.title=value;
                            },
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),
                            decoration: InputDecoration(
                                hintText: "Director",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),

                    SizedBox(height: height*0.015,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Location", fontsize: 0.022)),
                    SizedBox(height: height*0.015,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.054,
                          width: width*1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05),
                          child:TextFormField(
                            onEditingComplete: (){
                              calculatepercentage();
                              FocusScope.of(context).requestFocus(intro);
                            },
                            focusNode: location,
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value){

                            },
                            onSaved: (value){
                              mydetail!.location=value;
                            },
                            onFieldSubmitted: (value){
                              mydetail!.location=value;
                            },
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),
                            decoration: InputDecoration(
                                hintText: "United Kingdom",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Color(0xff5D5D5D),
                                  fontFamily: 'Corporate A Italic',
                                  fontSize: 15,
                                )

                            ),
                          )
                      ),

                    ),

                    SizedBox(height: height*0.015,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Introductionary Heading", fontsize: 0.022)),
                    SizedBox(height: height*0.015,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.054,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05),
                          child:TextFormField(
                            onEditingComplete: (){
                              calculatepercentage();
                              FocusScope.of(context).requestFocus(paragrpah);
                            },
                            focusNode: intro,
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value){

                            },
                            onSaved: (value){
                              mydetail!.intro_heading=value;
                            },
                            onFieldSubmitted: (value){
                              mydetail!.intro_heading=value;
                            },
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),

                            decoration: InputDecoration(
                                hintText: "Welcome to my profile!",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),

                    SizedBox(height: height*0.015,),

                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Introductionary Paragraph", fontsize: 0.022)),

                    SizedBox(height: height*0.015,),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.2,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),

                          padding: EdgeInsets.only(left: width*0.05),
                          child:TextFormField(
                            onEditingComplete: (){
                              calculatepercentage();
                              FocusScope.of(context).requestFocus(personnelconn_title);
                            },
                            focusNode: paragrpah,
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 5,
                            validator: (value){

                            },
                            onSaved: (value){
                              mydetail!.paragraph=value;
                            },
                            onFieldSubmitted: (value){
                              mydetail!.paragraph=value;
                            },
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),
                            decoration: InputDecoration(
                                hintText: "Introduce yourself...",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),






                    //personel conn title
                    SizedBox(height: height*0.015,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Personal Connections Title", fontsize: 0.022)),
                    SizedBox(height: height*0.015,),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.054,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05),
                          child:TextFormField(
                            onEditingComplete: (){
                              calculatepercentage();
                              FocusScope.of(context).unfocus();
                            },
                            focusNode: personnelconn_title,
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value){

                            },
                            onSaved: (value){
                              createprofile!.personal_connection_title=value;
                            },
                            onFieldSubmitted: (value){
                              createprofile!.personal_connection_title=value;
                            },
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),

                            decoration: InputDecoration(
                                hintText: "Say Hello 👋",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),




                    SizedBox(height: height*0.025,),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: BuildWhiteMuiliTextBold(txt: "Personal Connections",fontsize: 0.028),
                    ),

                    SizedBox(height: height*0.02,),

                    Container(
                      width: width*1,
                      height:
                      personal_connections!.length<4?
                      MediaQuery.of(context).size.height * 0.15:
                      ( personal_connections!.length<8 && personal_connections!.length>3)?
                      MediaQuery.of(context).size.height  *(0.22):
                      MediaQuery.of(context).size.height  * (0.32),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return

                            index==personal_connections!.length?

                            InkWell(
                              onTap: ()async{
                                await     show_bottomsheet(personel: true).then((value) {
                                  setState(() {

                                  });
                                });
                                // await  _show_personal_socialmedia_options().then((value) {
                                //   setState((){
                                //
                                //   });
                                // });
                              },
                              child: Container(
                                height: height*0.2,
                                decoration: BoxDecoration(
                                  color: addbg,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: mycolor
                                  ),
                                ),
                                child: Icon(Icons.add,color: mycolor,size: 35),
                              ),
                            ):
                           Stack(
                             children: [
                               InkWell(
                                 onTap: (){

                                   if(personal_connections![index].title!="facebook"
                                       &&
                                       personal_connections![index].title!="Instagram"
                                       &&
                                       personal_connections![index].title!="Snapchat"
                                       && personal_connections![index].title!="Twitter"
                                       && personal_connections![index].title!="WhatsApp"
                                       && personal_connections![index].title!="LinkedIn"
                                       && personal_connections![index].title!="YouTube"

                                   ){
                                     _edit_custom_media(
                                         personel: true,
                                         editmedia: personal_connections![index]
                                     );

                                   }
                                   else{

                                     _edit_media(
                                         personel: true,
                                         editmedia:personal_connections![index]
                                     );

                                   }

                                 },
                               onLongPress: ()async{
                            await   _show_personel_deleteion().then((value) {
                              if(value==true){
                                setState(() {
                                  personal_connections!.removeAt(index);
                                });
                              }
                            });
                          },
                          child: Container(

                          decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(personal_connections![index].media!)
                          )
                          ),
                          ),
                          ),
                               Positioned(
                                 right: width*0.015,
                                 top: height*0.01,
                                 child: InkWell(
                                   onTap: (){
                                     setState(() {
                                       personal_connections!.removeAt(index);
                                     });
                                   },
                                   child: CircleAvatar(
                                       radius: height*0.015,
                                       backgroundColor: Color(0xffDAC07A),
                                       child:Icon(Icons.delete,
                                         color: Colors.black,size: height*0.01652,)
                                   ),
                                 ),
                               )
                             ],
                           );
                        },
                        itemCount:  personal_connections!.length+1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1/1,
                            crossAxisSpacing: width*0.025,
                            mainAxisSpacing: height*0.01
                          //emoji height
                        ),
                        padding: EdgeInsets.all(5),
                      ),

                    ),

                    SizedBox(height: height*0.025,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Accreditations & Badges",fontsize: 0.028,start: true,)),
                    SizedBox(height: height*0.025,),
                    Container(

                      width: width*1,
                      height:
                      accreditation_images!.length<3?
                      MediaQuery.of(context).size.height  *   0.15:
                      ( accreditation_images!.length<6 && accreditation_images!.length>3)?
                      MediaQuery.of(context).size.height  * (2*0.15):
                      MediaQuery.of(context).size.height  *  (3*0.15),

                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return

                            index==accreditation_file.length? InkWell(
                              onTap: ()async{

                                await  _show_my_Dialog("accreditation").then((value) async{
                                  if(value!=null){

                                    double filelength=(value.lengthSync()/1000000);
                                    if(filelength<4){
                                      await  upload_my_file(myfile: value).then((selectedfile) {
                                        accreditation_images!.add(selectedfile!);
                                        calculatepercentage();
                                      });

                                    }
                                    else{

                                      _showErrorDialog('File should be of less than 4 MB size');
                                    }


                                  }
                                });
                              },
                              child: Container(

                                height: height*0.2,
                                decoration: BoxDecoration(
                                  color: addbg,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: mycolor
                                  ),
                                ),
                                child: Icon(Icons.add,color: mycolor,size: 35),
                              ),
                            ):
                            Container(
                              height: height*0.2,
                              child: Stack(
                                children: [

                                  Container(
                                    height: height*0.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: mycolor
                                        ),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(accreditation_file[index])
                                        )
                                    ),
                                  ),

                                  Positioned(
                                    right: width*0.015,
                                    top: height*0.01,
                                    child: InkWell(
                                      onTap: ()async{
                                        await   _show_personel_deleteion().then((value) {
                                          if(value==true){
                                            setState(() {
                                              accreditation_file.removeAt(index);
                                            });
                                          }
                                        });
                                      },
                                      child: CircleAvatar(
                                          radius: height*0.015,
                                          backgroundColor: Color(0xffDAC07A),
                                          child:Icon(Icons.delete,
                                            color: Colors.black,size: height*0.01652,)
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            );
                        },
                        itemCount:  accreditation_file.length+1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1/1,
                          crossAxisSpacing: width*0.025,
                          // mainAxisExtent: height*0.081,
                          //emoji height
                        ),
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                    SizedBox(height: height*0.03,),





                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Business Details", fontsize: 0.028)),
                    SizedBox(height: height*0.015,),
                    Container(

                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Buisness Name", fontsize: 0.02)),
                    SizedBox(height: height*0.015,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.054,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05),
                          child:TextFormField(
                            focusNode: businessname,
                            onEditingComplete: (){
                              calculatepercentage();
                              FocusScope.of(context).requestFocus(contractor);
                            },
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value){

                            },
                            onSaved: (value){
                              businessdetail!.Business_name=value;
                            },
                            onFieldSubmitted: (value){
                              businessdetail!.Business_name=value;
                            },
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),
                            decoration: InputDecoration(
                                hintText: "Saint Connect",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),
                    SizedBox(height: height*0.015,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Industry/Sector", fontsize: 0.02)),
                    SizedBox(height: height*0.015,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.054,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05),
                          child:TextFormField(
                            focusNode: contractor,
                            onEditingComplete: (){
                              calculatepercentage();
                              FocusScope.of(context).requestFocus(webiste);
                            },
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value){

                            },
                            textInputAction: TextInputAction.done,
                            onSaved: (value){
                              businessdetail!.company_sector=value;
                            },
                            onFieldSubmitted: (value){
                              businessdetail!.company_sector=value;
                            },
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),
                            decoration: InputDecoration(
                                hintText: "Electrical Contractor",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),

                    SizedBox(height: height*0.015,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Company Website", fontsize: 0.02)),
                    SizedBox(height: height*0.015,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.054,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05),
                          child:TextFormField(
                            focusNode: webiste,
                            onEditingComplete: (){
                              calculatepercentage();
                              FocusScope.of(context).requestFocus(businesscompany);
                            },
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value){

                            },
                            onSaved: (value){
                              businessdetail!.website=value;
                            },
                            onFieldSubmitted: (value){
                              businessdetail!.website=value;
                            },
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),
                            decoration: InputDecoration(
                                hintText: "https://www.saintconnect.info",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),

                    SizedBox(height: height*0.015,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Company Number", fontsize: 0.02)),
                    SizedBox(height: height*0.015,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.054,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05),
                          child:TextFormField(
                            focusNode: businesscompany,
                            onEditingComplete: (){
                              calculatepercentage();
                              FocusScope.of(context).requestFocus(businessconn_title);

                            },
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value){

                            },
                            onSaved: (value){
                              businessdetail!.company_contact_no=value;
                            },
                            onFieldSubmitted: (value){
                              businessdetail!.company_contact_no=value;
                            },
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "020 8187 4998",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15
                                )

                            ),
                          )
                      ),

                    ),


                    SizedBox(height: height*0.015,),

//businesss conn title

                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Business Connections Title", fontsize: 0.022)),
                    SizedBox(height: height*0.015,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.054,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05),
                          child:TextFormField(
                            onEditingComplete: (){
                              calculatepercentage();
                              FocusScopeNode currentFocus = FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            focusNode: businessconn_title,
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value){

                            },
                            onSaved: (value){
                              createprofile!.businesss_connection_title=value;
                            },
                            onFieldSubmitted: (value){
                              createprofile!.businesss_connection_title=value;
                            },
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),

                            decoration: InputDecoration(
                                hintText: "Get in touch with Saint",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),
                    SizedBox(height: height*0.015,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Business Connections",fontsize: 0.028)),

                    SizedBox(height: height*0.02,),

                    Container(
                      width: width*1,
                      height:
                      business_connections!.length<4?
                      MediaQuery.of(context).size.height * 0.15:
                      ( business_connections!.length<8 && business_connections!.length>3)?
                      MediaQuery.of(context).size.height  *(0.22):
                      MediaQuery.of(context).size.height  * (0.32),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return

                            index==business_connections!.length? InkWell(
                              onTap: ()async{
                                await     show_bottomsheet(personel: false);
                                // await  _show_socialmedia_options().then((value) {
                                //   setState((){
                                //     print(business_connections);
                                //   });
                                // });
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: addbg,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: mycolor
                                  ),
                                ),
                                child: Icon(Icons.add,color: mycolor,size: 35),
                              ),
                            ):
                            Stack(
                              children: [
                                InkWell(
                                  onTap: (){
                                    if(business_connections![index].title!="facebook"
                                        &&
                                 business_connections![index].title!="Instagram"
                                        &&
                                 business_connections![index].title!="Snapchat"
                                        && business_connections![index].title!="Twitter"
                                        && business_connections![index].title!="WhatsApp"
                                        && business_connections![index].title!="LinkedIn"
                                        && business_connections![index].title!="YouTube"

                                    ){
                                      _edit_custom_media(
                                          personel: false,
                                          editmedia: business_connections![index]
                                      );

                                    }
                                    else{
                                      _edit_media(
                                          personel: false,
                                          editmedia: business_connections![index]
                                      );
                                    }
                                  },
                                  onLongPress: ()async{
                                    await   _show_personel_deleteion().then((value) {
                                      if(value==true){
                                        setState(() {
                                          business_connections!.removeAt(index);
                                        });
                                      }
                                    });
                                  },
                                  child: Container(

                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(

                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(business_connections![index].media!)
                                        )
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: width*0.015,
                                  top: height*0.01,
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        business_connections!.removeAt(index);
                                      });
                                    },
                                    child: CircleAvatar(
                                        radius: height*0.015,
                                        backgroundColor: Color(0xffDAC07A),
                                        child:Icon(Icons.delete,
                                          color: Colors.black,size: height*0.01652,)
                                    ),
                                  ),
                                )
                              ],
                            );
                        },
                        itemCount:  business_connections!.length+1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1/1,
                          mainAxisSpacing: height*0.01,
                          crossAxisSpacing: width*0.025,
                          // crossAxisSpacing: 10,
                          // mainAxisSpacing: 15,
                          // mainAxisExtent: 65,
                          //emoji height
                        ),
                        padding: EdgeInsets.all(5),
                      ),
                    ),




                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Design & Appearance",fontsize: 0.025)),

                    SizedBox(height: height*0.025,),

                    Container(

                        alignment: Alignment.centerLeft,

                        child: BuildWhiteMuiliTextBold(txt: "Background Colour",fontsize: 0.022)

                    ),

                    SizedBox(height: height*0.02,),
                    Row(

                      children:   List.generate(bgcolors.length, (index) =>

                      index==bgcolors.length-1?

                      InkWell(
                        onTap: () async {

                          await _pickcolor(title: 'bg').then((value) {

                          });

                        },
                        child: Container(
                          margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                          child: CircleAvatar(
                            radius: height*0.0125,
                            backgroundColor: goldencolor,
                            child: CircleAvatar(
                              radius: height*0.012,
                              backgroundColor: bgcolor,
                              child: Icon(Icons.add,color: Color(int.parse(bgcolors[index])),size: height*0.0185),
                            ),
                          ),
                        ),
                      )
                          :
                      bgcolors[index]== design_appearance!.BackgroundTheme?Text(""):
                      InkWell(
                        onTap: (){
                          setState((){
                            design_appearance!.BackgroundTheme=
                                CustomColor(hexcode: bgcolors[index].toString());
                          });
                          String desiredcolor= bgcolors[index];
                          bgcolors.removeAt(index);
                          bgcolors.insert(0, desiredcolor);

                        },
                        child:
                        bgcolors[index]=="0xff000000"?
                        Container(
                          margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                          child: CircleAvatar(
                            radius: height*0.0125,
                            backgroundColor: goldencolor,
                            child: CircleAvatar(
                              radius:  height*0.011,
                              backgroundColor: Color(int.parse(bgcolors[index])),
                            ),
                          ),
                        ):
                        Container(
                          margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                          child: CircleAvatar(
                            radius: height*0.0125,
                            backgroundColor: goldencolor,
                            child: CircleAvatar(
                              radius:  height*0.011,
                              backgroundColor:Color(int.parse(bgcolors[index])),
                            ),
                          ),
                        ),
                      )

                      ),
                    ),


                    SizedBox(height: height * 0.025,),

                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(
                            txt: "Button Colour", fontsize: 0.022)),
                    SizedBox(height: height*0.025,),
                    Row(

                      children:   List.generate(buttoncolors.length, (index) =>

                      index==buttoncolors.length-1?

                      InkWell(
                        onTap: () async {

                          await _pickcolor(title: 'button').then((value) {

                          });

                        },
                        child: Container(
                          margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                          child: CircleAvatar(
                            radius: height*0.0125,
                            backgroundColor: Color(int.parse(buttoncolors[index])),
                            child: CircleAvatar(
                              radius: height*0.011,
                              backgroundColor: bgcolor,
                              child: Icon(Icons.add,color: Color(int.parse(buttoncolors[index])),size: height*0.0185),
                            ),
                          ),
                        ),
                      )
                          :
                      buttoncolors[index]==design_appearance!.ButtonColor?Text(""):
                      InkWell(
                        onTap: (){
                          setState((){
                            design_appearance!.ButtonColor=
                                CustomColor(hexcode: buttoncolors[index].toString());
                          });
                          String desiredcolor= buttoncolors[index];
                          buttoncolors.removeAt(index);
                          buttoncolors.insert(0, desiredcolor);

                        },
                        child:
                        buttoncolors[index]=="0xff000000"?
                        Container(
                          margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                          child: CircleAvatar(
                            radius: height*0.0125,
                            backgroundColor: goldencolor,
                            child: CircleAvatar(
                              radius:  height*0.011,
                              backgroundColor: Color(int.parse(buttoncolors[index])),
                            ),
                          ),
                        ):
                        Container(
                          margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                          child: CircleAvatar(
                            radius: height*0.0125,
                            backgroundColor: goldencolor,
                            child: CircleAvatar(
                              radius:  height*0.011,
                              backgroundColor:Color(int.parse(buttoncolors[index])),
                            ),
                          ),
                        ),
                      )

                      ),
                    ),




                    SizedBox(height: height * 0.025,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(
                            txt: "Primary Colour", fontsize: 0.022)),
                    SizedBox(height: height*0.025,),
                    Row(

                      children:   List.generate(textcolors.length, (index) =>

                      index==textcolors.length-1?

                      InkWell(
                        onTap: () async {

                          await _pickcolor(title: 'text').then((value) {

                          });

                        },
                        child: Container(
                          margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                          child: CircleAvatar(
                            radius: height*0.0125,
                            backgroundColor: Color(int.parse(textcolors[index])),
                            child: CircleAvatar(
                              radius: height*0.012,
                              backgroundColor: bgcolor,
                              child: Icon(Icons.add,color: Color(int.parse(textcolors[index])),size: height*0.0185),
                            ),
                          ),
                        ),
                      )
                          :
                      textcolors[index]==design_appearance!.TextColor?Text(""):
                      InkWell(
                        onTap: (){
                          setState((){
                            design_appearance!.TextColor=
                                CustomColor(hexcode: textcolors[index].toString());
                          });
                          String desiredcolor= textcolors[index];
                          textcolors.removeAt(index);
                          textcolors.insert(0, desiredcolor);

                        },
                        child:
                        textcolors[index]=="0xff000000"?
                        Container(
                          margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                          child: CircleAvatar(
                            radius: height*0.0125,
                            backgroundColor: goldencolor,
                            child: CircleAvatar(
                              radius:  height*0.011,
                              backgroundColor: Color(int.parse(textcolors[index])),
                            ),
                          ),
                        ):
                        Container(
                          margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                          child: CircleAvatar(
                            radius: height*0.0125,
                            backgroundColor: goldencolor,
                            child: CircleAvatar(
                              radius:  height*0.011,
                              backgroundColor:Color(int.parse(textcolors[index])),
                            ),
                          ),
                        ),
                      )

                      ),
                    ),


                    SizedBox(height: height * 0.025,),

                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(
                            txt: "Secondary Colour", fontsize: 0.022)),
                    SizedBox(height: height*0.025,),
                    Row(

                      children:   List.generate(bordercolors.length, (index) =>

                      index==bordercolors.length-1?

                      InkWell(
                        onTap: () async {

                          await _pickcolor(title: 'border').then((value) {

                          });

                        },
                        child: Container(
                          margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                          child: CircleAvatar(
                            radius: height*0.0125,
                            backgroundColor: Color(int.parse(bordercolors[index])),
                            child: CircleAvatar(
                              radius: height*0.012,
                              backgroundColor: bgcolor,
                              child: Icon(Icons.add,color: Color(int.parse(bordercolors[index])),size: height*0.0185),
                            ),
                          ),
                        ),
                      )
                          :
                      bordercolors[index]==design_appearance!.BorderColor?Text(""):
                      InkWell(
                        onTap: (){
                          setState((){
                            design_appearance!.BorderColor=
                                CustomColor(hexcode: bordercolors[index].toString());
                          });
                          String desiredcolor= bordercolors[index];
                          bordercolors.removeAt(index);
                          bordercolors.insert(0, desiredcolor);

                        },
                        child:
                        bordercolors[index]=="0xff000000"?
                        Container(
                          margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                          child: CircleAvatar(
                            radius: height*0.0125,
                            backgroundColor: goldencolor,
                            child: CircleAvatar(
                              radius:  height*0.011,
                              backgroundColor: Color(int.parse(bordercolors[index])),
                            ),
                          ),
                        ):
                        Container(
                          margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                          child:  CircleAvatar(
                            radius: height*0.0125,
                            backgroundColor: goldencolor,
                            child: CircleAvatar(
                              radius:  height*0.011,
                              backgroundColor:Color(int.parse(bordercolors[index])),
                            ),
                          ),
                        ),
                      )

                      ),
                    ),










                    SizedBox(height: height*0.05,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: BuildWhiteMuiliTextBold(txt: "Background Image",fontsize: 0.022),),

                    SizedBox(height: height*0.015,),
                    Row(
                      children: [
                        bg_file==null?
                        InkWell(
                          onTap: ()async{

                            await _show_my_Dialog("bgimage").then((value) async{
                              if(bg_file!=null){


                                double filelength=(bg_file!.lengthSync()/1000000);
                                if(filelength<4){
                                  await  upload_my_file(myfile: bg_file).then((value) {
                                    bg_image_url=value;
                                    calculatepercentage();
                                  });
                                }
                                else{
                                  bg_file=null;
                                  _showErrorDialog('File should be of less than 4 MB size');
                                }
                              }


                            });
                          },
                          child: Container(
                            width: width*0.49,
                            height: height*0.22,
                            decoration: BoxDecoration(
                              color: addbg,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: mycolor
                              ),
                            ),
                            child: Icon(Icons.add,color: mycolor,size: 65),
                          ),
                        )
                            :
                        Container(
                          width: width*0.49,
                          height: height*0.22,
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: ()async{
                                  double filelength=0;
                                  await _show_my_Dialog("bgimage").then((value) async{
                                    if(bg_file!=null){

                                      filelength=(bg_file!.lengthSync()/1000000);
                                      print("chennai "+filelength.toString());
                                      if(filelength<4){
                                        await  upload_my_file(myfile: bg_file).then((value) {
                                          bg_image_url=value;
                                          calculatepercentage();
                                        });
                                      }
                                      else{
                                        bg_file=null;
                                        _showErrorDialog('File should be of less than 4 MB size');
                                      }
                                    }


                                  });
                                },
                                child: Container(
                                  width: width*0.49,
                                  height: height*0.22,
                                  decoration: BoxDecoration(
                                      color: addbg,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: mycolor
                                      ),
                                      image: DecorationImage(
                                          fit: BoxFit.values[2],
                                          image: FileImage(bg_file!)
                                      )
                                  ),

                                ),
                              ),
                              Positioned(
                                right: width*0.015,
                                top: height*0.01,
                                child: InkWell(
                                  onTap: (){

                                    setState(() {
                                      bg_file=null;
                                    });
                                  },
                                  child: CircleAvatar(
                                      radius: height*0.02,
                                      backgroundColor: Color(0xffDAC07A),
                                      child:Icon(Icons.delete,
                                        color: Colors.black,size: height*0.01852,)
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height*0.02,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Images",fontsize: 0.022)),

                    SizedBox(height: height*0.015,),

                    Container(
                      height: height*0.23,
                      child: ListView(
                          scrollDirection: Axis.horizontal,

                          children: List.generate(images_file!.length+1, (index) =>

                          (images_file!.length==index && images_file!.length!=10)
                              ?
                          InkWell(
                            onTap: ()async{
                              await _show_my_Dialog("images").then((value) async{
                                if(value!=null){
                                  double filelength=0;
                                  filelength=(value.lengthSync()/1000000);
                                  if(filelength<4){
                                    await  upload_my_file(myfile: value).then((selectedfile) {
                                      images_url.add(selectedfile!);
                                      calculatepercentage();
                                    });

                                  }
                                  else{

                                    _showErrorDialog('File should be of less than 4 MB size');
                                  }





                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: width*0.025),
                              width: width*0.49,
                              height: height*0.22,
                              decoration: BoxDecoration(
                                color: addbg,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: mycolor
                                ),
                              ),
                              child: Icon(Icons.add,color: mycolor,size: 65),
                            ),
                          ):
                          (images_file!.length==index && images_file!.length==10)?
                          Text(""):
                          Container(
                            margin: EdgeInsets.only(right: width*0.025),

                            width: width*0.49,
                            height: height*0.22,
                            child: Stack(
                              children: [
                                Container(

                                  width: width*0.49,
                                  height: height*0.22,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: mycolor
                                      ),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(images_file![index])
                                      )
                                  ),

                                ),

                                Positioned(
                                  right: width*0.015,
                                  top: height*0.01,
                                  child: InkWell(
                                    onTap: (){

                                      setState(() {
                                        images_file!.removeAt(index);
                                      });
                                    },
                                    child: CircleAvatar(
                                        radius: height*0.02,
                                        backgroundColor: Color(0xffDAC07A),
                                        child:Icon(Icons.delete,
                                          color: Colors.black,size: height*0.01852,)
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          )
                      ),
                    ),

                    SizedBox(height: height*0.015,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Videos",fontsize: 0.022)),
                    SizedBox(height: height*0.015,),


                    Row(

                      children: [

                        Expanded(

                          child:

                          (
                              thumbnail==null ||

                                  thumbnail!.isEmpty)?

                          InkWell(

                            onTap: () async {
                              //
                              await    _showvideoDialog().then((value) async {
                                try{

                                  YoutubeExplode yt = YoutubeExplode();
                                  Video video = await yt.videos.get(videocontroller.text);
                                  print("lalalala is "+thumbnail.toString());
                                   setState(() {
                                     thumbnail = video.thumbnails.highResUrl;
                                   });
                                   print("thumbnai is "+thumbnail.toString());

                                }catch(e){
                                  print("error is "+e.toString());
_showErrorDialog(e.toString());
                                }


                              }

                              );





                            },
                            child: Container(

                              height: height*0.15,
                              decoration: BoxDecoration(
                                color: addbg,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: mycolor
                                ),
                              ),
                              child: Icon(Icons.add,color: mycolor,size: 65),
                            ),
                          ):

                          InkWell(
                            onTap: ()async{

                              //
                              await    _showvideoDialog().then((value) async {
                                try{

                                  YoutubeExplode yt = YoutubeExplode();
                                  Video video = await yt.videos.get(videocontroller.text);

                                  setState(() {
                                    thumbnail = video.thumbnails.highResUrl;
                                  });
                                  print("thumbnai is "+thumbnail.toString());

                                }catch(e){

                                }


                              }

                              );

                            },
                            child: Container(

                                height: height*0.15,
                                decoration: BoxDecoration(
                                  color: addbg,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: mycolor
                                  ),
                       image: DecorationImage(image: NetworkImage(thumbnail!,),fit: BoxFit.cover)
                                ),

                            ),
                          )
                          ,
                        ),
                      ],
                    ),


                    //final Button
                    SizedBox(height: height*0.025,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Final Button Text", fontsize: 0.022)),
                    SizedBox(height: height*0.015,),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.054,
                          width: width*1,

                          decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: width*0.05),
                          child:TextFormField(
                            onEditingComplete: (){
                              calculatepercentage();
                              FocusScope.of(context).requestFocus(final_button_url);
                            },
                            focusNode: final_button,
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value){

                            },
                            onSaved: (value){
                              createprofile!.final_button!.title=value;
                            },
                            onFieldSubmitted: (value){
                              createprofile!.final_button!.title=value;
                            },
                            style: TextStyle(
                              color: Color(0xff5D5D5D),
                              fontFamily: 'Muli-Regular',

                            ),

                            decoration: InputDecoration(
                                hintText: "Book a meeting",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontFamily: 'Corporate A Italic',
                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),

                    //final Button URL
                    SizedBox(height: height*0.025,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: BuildWhiteMuiliTextBold(txt: "Final Button URL", fontsize: 0.022)),
                    SizedBox(height: height*0.015,),

                    Container(

                      alignment: Alignment.centerLeft,

                      child: Container(

                          height: height*0.054,

                          width: width*1,

                          decoration: BoxDecoration(

                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)

                          ),

                          padding: EdgeInsets.only(left: width*0.05),

                          child:TextFormField(

                            onEditingComplete: (){

                              calculatepercentage();

                              FocusScope.of(context).unfocus();

                            },

                            focusNode: final_button_url,

                            textAlignVertical: TextAlignVertical.center,

                            validator: (value){

                            },

                            onSaved: (value){

                              createprofile!.final_button!.url=value;

                            },

                            onFieldSubmitted: (value){

                              createprofile!.final_button!.url=value;

                            },

                            style: TextStyle(

                              color: Color(0xff5D5D5D),

                              fontFamily: 'Muli-Regular',

                            ),

                            decoration: InputDecoration(

                                hintText: "https://www.saintconnect.info",

                                border: InputBorder.none,

                                hintStyle: TextStyle(

                                    color: Color(0xff5D5D5D),

                                    fontFamily: 'Corporate A Italic',

                                    fontSize: 15

                                )

                            ),
                          )
                      ),

                    ),


                    SizedBox(height: height*0.05,),


                    // QrImage(
                    //   foregroundColor: mycolor,
                    //   data: 'hello',
                    //   version: QrVersions.auto,
                    //   dataModuleStyle: QrDataModuleStyle(
                    //     dataModuleShape: QrDataModuleShape.square
                    //   ),
                    //   embeddedImageStyle: QrEmbeddedImageStyle(
                    //     size: Size(90, 90)
                    //    ),
                    //   embeddedImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/nav_icons%2Flogo.png?alt=media&token=b7647d9a-a9b2-4ad7-ba89-3b1ae8bbd48e"),
                    //   size: MediaQuery.of(context).size.height*0.25,
                    //   gapless: true,
                    // ),

                    isloading?

                    Container(

                      height:  height*0.05,

                      width: width*1,

                      child: Stack(

                        children: [

                          LinearProgressIndicator(

                            value: createpercentage,

                            backgroundColor: bgcolor,

                            color: mycolor,

                            minHeight: height*0.05,

                          ),

                          Center(child: Text("Please wait, We are creating your profile",style: TextStyle(color: Colors.white),))

                        ],
                      ),
                    )



                        :

                    InkWell(

                        onTap: () async {

    if (await contacts. FlutterContacts.requestPermission()) {
      if(profile_file!=null) {
        url=await fileToUint8List(profile_file!);
      }

      _submit();
    }


                        },
                        child: BuildWhiteButton(text: "Create Profile")),

                    SizedBox(height: height*0.075,),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }



  Future<Uint8List?> fileToUint8List(File file) async {
    Uint8List?  uint8List;
   try {
      // Read the file as bytes
      List<int> bytes = await file.readAsBytes();

      // Convert bytes to Uint8List
      uint8List= Uint8List.fromList(bytes);

      return uint8List;
    } catch (e) {
      print('Error converting file to Uint8List: $e');

    }
 return uint8List;
 }
  var url;
  Future<File?> writeCounter(String profile_documentid) async {

    // ///Set properties
    // mycard.firstName = createprofile!.your_details!.name.toString();
    // mycard.workAddress =MailingAddress(createprofile!.your_details!.location.toString());
    // Map<String,String> ? map2 = {};
    // createprofile!.personal_connection!.forEach((customer) => map2[customer.media.toString()] = customer.url.toString());


    //
    // mycard.socialUrls=map2;
    // mycard.url="https://www.saintconnect.info/profile?uid=${profile_documentid}";
    // mycard.workPhone = createprofile!.business_details!.company_contact_no.toString();
    // mycard.workEmail =createprofile!.your_details!.email.toString();
    // mycard.cellPhone =createprofile!.your_details!.contact_no.toString();
    // mycard.jobTitle =createprofile!.your_details!.title.toString();
    //
    //
    // File ? dd=await _localFile;
    // /// Save to file
    //
    //
    // mycard.saveToFile(dd);
    //
    // print(mycard.getFormattedString());
    //
    // String contents = mycard. getFormattedString();
    //
    // final directory = await getApplicationDocumentsDirectory();
    //
    // final path = directory.path;
    //
    // final fs = File('$path/${currentuser!.uid}.vcf');
    // fs.writeAsStringSync(contents);

    List< contacts.SocialMedia> ? social_urls = [];

   personal_connections!.forEach(
            (customer) {
              social_urls.add(
                  contacts.SocialMedia(customer.url.toString()),
              );
            }
    );


print("amna jaan "+mydetail!.name.toString().toString()+" lala "+createprofile!.your_details!.name.toString());



    if (await contacts. FlutterContacts.requestPermission()) {

      final newContact = Contact(
        name:contacts.Name(first:mydetail!.name.toString(),last: ""),
        displayName: "my name",
        emails: [contacts.Email(mydetail!.email.toString())],
        addresses: [Address(mydetail!.location .toString())],
        phones: [Phone(createprofile!.your_details!.contact_no.toString())],
        socialMedias:social_urls,
        photo:url,
        websites: [contacts.Website("https://www.saintconnect.info/profile?uid=${profile_documentid}")],
        thumbnail: url,

      );

      await newContact.insert();

      // Export contact to vCard

      String mycard = newContact.toVCard();


      final directory = await getApplicationDocumentsDirectory();

      final path = directory.path;

      final fs = File('$path/${currentuser!.uid}.vcf');

      fs.writeAsStringSync(mycard);

    return fs;
    }





  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/${currentuser!.uid}.vcf');
  }
}
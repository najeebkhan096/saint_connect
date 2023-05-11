import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saintconnect/Database/database.dart';
import 'package:saintconnect/Database/profile.dart';
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
import 'package:vcard_maintained/vcard_maintained.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Editprofile extends StatefulWidget {
MyProfile ? desiredprofile;
Editprofile({required this.desiredprofile});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
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

  @override
  void initState() {
    // TODO: implement initState

get_design_appearence();


    super.initState();
  }
  bool gott=false;
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    if(gott==false){
      YoutubeExplode yt = YoutubeExplode();
      Video video = await yt.videos.get(widget.desiredprofile!.video.toString());

      setState(() {
        thumbnail = video.thumbnails.highResUrl;
      gott=true;
      });
    }

    super.didChangeDependencies();
  }
  String ? _show_delete(String docid) {
    showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
              backgroundColor: Color(0xff111111),
              title: BuildItalicTextwhite(txt: 'Delete Profile',fontsize:  0.018525),
              content: BuildItalicTextwhite(
                txt:
                  "Are you sure you want to remove this card, you can not undo this action ?",
            fontsize: 0.018,

              ),
              actions: <Widget>[


                Container(
                  decoration: BoxDecoration(
                      color: Color(0xffDAC07A),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextButton(
                    child: Text('Yes',style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      await profileDatabase.delete_profile(docid: docid).then((
                          value) {
                        Navigator.of(context).pop();
                      }).then((value) {
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

  List<String> social = [
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
  bool team = false;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
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

  FocusNode name = FocusNode();
  FocusNode email = FocusNode();
  FocusNode contact = FocusNode();
  FocusNode title = FocusNode();
  FocusNode location = FocusNode();
  FocusNode intro = FocusNode();
  FocusNode paragrpah = FocusNode();
  FocusNode bio = FocusNode();
  FocusNode final_button = FocusNode();
  FocusNode final_button_url = FocusNode();
  FocusNode personnelconn_title = FocusNode();
  FocusNode businessconn_title = FocusNode();

  FocusNode businessname = FocusNode();
  FocusNode contractor = FocusNode();
  FocusNode webiste = FocusNode();
  FocusNode businesscompany = FocusNode();


  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  File ? myfile;
  String ? QRImage = '';

  Widget Qrimage() {
    return Screenshot(
      controller: screenshotController,
      child: QrImage(
        data: currentuser!.uid!,
        version: QrVersions.auto,
        size: 200,
        gapless: false,
      ),
    );
  }

  double createpercentage = 0;

  Future GenerateQRCode() async {
    final Uint8List ? image = await screenshotController.captureFromWidget(
        Qrimage());

    setState(() {
      _imageFile = image;
    });

    if (image != null) {
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/$user_id.jpg').create();
      file.writeAsBytesSync(image);
      setState(() {
        myfile = file;
      });

      await uploadQR();
    }
  }


  Future uploadQR() async {
    try {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('QRCode/${Path.basename(myfile!.path)}');
      await ref!.putFile(myfile!).whenComplete(() async {
        await ref!.getDownloadURL().then((value) async {
          QRImage = value;
          setState(() {
            createpercentage = 0.5;
          });
        });
      });
    }
    catch (error) {

    }
  }

  CollectionReference ? imgRef;

  firebase_storage.Reference ? ref;

  Future<String?> upload_my_file({File ? myfile}) async {
    String ? got_image;
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('${"profile"}/${Path.basename(myfile!.path)}');
    await ref!.putFile(myfile).whenComplete(() async {
      await ref!.getDownloadURL().then((imageurl) {
        if (imageurl != null) {
          got_image = imageurl;
        }
      });
    });

    return got_image;
  }

  Future show_bottomsheet({required bool personel}) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(

        side: BorderSide(color: mycolor, width: 0.25, style: BorderStyle.none),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      backgroundColor: addbg,
      builder: (context) {
        return Container(
          height: height * 0.6,

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
            padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),

            child: ListView(

              children: [


                SizedBox(height: height * 0.025,),

                Center(
                  child: Container(
                    width: width * 1,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("images/logo.png", height: height * 0.04,),
                        SizedBox(width: width * 0.025,),
                        BuildItalicText(txt: "Connect", fontsize: 0.03),
                      ],
                    ),
                  ),
                ),


                SizedBox(height: height * 0.05,),


                BuildItalicText(txt: "Add Social Media", fontsize: 0.0358),
                SizedBox(height: height * 0.05,),
                Container(

                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.35,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return

                        InkWell(
                          onTap: () async {
                            if (social.length == index + 1) {
                              await _custom_media(
                                  choice: 'Custom URL', personel: personel);
                            }
                            else {
                              await _enter_media(choice: social[index],
                                  personel: personel,
                                  social_media_name:
                                  index == 0 ? "Facebook" :
                                  index == 1 ? "Instagram" :
                                  index == 2 ? "Snapchat" :
                                  index == 3 ? "Twitter" :
                                  index == 4 ? "Whatssapp" :
                                  index == 5 ? "Spotify" :
                                  index == 6 ? "Linkedin" :
                                  index == 7 ? "Youtube" :
                                  "Custom URL"
                              );
                            }
                          },
                          child:


                          Container(
                            height: height * 0.2,
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
                    itemCount: social.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: width * 0.025,
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
  Future<String?> upload_vcf_file({File ? myfile}) async {
    String ? got_image;
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('${"vcf"}/${Path.basename(myfile!.path)}');
    await ref!.putFile(myfile).whenComplete(() async {
      await ref!.getDownloadURL().then((imageurl) {
        if(imageurl!=null){
          got_image=imageurl;
        }
      });
    });

    return got_image;
  }
  ///Create a new vCard
  var mycard = VCard();
  Future<void> writeCounter() async {

    ///Set properties
    mycard.firstName = widget.desiredprofile!.your_details!.name.toString();
    mycard.workAddress =MailingAddress(widget.desiredprofile!.your_details!.location.toString());
    Map<String,String> ? map2 = {};
    widget.desiredprofile!.personal_connection!.forEach((customer) => map2[customer.media.toString()] = customer.url.toString());

    mycard.socialUrls=map2;
    mycard.workPhone = widget.desiredprofile!.business_details!.company_contact_no.toString();
    mycard.workEmail =widget.desiredprofile!.your_details!.email.toString();
    mycard.cellPhone =widget.desiredprofile!.your_details!.email.toString();
    mycard.jobTitle =widget.desiredprofile!.your_details!.title.toString();


    File ? dd=await _localFile;
    /// Save to file


    mycard.saveToFile(dd);

    print(mycard.getFormattedString());

    String contents = mycard. getFormattedString();

    final directory = await getApplicationDocumentsDirectory();

    final path = directory.path;

    final fs = File('$path/${currentuser!.uid}.vcf');
    fs.writeAsStringSync(contents);

  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/${currentuser!.uid}.vcf');
  }
  Future uploadFilelist(
      {List<File> ? mylist, String ? type, File ? myfile}) async {
    if (mylist != null) {
      for (int i = 0; i < mylist.length; i++) {
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('${"profile"}/${Path.basename(mylist[i].path)}');
        await ref!.putFile(mylist[i]).whenComplete(() async {
          await ref!.getDownloadURL().then((imageurl) {
            if (imageurl != null) {
              if (type == "images") {
                setState(() {
                  widget.desiredprofile!.images!.add(imageurl);
                });
              }
              else if (type == "accreditation") {
                setState(() {
                  widget.desiredprofile!.Accreditation!.add(imageurl);
                });
              }
              else if (type == "logo") {
                setState(() {
                  widget.desiredprofile!.logo != imageurl;
                });
              }
              else if (type == "myprofile") {
                setState(() {
                  widget.desiredprofile!.profile_image = imageurl;
                });
              }
              else if (type == "bgimage") {
                setState(() {
                  widget.desiredprofile!.Backgroundimage = imageurl;
                });
              }
              else if (type == "video") {
                setState(() {
                  widget.desiredprofile!.video = imageurl;
                });
              }
            }
          });
        });
      }
    }
    else {
      print("khan baba" + myfile.toString());

      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('${"profile"}/${Path.basename(myfile!.path)}');
      await ref!.putFile(myfile).whenComplete(() async {
        await ref!.getDownloadURL().then((imageurl) {
          if (imageurl != null) {
            if (type == "logo") {
              setState(() {
                widget.desiredprofile!.logo = imageurl;
              });
            }
            else if (type == "images") {
              setState(() {
                widget.desiredprofile!.images!.add(imageurl);
              });
            }
            else if (type == "profile") {
              setState(() {
                widget.desiredprofile!.profile_image = imageurl;
              });
            }
            else if (type == "bgimage") {
              setState(() {
                widget.desiredprofile!.Backgroundimage = imageurl;
              });
            }
            else if (type == "video") {
              setState(() {
                widget.desiredprofile!.video = imageurl;
              });
            }
            if (type == "images") {
              setState(() {
                widget.desiredprofile!.images!.add(imageurl);
              });
            }
            else if (type == "accreditation") {
              setState(() {
                widget.desiredprofile!.Accreditation!.add(imageurl);
              });
            }
          }
        });
      });
    }
  }



  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isloading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isloading = true;
    });

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');



    if(widget.desiredprofile!.your_details!.name!.isEmpty || widget.desiredprofile!.your_details!.email!.isEmpty){
      setState(() {
        isloading=false;
      });
      _showErrorDialog("Complete the required fields\n -Your Name\n -Your Email");
    }

    else if (!emailRegex.hasMatch(widget.desiredprofile!.your_details!.email!)){
      setState(() {
        isloading=false;
      });
      _showErrorDialog("Invalid Email");
    }

    else if(widget.desiredprofile!.business_details!.website!.isNotEmpty && (!widget.desiredprofile!.business_details!.website!.toUpperCase().startsWith("HTTPS://")

    )){
      setState(() {
        isloading=false;
      });
      _showErrorDialog("Please enter a valid link. For example https://www.saintconnect.info");
    }
    else if( widget.desiredprofile!.final_button!.url!.isNotEmpty &&  (!widget.desiredprofile!.final_button!.url!.toUpperCase().startsWith("HTTPS://"))
    ){

      setState(() {
        isloading=false;
      });

      _showErrorDialog("Please enter a valid link. For example https://www.saintconnect.info");

    }
    else{
      if(videocontroller.text.isNotEmpty){
        widget.desiredprofile!.video=videocontroller.text;
      }
      else{
        widget.desiredprofile!.video='';
      }


      await writeCounter().then((value)async {
        try {

          final file = await _localFile;

          ///save to file

          await  upload_vcf_file(myfile: file).then((vcf_image_url) async{

            widget.desiredprofile!.vcf_url=vcf_image_url.toString();
//lund
            setState(() {
              createpercentage = 0.35;
            });
            widget.desiredprofile!.design_appearance!.BackgroundTheme!.hexcode =bgcolors[0];
            widget.desiredprofile!.design_appearance!.TextColor!.hexcode =textcolors[0];
            widget.desiredprofile!.design_appearance!.ButtonColor!.hexcode =buttoncolors[0];
            widget.desiredprofile!.design_appearance!.BorderColor!.hexcode =bordercolors[0];

            await database.update_profile(
                createdprofile: widget.desiredprofile!, docid: widget.desiredprofile!.docid!)
                .then((value) async {
              setState(() {
                createpercentage = 1;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: mycolor,
                  content: Text(
                    "Profile Updated", style: TextStyle(color: Colors.white),)));


              Navigator.of(context).pop();
              setState(() {
                isloading = false;
              });
                });
//
          });


        } catch (e) {
          // If encountering an error, return 0

        }
      });


    }
























  }


  final picker = ImagePicker();
  String ? selectedoption;


  String ? images;

  TextEditingController _media_url = TextEditingController();
  TextEditingController _media_title = TextEditingController();
  
  Future<File?> _enter_media(
      {required String social_media_name, required String ? choice, required bool personel}) async {
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
                title: BuildItalicText(txt: social_media_name, fontsize: 0.025),
                content: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.2,
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
                                  hintText: 'Enter your ${social_media_name} URL'
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
                      SizedBox(height: height * 0.05,),
                      InkWell(
                        onTap: () {
                          bool exist = false;

                          if(_media_url.text.isNotEmpty && (_media_url.text.startsWith("HTTPS://") || _media_url.text.startsWith("https://")))

                           {
                            if (personel) {
                              widget.desiredprofile!.personal_connection!.forEach((
                                  element) {
                                if (element.media == choice) {
                                  exist = true;
                                }
                              });

                              if (exist == false) {
                                widget.desiredprofile!.personal_connection!.add(
                                    SocialMedia(
                                        media: choice,
                                        url: _media_url.text,
                                      title:  _media_title.text
                                    ));
                                        _media_url.clear();
                                _media_title.clear();
                                _media_title.clear();
                                Navigator.of(context).pop();
                              }
                              else {
                                        _media_url.clear();
                                _media_title.clear();
                                _media_title.clear();
                                Navigator.of(context).pop();
                              }
                            }
                            else {
                              widget.desiredprofile!.business_connection!.forEach((
                                  element) {
                                if (element.media == choice) {
                                  exist = true;
                                }
                              });

                              if (exist == false) {
                                widget.desiredprofile!.business_connection!.add(
                                    SocialMedia(
                                        media: choice,
                                        url: _media_url.text,
                                      title: _media_title.text
                                    ));
                                        _media_url.clear();
                                _media_title.clear();
                                _media_title.clear();
                                Navigator.of(context).pop();
                              }
                              else {
                                        _media_url.clear();
                                _media_title.clear();
                                Navigator.of(context).pop();
                              }
                            }
                          }
                          else{
                            _showErrorDialog("Please enter a valid link. For example https://www.saintconnect.info");

                          }
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: height * 0.054,
                            width: width * 1,
                            decoration: BoxDecoration(
                                color: Color(0xff111111),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.fromBorderSide(
                                    BorderSide(color: mycolor))
                            ),
                            child: Center(
                                child: BuildText(txt: "Save", fontsize: 0.025)),
                          ),

                        ),
                      )


                    ],
                  ),
                )));
    return choosedfile;
  }

  Future<File?> _custom_media(
      {required String ? choice, required bool personel}) async {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    File ? choosedfile;
    String ? choosedfile_url = '';

    bool saving = false;

    await showDialog(
        context: context,
        builder: (ctx) =>
            StatefulBuilder(builder: (context, mysetState) {
              return AlertDialog(
                  backgroundColor: Color(0xff111111),
                  title: BuildItalicText(txt: "Custom URL", fontsize: 0.025),
                  content: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.4,
                    child: ListView(
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
                        SizedBox(height: height * 0.025,),
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

                        choosedfile == null ?
                        InkWell(
                          onTap: () async {
                            await _show_my_Dialog('social_url').then((
                                value) async {
                              if (value != null) {
                                mysetState(() {
                                  choosedfile = value;
                                  saving = true;
                                });
                                double filelength = 0;
                                filelength =
                                (choosedfile!.lengthSync() / 1000000);
                                if (filelength < 4) {
                                  await upload_my_file(myfile: choosedfile)
                                      .then((value) {
                                    choosedfile_url = value;

                                    mysetState(() {
                                      saving = false;
                                    });
                                  });
                                }
                              }
                            });
                          },
                          child: Container(
                            height: height * 0.05,
                            width: width * 0.5,
                            child: Center(child: BuildItalicText(
                                txt: "Pick an Image", fontsize: 0.025)),
                          ),
                        )
                            :

                        Center(
                          child: Container(
                            height: height * 0.15,
                            width: width * 0.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: FileImage(choosedfile!),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.05,),

                        saving == true ? BuildItalicText(
                            txt: "Please wait a moment", fontsize: 0.025) :
                        InkWell(
                          onTap: () {
                            if(_media_url.text.isNotEmpty && (_media_url.text.startsWith("HTTPS://") || _media_url.text.startsWith("https://"))){
                              if (_media_url.text.isNotEmpty) {
                                bool exist = false;

                                if (personel) {
                                  widget.desiredprofile!.personal_connection!.forEach((
                                      element) {
                                    if (element.media == choice) {
                                      exist = true;
                                      int desiredindex = widget.desiredprofile!
                                          .personal_connection!.indexWhere((
                                          element) => element.media == choice);
                                      widget.desiredprofile!
                                          .personal_connection![desiredindex] =
                                          SocialMedia(
                                              media:
                                              choosedfile_url!.isEmpty
                                                  ? "https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FSafari.png?alt=media&token=df49bbf4-49e5-41dd-ae3d-bc2e388584eb"
                                                  :
                                              choosedfile_url,
                                              url: _media_url.text.isEmpty
                                                  ? "Custom URL"
                                                  : _media_url.text,
                                            title:  _media_title.text
                                          );
                                    }
                                  });

                                  if (exist == false) {
                                    widget.desiredprofile!.personal_connection!.add(
                                        SocialMedia(
                                            media:
                                            choosedfile_url!.isEmpty
                                                ? "https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FSafari.png?alt=media&token=df49bbf4-49e5-41dd-ae3d-bc2e388584eb"
                                                :
                                            choosedfile_url,
                                            url: _media_url.text.isEmpty
                                                ? "Custom URL"
                                                : _media_url.text,
                                          title:  _media_title.text
                                        ));
                                            _media_url.clear();
                                _media_title.clear();
                                    Navigator.of(context).pop();
                                  }
                                  else {
                                            _media_url.clear();
                                _media_title.clear();
                                    Navigator.of(context).pop();
                                  }
                                }
                                else {
                                  widget.desiredprofile!.business_connection!.forEach((
                                      element) {
                                    if (element.media == choice) {
                                      exist = true;
                                      int desiredindex = widget.desiredprofile!
                                          .business_connection!.indexWhere((
                                          element) => element.media == choice);
                                      widget.desiredprofile!
                                          .business_connection![desiredindex] =
                                          SocialMedia(
                                              media:
                                              choosedfile_url!.isEmpty
                                                  ? "https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FSafari.png?alt=media&token=df49bbf4-49e5-41dd-ae3d-bc2e388584eb"
                                                  :
                                              choosedfile_url,
                                              url: _media_url.text.isEmpty
                                                  ? "Custom URL"
                                                  : _media_url.text,
                                            title:  _media_title.text
                                          );
                                    }
                                  });

                                  if (exist == false) {
                                    widget.desiredprofile!.business_connection!.add(
                                        SocialMedia(
                                            media:
                                            choosedfile_url!.isEmpty
                                                ? "https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/Social_Icons%2FSafari.png?alt=media&token=df49bbf4-49e5-41dd-ae3d-bc2e388584eb"
                                                :
                                            choosedfile_url,
                                            url: _media_url.text.isEmpty
                                                ? "Custom URL"
                                                : _media_url.text,
                                          title:  _media_title.text
                                        ));
                                            _media_url.clear();
                                _media_title.clear();
                                    Navigator.of(context).pop();
                                  }
                                  else {
                                            _media_url.clear();
                                _media_title.clear();
                                    Navigator.of(context).pop();
                                  }
                                }
                              }
                            }else{
                              _showErrorDialog("Please enter a valid link. For example https://www.saintconnect.info");

                            }



                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: height * 0.054,
                              width: width * 1,
                              decoration: BoxDecoration(
                                  color: Color(0xff111111),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.fromBorderSide(
                                      BorderSide(color: mycolor))
                              ),
                              child: Center(child: BuildText(
                                  txt: "Save", fontsize: 0.025)),
                            ),

                          ),
                        )


                      ],
                    ),
                  ));
            }));
    return choosedfile;
  }

  Future<String?> _showvideoDialog() async {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    await showDialog(
        context: context,
        builder: (ctx) =>

            AlertDialog(
                backgroundColor: Color(0xff111111),
                title: BuildItalicText(txt: "Enter Video URL", fontsize: 0.025),
                content: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.2,
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
                      SizedBox(height: height * 0.05,),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: height * 0.054,
                            width: width * 1,
                            decoration: BoxDecoration(
                                color: Color(0xff111111),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.fromBorderSide(
                                    BorderSide(color: mycolor))
                            ),
                            child: Center(
                                child: BuildText(txt: "Save", fontsize: 0.025)),
                          ),

                        ),
                      )


                    ],
                  ),
                ))

    );
  }

  Future<File?> _show_my_Dialog(String ? choice) async {
    File ? choosedfile;
    await showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
                backgroundColor: Color(0xff111111),
                content: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        onTap: () async {
                          await getfilename(1, choice).then((value) async {
                            choosedfile = value;
                            Navigator.pop(context, value);
                          });
                        },
                        leading: Icon(
                          Icons.camera,
                          color: Color(0xffDAC07A),
                        ),
                        title: BuildItalicText(txt: "Camera", fontsize: 0.025),
                      ),
                      ListTile(
                        onTap: () async {
                          await getfilename(2, choice).then((value) {
                            choosedfile = value;
                            Navigator.pop(context, value);
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

  Future _showErrorDialog(String msg) async {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    await showDialog(
        context: context,
        builder: (ctx) =>

            AlertDialog(
              backgroundColor: Color(0xff111111),
              title: BuildItalicText(txt: "An Error Occured", fontsize: 0.025),
              content: BuildWhiteMuiliText(txt: msg, fontsize: 0.025),
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


  File ? profile_file;

  File ? logo_file;

  List<File> accreditation_file = [];

  List<File> ? images_file = [];
  List<String> images_url = [];


  File ? bg_file;
  TextEditingController videocontroller = TextEditingController();
  String ? thumbnail = '';


  Future<File?> getfilename(int choice, String ?operation) async {
    File ? selected_file;
    if (choice == 1) {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.camera);
      await image!.length().then((value) {

      });

      setState(() {
        if (operation == "profile") {
          profile_file = File(image.path);
          selected_file = File(image.path);
        }
        else if (operation == "logo") {
          logo_file = File(image.path);
          selected_file = File(image.path);
        }
        else if (operation == "accreditation") {
          double filelength = (File(image.path).lengthSync() / 1000000);
          if (filelength < 4) {
            accreditation_file.add(File(image.path));
          }


          selected_file = File(image.path);
        }
        else if (operation == "images") {
          double filelength = (File(image.path).lengthSync() / 1000000);
          if (filelength < 4) {
            images_file!.add(File(image.path));
          }


          selected_file = File(image.path);
        }

        else if (operation == "bgimage") {
          bg_file = File(image.path);
          selected_file = File(image.path);
        }

        else if (operation == "social_url") {
          selected_file = File(image.path);
        }
      });
    } else {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        if (operation == "profile") {
          profile_file = File(image!.path);
          selected_file = File(image.path);
        }
        else if (operation == "logo") {
          logo_file = File(image!.path);
          selected_file = File(image.path);
        }
        else if (operation == "accreditation") {
          double filelength = (File(image!.path).lengthSync() / 1000000);
          if (filelength < 4) {
            accreditation_file.add(File(image.path));
          }
          selected_file = File(image.path);
        }
        else if (operation == "images") {
          double filelength = (File(image!.path).lengthSync() / 1000000);
          if (filelength < 4) {
            images_file!.add(File(image.path));
          }
          selected_file = File(image.path);
        }

        else if (operation == "bgimage") {
          bg_file = File(image!.path);
          selected_file = File(image.path);
        }
        else if (operation == "social_url") {
          selected_file = File(image!.path);
        }
      });
    }
    return selected_file;
  }


  bool data_fetched = false;
  double percentage = 0;
void get_design_appearence(){

  int findindex=bgcolors.indexWhere((element) => element==widget.desiredprofile!.design_appearance!.BackgroundTheme!.hexcode .toString());

  if(findindex!=-1)
    bgcolors.removeAt(findindex);
  bgcolors.insert(0, widget.desiredprofile!.design_appearance!.BackgroundTheme!.hexcode .toString());


//text
   findindex=textcolors.indexWhere((element) => element==widget.desiredprofile!.design_appearance!.TextColor!.hexcode .toString());

  if(findindex!=-1){

    textcolors.removeAt(findindex);
  }

  textcolors.insert(0, widget.desiredprofile!.design_appearance!.TextColor!.hexcode .toString());

//button
//text
  findindex=buttoncolors.indexWhere((element) => element==widget.desiredprofile!.design_appearance!.ButtonColor!.hexcode .toString());
  if(findindex!=-1)
    buttoncolors.removeAt(findindex);
  buttoncolors.insert(0, widget.desiredprofile!.design_appearance!.ButtonColor!.hexcode .toString());


  //border
  //text
  findindex=bordercolors.indexWhere((element) => element==widget.desiredprofile!.design_appearance!.BorderColor!.hexcode .toString());
  if(findindex!=-1)
    bordercolors.removeAt(findindex);
  bordercolors.insert(0, widget.desiredprofile!.design_appearance!.BorderColor!.hexcode .toString());
setState(() {

});
}

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;


    if (data_fetched == false) {


      data_fetched = true;
      videocontroller.text = widget.desiredprofile!.video!;

      data_fetched = true;
    }

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            backgroundColor: bgcolor,
            body:
            data_fetched?
            Form(
                key: _formKey,
                child: ListView(

                    children: [


                      SizedBox(height: height * 0.02,),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: width * 0.1),
                        child: Image.asset(
                          "images/logo.png", height: height * 0.05,),),


                      Container(
                        margin: EdgeInsets.only(
                            left: width * 0.075, right: width * 0.075),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: height * 0.025,),
                            BuildItalicText(txt: "Got a Couple of Edits?",
                                fontsize: 0.0358),
                            SizedBox(height: height * 0.02,),
                            LinearProgressIndicator(
                              value: 0.15,
                              backgroundColor: bgcolor,
                              color: mycolor,
                              minHeight: height * 0.00252,
                            ),

                            SizedBox(height: height * 0.05,),


                            Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    double filelength = 0;
                                    await _show_my_Dialog("profile").then((
                                        value) async {
                                      if (profile_file != null) {
                                        filelength =
                                        (profile_file!.lengthSync() / 1000000);
                                        if (filelength < 4) {
                                          await upload_my_file(
                                              myfile: profile_file).then((
                                              value) {
                                            widget.desiredprofile!.profile_image =
                                                value;
                                          });
                                        }
                                        else {
                                          profile_file = null;
                                          _showErrorDialog(
                                              'File should be of less than 4 MB size');
                                        }
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: height * 0.14,
                                    width: width * 0.23,
                                    color: Color(0xff111111),
                                    child: Stack(
                                      children: [


                                        profile_file == null ?
                                        widget.desiredprofile!.profile_image!
                                            .isNotEmpty ?
                                        CircleAvatar(
                                          radius: width * 0.2,

                                          backgroundColor: Color(0xff111111),
                                          backgroundImage: NetworkImage(
                                              widget.desiredprofile!.profile_image!),
                                        ) :

                                        CircleAvatar(
                                          radius: width * 0.2,
                                          backgroundColor: Color(0xff111111),
                                          child: Image.asset("images/logo.png",
                                            width: width * 0.1,),
                                        )
                                            :
                                        CircleAvatar(
                                          radius: width * 0.2,
                                          backgroundColor: Color(0xff111111),
                                          backgroundImage: FileImage(
                                              profile_file!),
                                        ),

                                        Positioned(
                                          bottom: 0,
                                          right: 0,

                                          child: CircleAvatar(
                                            radius: 17,
                                            backgroundColor: mycolor,
                                            child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.black,
                                                child: Icon(
                                                  Icons.edit, color: mycolor,
                                                  size: 14,)
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        BuildWhiteMuiliTextBold(
                                            txt: "Your Profile Picture",
                                            fontsize: 0.022),
                                        BuildWhiteMuiliText(
                                            txt: "Upload a picture of yourself.",
                                            fontsize: 0.0185)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),

                            SizedBox(height: height * 0.025,),

                            Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    double filelength = 0;
                                    await _show_my_Dialog("logo").then((
                                        value) async {
                                      if (logo_file != null) {
                                        filelength =
                                        (logo_file!.lengthSync() / 1000000);
                                        if (filelength < 4) {
                                          await upload_my_file(
                                              myfile: logo_file).then((value) {
                                            widget.desiredprofile!.logo = value;
                                            print("akbar " +
                                                widget.desiredprofile!.logo
                                                    .toString());
                                          });
                                        }
                                        else {
                                          logo_file = null;
                                          _showErrorDialog(
                                              'File should be of less than 4 MB size');
                                        }
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: height * 0.14,
                                    width: width * 0.23,
                                    child: Stack(
                                      children: [


                                        logo_file == null ?
                                        widget.desiredprofile!.logo!.isNotEmpty ?
                                        CircleAvatar(
                                          radius: width * 0.2,
                                          backgroundImage: NetworkImage(
                                              widget.desiredprofile!.logo!),
                                        ) :
                                        CircleAvatar(
                                          radius: width * 0.2,
                                          backgroundColor: Color(0xff111111),
                                          child: Image.asset(
                                            "images/comp logo.png",
                                            width: width * 0.2,),
                                        )
                                            :
                                        CircleAvatar(
                                          radius: width * 0.2,
                                          backgroundImage: FileImage(
                                              logo_file!),
                                        ),

                                        Positioned(
                                          bottom: 0,
                                          right: 0,

                                          child: CircleAvatar(
                                            radius: 17,
                                            backgroundColor: mycolor,
                                            child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.black,
                                                child: Icon(
                                                  Icons.edit, color: mycolor,
                                                  size: 14,)
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        BuildWhiteMuiliTextBold(
                                            txt: "Company Logo",
                                            fontsize: 0.022),
                                        BuildWhiteMuiliText(
                                            txt: "Upload your Company Logo.",
                                            fontsize: 0.018)
                                      ],
                                    ),
                                  ),
                                )


                              ],
                            ),
                            SizedBox(height: height * 0.065,),

                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Your Details", fontsize: 0.028)),

                            SizedBox(height: height * 0.015,),
                            Container(

                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Name", fontsize: 0.022)),
                            SizedBox(height: height * 0.015,),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  height: height * 0.054,
                                  width: width * 1,

                                  decoration: BoxDecoration(
                                      color: Colors.white,

                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, bottom: height * 0.0),
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!.your_details!
                                        .name,
                                    focusNode: name,
                                    onEditingComplete: () {
                                      FocusScope.of(context).requestFocus(bio);
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!.your_details!.name =
                                          value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.your_details!.name =
                                          value;
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
                            SizedBox(height: height * 0.015,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Bio", fontsize: 0.022)),
                            SizedBox(height: height * 0.015,),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  height: height * 0.16,
                                  width: width * 1,

                                  decoration: BoxDecoration(
                                      color: Colors.white,

                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: EdgeInsets.only(left: width * 0.05,
                                      bottom: height * 0.015,
                                      right: width * 0.025),
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!.your_details!
                                        .bio,
                                    onEditingComplete: () {
                                      FocusScope.of(context).requestFocus(
                                          email);
                                    },
                                    keyboardType: TextInputType.text,
                                    focusNode: bio,
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 5,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!.your_details!.bio =
                                          value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.your_details!.bio =
                                          value;
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
                            SizedBox(height: height * 0.015,),

                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Email", fontsize: 0.022)),
                            SizedBox(height: height * 0.015,),

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
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!.your_details!
                                        .email,
                                    onEditingComplete: () {
                                      FocusScope.of(context).requestFocus(
                                          contact);
                                    },
                                    focusNode: email,
                                    textAlignVertical: TextAlignVertical.center,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!.your_details!.email =
                                          value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.your_details!.email =
                                          value;
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
                            SizedBox(height: height * 0.015,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Contact Number", fontsize: 0.022)),
                            SizedBox(height: height * 0.015,),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  height: height * 0.054,
                                  width: width * 1,

                                  decoration: BoxDecoration(
                                      color: Colors.white,

                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: EdgeInsets.only(left: width * 0.05,),
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!.your_details!
                                        .contact_no,
                                    onEditingComplete: () {
                                      FocusScope.of(context).requestFocus(
                                          title);
                                    },
                                    focusNode: contact,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!.your_details!
                                          .contact_no = value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.your_details!
                                          .contact_no = value;
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

                            SizedBox(height: height * 0.015,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Title/Company Position",
                                    fontsize: 0.022)),
                            SizedBox(height: height * 0.015,),
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
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!.your_details!
                                        .title,
                                    onEditingComplete: () {
                                      FocusScope.of(context).requestFocus(
                                          location);
                                    },
                                    focusNode: title,
                                    textAlignVertical: TextAlignVertical.center,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!.your_details!.title =
                                          value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.your_details!.title =
                                          value;
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

                            SizedBox(height: height * 0.015,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Location", fontsize: 0.022)),
                            SizedBox(height: height * 0.015,),
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
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!.your_details!
                                        .location,
                                    onEditingComplete: () {
                                      FocusScope.of(context).requestFocus(
                                          intro);
                                    },
                                    focusNode: location,
                                    textAlignVertical: TextAlignVertical.center,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!.your_details!.location =
                                          value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.your_details!.location =
                                          value;
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

                            SizedBox(height: height * 0.015,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Introductionary Heading",
                                    fontsize: 0.022)),
                            SizedBox(height: height * 0.015,),
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
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!.your_details!
                                        .intro_heading,
                                    onEditingComplete: () {
                                      FocusScope.of(context).requestFocus(
                                          paragrpah);
                                    },
                                    focusNode: intro,
                                    textAlignVertical: TextAlignVertical.center,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!.your_details!
                                          .intro_heading = value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.your_details!
                                          .intro_heading = value;
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

                            SizedBox(height: height * 0.015,),

                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Introductionary Paragraph",
                                    fontsize: 0.022)),

                            SizedBox(height: height * 0.015,),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  height: height * 0.2,
                                  width: width * 1,

                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                  padding: EdgeInsets.only(left: width * 0.05),
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!.your_details!
                                        .paragraph,
                                    onEditingComplete: () {
                                      FocusScope.of(context).requestFocus(
                                          personnelconn_title);
                                    },
                                    focusNode: paragrpah,
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 5,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!.your_details!.paragraph =
                                          value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.your_details!.paragraph =
                                          value;
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
                            SizedBox(height: height * 0.015,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Personal Connections Title",
                                    fontsize: 0.022)),
                            SizedBox(height: height * 0.015,),

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
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!
                                        .personal_connection_title,
                                    onEditingComplete: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    focusNode: personnelconn_title,
                                    textAlignVertical: TextAlignVertical.center,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!
                                          .personal_connection_title = value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!
                                          .personal_connection_title = value;
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


                            SizedBox(height: height * 0.025,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Personal Connections",
                                    fontsize: 0.028)),
                            SizedBox(height: height * 0.02,),
                            Container(

                              width: width * 1,
                              height:
                              widget.desiredprofile!.personal_connection!.length < 4 ?
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.15 :
                              (widget.desiredprofile!.personal_connection!.length <
                                  8 &&
                                  widget.desiredprofile!.personal_connection!.length >
                                      3) ?
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * (0.22) :
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * (0.32),

                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (ctx, index) {
                                  return

                                    index ==
                                        widget.desiredprofile!.personal_connection!
                                            .length ?

                                    InkWell(
                                      onTap: () async {
                                        await show_bottomsheet(personel: true)
                                            .then((value) {
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
                                        height: height * 0.2,
                                        decoration: BoxDecoration(
                                          color: addbg,
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          border: Border.all(
                                              color: mycolor
                                          ),
                                        ),
                                        child: Icon(Icons.add, color: mycolor,
                                            size: 35),
                                      ),
                                    ) :

                                    Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(

                                              borderRadius: BorderRadius.circular(
                                                  10),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      widget.desiredprofile!
                                                          .personal_connection![index]
                                                          .media!)
                                              )
                                          ),
                                        ),
                                        Positioned(
                                          right: width*0.015,
                                          top: height*0.01,
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                widget.desiredprofile!
                                                    .personal_connection!.removeAt(index);
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
                                itemCount: widget.desiredprofile!.personal_connection!
                                    .length + 1,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 1 / 1,
                                    crossAxisSpacing: width * 0.025,
                                    mainAxisSpacing: height * 0.01
                                  //emoji height
                                ),
                                padding: EdgeInsets.all(5),
                              ),
                            ),


                            SizedBox(height: height * 0.025,),

                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                  txt: "Accreditations & Badges",
                                  fontsize: 0.028,
                                  start: true,)),
                            SizedBox(height: height * 0.025,),
                            Container(

                              width: width * 1,
                              height: widget.desiredprofile!.Accreditation!.length < 3
                                  ?
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.15
                                  :
                              (widget.desiredprofile!.Accreditation!.length < 6 &&
                                  widget.desiredprofile!.Accreditation!.length > 3) ?
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * (2 * 0.15) :
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * (3 * 0.15),

                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (ctx, index) {
                                  return
                                    index ==
                                        widget.desiredprofile!.Accreditation!.length
                                        ? InkWell(
                                      onTap: () async {

                                        await _show_my_Dialog("accreditation")
                                            .then((value) async {

                                          double filelength = (value!.lengthSync() / 1000000);

                                          if (filelength < 4) {

                                            await uploadFilelist(myfile: value,
                                                type: 'accreditation').then((
                                                value) {

                                            });


                                        }
                                          else{
                                            _showErrorDialog(
                                                'File should be of less than 4 MB size');
                                          }
                                        });
                                      },
                                      child: Container(

                                        height: height * 0.2,
                                        decoration: BoxDecoration(
                                          color: addbg,
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          border: Border.all(
                                              color: mycolor
                                          ),
                                        ),
                                        child: Icon(Icons.add, color: mycolor,
                                            size: 35),
                                      ),
                                    )
                                        :
                                    Container(
                                      height: height * 0.2,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          border: Border.all(
                                              color: mycolor
                                          ),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  widget.desiredprofile!
                                                      .Accreditation![index])
                                          )

                                      ),
                                      child:   InkWell(
                                        onTap: (){
                                          setState(() {
                                            widget.desiredprofile!.Accreditation!.removeAt(index);
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: width*0.015,top: height*0.005),
                                          alignment: Alignment.topRight,
                                          child: CircleAvatar(
                                              radius: height*0.015,
                                              backgroundColor: Color(0xffDAC07A),
                                              child:Icon(Icons.delete,
                                                color: Colors.black,size: height*0.01652,)
                                          ),
                                        ),
                                      ),
                                    );
                                },
                                itemCount: widget.desiredprofile!.Accreditation!
                                    .length + 1,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 15,
                                  mainAxisExtent: 70,
                                  //emoji height
                                ),
                                padding: EdgeInsets.all(5),
                              ),
                            ),
                            SizedBox(height: height * 0.03,),


                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Business Details", fontsize: 0.028)),
                            SizedBox(height: height * 0.015,),
                            Container(

                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Buisness Name", fontsize: 0.02)),
                            SizedBox(height: height * 0.015,),
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
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!
                                        .business_details!.Business_name,
                                    focusNode: businessname,
                                    onEditingComplete: () {
                                      FocusScope.of(context).requestFocus(
                                          contractor);
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!.business_details!
                                          .Business_name = value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.business_details!
                                          .Business_name = value;
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
                            SizedBox(height: height * 0.015,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Industry/Sector", fontsize: 0.02)),
                            SizedBox(height: height * 0.015,),
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
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!
                                        .business_details!.company_sector,
                                    focusNode: contractor,
                                    onEditingComplete: () {
                                      FocusScope.of(context).requestFocus(
                                          webiste);
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    validator: (value) {

                                    },
                                    textInputAction: TextInputAction.done,
                                    onSaved: (value) {
                                      widget.desiredprofile!.business_details!
                                          .company_sector = value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.business_details!
                                          .company_sector = value;
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

                            SizedBox(height: height * 0.015,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Company Website", fontsize: 0.02)),
                            SizedBox(height: height * 0.015,),
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
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!
                                        .business_details!.website,
                                    focusNode: webiste,
                                    onEditingComplete: () {
                                      FocusScope.of(context).requestFocus(
                                          businesscompany);
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!.business_details!
                                          .website = value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.business_details!
                                          .website = value;
                                    },
                                    style: TextStyle(
                                      color: Color(0xff5D5D5D),
                                      fontFamily: 'Muli-Regular',

                                    ),
                                    decoration: InputDecoration(
                                        hintText: "www.saintconnect.info",
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

                            SizedBox(height: height * 0.015,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Company Number", fontsize: 0.02)),
                            SizedBox(height: height * 0.015,),
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
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!
                                        .business_details!.company_contact_no,
                                    focusNode: businesscompany,
                                    onEditingComplete: () {
                                      FocusScope.of(context).requestFocus(
                                          businessconn_title);
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!.business_details!
                                          .company_contact_no = value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.business_details!
                                          .company_contact_no = value;
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


                            SizedBox(height: height * 0.015,),

//businesss conn title

                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Business Connections Title",
                                    fontsize: 0.022)),
                            SizedBox(height: height * 0.015,),
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
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!
                                        .businesss_connection_title,
                                    onEditingComplete: () {
                                      FocusScopeNode currentFocus = FocusScope
                                          .of(context);

                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                    },
                                    focusNode: businessconn_title,
                                    textAlignVertical: TextAlignVertical.center,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!
                                          .businesss_connection_title = value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!
                                          .businesss_connection_title = value;
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
                            SizedBox(height: height * 0.015,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Business Connections",
                                    fontsize: 0.028)),

                            SizedBox(height: height * 0.02,),

                            Container(
                              width: width * 1,
                              height:
                              widget.desiredprofile!.business_connection!.length < 4 ?
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.15 :
                              (widget.desiredprofile!.business_connection!.length <
                                  8 &&
                                  widget.desiredprofile!.business_connection!.length >
                                      3) ?
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * (0.22) :
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * (0.32),
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (ctx, index) {
                                  return

                                    index ==
                                        widget.desiredprofile!.business_connection!
                                            .length ? InkWell(
                                      onTap: () async {
                                        await show_bottomsheet(personel: false);
                                        // await  _show_socialmedia_options().then((value) {
                                        //   setState((){
                                        //     print( widget.desiredprofile!.business_connection);
                                        //   });
                                        // });
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: addbg,
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          border: Border.all(
                                              color: mycolor
                                          ),
                                        ),
                                        child: Icon(Icons.add, color: mycolor,
                                            size: 35),
                                      ),
                                    ) :
                                    Stack(
                                      children: [
                                        Container(

                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(

                                              borderRadius: BorderRadius.circular(
                                                  10),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      widget.desiredprofile!
                                                          .business_connection![index]
                                                          .media!)
                                              )
                                          ),
                                        ),
                                        Positioned(
                                          right: width*0.015,
                                          top: height*0.01,
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                widget.desiredprofile!
                                                    .business_connection!.removeAt(index);
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
                                itemCount: widget.desiredprofile!.business_connection!
                                    .length + 1,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 1 / 1,
                                  mainAxisSpacing: height * 0.01,
                                  crossAxisSpacing: width * 0.025,
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
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Design & Appearance",
                                    fontsize: 0.025)),

                            SizedBox(height: height * 0.025,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Background Colour", fontsize: 0.022)),
                            SizedBox(height: height*0.025,),
                            Row(

                              children:   List.generate(bgcolors.length, (index) =>

                              index==bgcolors.length-1?

                              Container(
                                margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                                child: CircleAvatar(
                                  radius: height*0.014,
                                  backgroundColor: Color(int.parse(bgcolors[index])),
                                  child: CircleAvatar(
                                     radius: height*0.013,
                                    backgroundColor: bgcolor,
                                    child: InkWell(
                                        onTap: ()async{
                                          await _pickcolor(title: 'bg').then((value) {

                                          });

                                        },
                                        child: Icon(Icons.add,color: Color(int.parse(bgcolors[index])),size: height*0.0185)),
                                  ),
                                ),
                              )
                                  :
                              bgcolors[index]== widget.desiredprofile!.design_appearance!.BackgroundTheme?Text(""):
                              InkWell(
                                onTap: (){
                                  setState((){
                                    widget.desiredprofile!.                                    design_appearance!.BackgroundTheme=
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
                                    radius: height*0.014,
                                    backgroundColor: goldencolor,
                                    child: CircleAvatar(
                                      radius: height*0.013,
                                      backgroundColor: Color(int.parse(bgcolors[index])),
                                    ),
                                  ),
                                ):
                                Container(
                                  margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                                  child: CircleAvatar(
                                      backgroundColor: goldencolor,
                                      radius: height*0.014,
                                    child: CircleAvatar(
                                      radius:
                                      height*0.013,
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
                                    radius: height*0.014,
                                    backgroundColor: Color(int.parse(buttoncolors[index])),
                                    child: CircleAvatar(
                                      radius: height*0.013,
                                      backgroundColor: bgcolor,
                                      child: Icon(Icons.add,color: Color(int.parse(buttoncolors[index])),size: height*0.0185),
                                    ),
                                  ),
                                ),
                              )
                                  :
                              buttoncolors[index]== widget.desiredprofile!.design_appearance!.ButtonColor?Text(""):
                              InkWell(
                                onTap: (){
                                  setState((){
                                    widget.desiredprofile!.design_appearance!.ButtonColor=
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
                                    radius: height*0.014,
                                    backgroundColor:goldencolor,
                                    child: CircleAvatar(
                                      radius: height*0.013,
                                      backgroundColor: Color(int.parse(buttoncolors[index])),
                                    ),
                                  ),
                                ):
                                Container(
                                  margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                                  child: CircleAvatar(
                                    backgroundColor: goldencolor,
                                    radius: height*0.014,
                                    child: CircleAvatar(
                                      radius:
                                      height*0.013,
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
                                    radius: height*0.014,
                                    backgroundColor: Color(int.parse(textcolors[index])),
                                    child: CircleAvatar(
                                       radius: height*0.013,
                                      backgroundColor: bgcolor,
                                      child: Icon(Icons.add,color: Color(int.parse(textcolors[index])),size: height*0.0185),
                                    ),
                                  ),
                                ),
                              )
                                  :
                              textcolors[index]== widget.desiredprofile!.design_appearance!.TextColor?Text(""):
                              InkWell(
                                onTap: (){
                                  setState((){
                                    widget.desiredprofile!.design_appearance!.TextColor=
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
                                    radius: height*0.014,
                                    backgroundColor: goldencolor,
                                    child: CircleAvatar(
                                      radius: height*0.013,
                                      backgroundColor: Color(int.parse(textcolors[index])),
                                    ),
                                  ),
                                ):
                                Container(
                                  margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                                  child: CircleAvatar(
                                      backgroundColor: goldencolor,
                                      radius: height*0.014,
                                    child: CircleAvatar(
                                      radius:
                                      height*0.013,
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
                                    radius: height*0.014,
                                    backgroundColor: Color(int.parse(bordercolors[index])),
                                    child: CircleAvatar(
                                       radius: height*0.013,
                                      backgroundColor: bgcolor,
                                      child: Icon(Icons.add,color: Color(int.parse(bordercolors[index])),size: height*0.0185),
                                    ),
                                  ),
                                ),
                              )
                                  :
                              bordercolors[index]== widget.desiredprofile!.design_appearance!.BorderColor?Text(""):
                              InkWell(
                                onTap: (){
                                  setState((){
                                    widget.desiredprofile!.design_appearance!.BorderColor=
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
                                    radius: height*0.014,
                                    backgroundColor: goldencolor,
                                    child: CircleAvatar(
                                      radius: height*0.013,
                                      backgroundColor: Color(int.parse(bordercolors[index])),
                                    ),
                                  ),
                                ):
                                Container(
                                  margin: EdgeInsets.only(left: width*0.02,bottom: height*0.02),
                                  child: CircleAvatar(
                                      backgroundColor: goldencolor,
                                      radius: height*0.014,
                                    child: CircleAvatar(
                                      radius:

                                      height*0.013,
                                      backgroundColor:Color(int.parse(bordercolors[index])),
                                    ),
                                  ),
                                ),
                              )

                              ),
                            ),




                            SizedBox(height: height * 0.05,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Background Image", fontsize: 0.022)),

                            SizedBox(height: height * 0.015,),
                            Row(
                              children: [
                                bg_file == null ?
                                widget.desiredprofile!.Backgroundimage!.isNotEmpty ?
                                Container(
                                  width: width * 0.49,
                                  height: height * 0.22,
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          double filelength = 0;
                                          await _show_my_Dialog("bgimage")
                                              .then((value) async {
                                            if (bg_file != null) {
                                              filelength =
                                              (bg_file!.lengthSync() / 1000000);
                                              print("chennai " +
                                                  filelength.toString());
                                              if (filelength < 4) {
                                                await upload_my_file(
                                                    myfile: bg_file).then((
                                                    value) {
                                                  widget.desiredprofile!
                                                      .Backgroundimage = value;
                                                });
                                              }
                                              else {
                                                bg_file = null;
                                                _showErrorDialog(
                                                    'File should be of less than 4 MB size');
                                              }
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: width * 0.49,
                                          height: height * 0.22,
                                          decoration: BoxDecoration(
                                              color: addbg,
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                              border: Border.all(
                                                  color: mycolor
                                              ),
                                              image: DecorationImage(
                                                  fit: BoxFit.values[2],
                                                  image: NetworkImage(
                                                      widget.desiredprofile!
                                                          .Backgroundimage!)
                                              )
                                          ),
// child:  InkWell(
//   onTap: (){
//     setState(() {
//    bg_file=null;
//      widget.desiredprofile!.Backgroundimage='';
//     });
//   },
//   child: Container(
//     margin: EdgeInsets.only(right: width*0.015,top: height*0.005),
//     alignment: Alignment.topRight,
//     child: CircleAvatar(
//         radius: height*0.015,
//         backgroundColor: Color(0xffDAC07A),
//         child:Icon(Icons.delete,
//           color: Colors.black,size: height*0.01652,)
//     ),
//   ),
// ),
                                        ),
                                      ),
                                      Positioned(
                                        right: width * 0.015,
                                        top: height * 0.01,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              bg_file = null;
                                              widget.desiredprofile!.Backgroundimage =
                                              '';
                                            });
                                          },
                                          child: CircleAvatar(
                                              radius: height * 0.02,
                                              backgroundColor: Color(
                                                  0xffDAC07A),
                                              child: Icon(Icons.delete,
                                                color: Colors.black,
                                                size: height * 0.022,)
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ) :
                                InkWell(
                                  onTap: () async {
                                    await _show_my_Dialog("bgimage").then((
                                        value) async {
                                      if (bg_file != null) {
                                        double filelength = (bg_file!
                                            .lengthSync() / 1000000);
                                        if (filelength < 4) {
                                          await upload_my_file(myfile: bg_file)
                                              .then((value) {
                                            widget.desiredprofile!.Backgroundimage =
                                                value;
                                          });
                                        }
                                        else {
                                          bg_file = null;
                                          _showErrorDialog(
                                              'File should be of less than 4 MB size');
                                        }
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: width * 0.49,
                                    height: height * 0.22,
                                    decoration: BoxDecoration(
                                      color: addbg,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: mycolor
                                      ),
                                    ),
                                    child: Icon(
                                        Icons.add, color: mycolor, size: 65),
                                  ),
                                )
                                    :
                                Container(
                                  width: width * 0.49,
                                  height: height * 0.22,
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          double filelength = 0;
                                          await _show_my_Dialog("bgimage")
                                              .then((value) async {
                                            if (bg_file != null) {
                                              filelength =
                                              (bg_file!.lengthSync() / 1000000);
                                              print("chennai " +
                                                  filelength.toString());
                                              if (filelength < 4) {
                                                await upload_my_file(
                                                    myfile: bg_file).then((
                                                    value) {
                                                  widget.desiredprofile!
                                                      .Backgroundimage = value;
                                                });
                                              }
                                              else {
                                                bg_file = null;
                                                _showErrorDialog(
                                                    'File should be of less than 4 MB size');
                                              }
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: width * 0.49,
                                          height: height * 0.22,
                                          decoration: BoxDecoration(
                                              color: addbg,
                                              borderRadius: BorderRadius
                                                  .circular(10),
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
                                        right: width * 0.015,
                                        top: height * 0.01,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              bg_file = null;
                                            });
                                          },
                                          child: CircleAvatar(
                                              radius: height * 0.02,
                                              backgroundColor: Color(
                                                  0xffDAC07A),
                                              child: Icon(Icons.delete,
                                                color: Colors.black,
                                                size: height * 0.022,)
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: height * 0.02,),

                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Images", fontsize: 0.022)),

                            SizedBox(height: height * 0.015,),
                            Container(
                              height: height * 0.23,
                              child: ListView(
                                  scrollDirection: Axis.horizontal,

                                  children: List.generate(
                                    widget.desiredprofile!.images!.length + 1, (
                                      index) =>
                                  widget.desiredprofile!.images!.length == index ?
                                  InkWell(
                                    onTap: () async {
                                      await _show_my_Dialog("images").then((
                                          value) async {
                                        if (value != null) {
                                          double filelength = 0;
                                          filelength =
                                          (value.lengthSync() / 1000000);
                                          if (filelength < 4) {
                                            await uploadFilelist(
                                                type: 'images', myfile: value)
                                                .then((value) {
                                              setState(() {

                                              });
                                            });
                                          }
                                        }
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: width * 0.025),
                                      width: width * 0.49,
                                      height: height * 0.22,
                                      decoration: BoxDecoration(
                                        color: addbg,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: mycolor
                                        ),
                                      ),
                                      child: Icon(
                                          Icons.add, color: mycolor, size: 65),
                                    ),
                                  ) : Container(
                                    margin: EdgeInsets.only(
                                        right: width * 0.025),

                                    width: width * 0.49,
                                    height: height * 0.22,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: mycolor
                                        ),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                widget.desiredprofile!.images![index])
                                        )
                                    ),
child:  InkWell(
  onTap: (){
    setState(() {
      widget.desiredprofile!.images!.removeAt(index);
    });
  },
  child: Container(
    margin: EdgeInsets.only(right: width*0.015,top: height*0.005),
    alignment: Alignment.topRight,
    child: CircleAvatar(
        radius: height*0.019,
        backgroundColor: Color(0xffDAC07A),
        child:Icon(Icons.delete,
          color: Colors.black,size: height*0.021,)
    ),
  ),
),
                                  ),
                                  )
                              ),
                            ),

                            SizedBox(height: height * 0.015,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Videos", fontsize: 0.022)),
                            SizedBox(height: height * 0.015,),
                            Row(

                              children: [

                                Expanded(

                                  child:

                                  (
                                      thumbnail == null ||

                                          thumbnail!.isEmpty) ?

                                  InkWell(

                                    onTap: () async {
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

                                      height: height * 0.15,
                                      decoration: BoxDecoration(
                                        color: addbg,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: mycolor
                                        ),
                                      ),
                                      child: Icon(
                                          Icons.add, color: mycolor, size: 65),
                                    ),
                                  ) :

                                  InkWell(
                                    onTap: () async {
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

                                        height: height * 0.15,
                                        decoration: BoxDecoration(
                                          color: addbg,
                                          borderRadius: BorderRadius.circular(
                                              10),
                                            image: DecorationImage(image: NetworkImage(thumbnail!,),fit: BoxFit.cover)
                                        ),

                                    ),
                                  )
                                  ,
                                ),
                              ],
                            ),


                            //final Button
                            SizedBox(height: height * 0.025,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Final Button Text", fontsize: 0.022)),
                            SizedBox(height: height * 0.015,),

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
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!.final_button!
                                        .title,
                                    onEditingComplete: () {
                                      FocusScope.of(context).requestFocus(
                                          final_button_url);
                                    },
                                    focusNode: final_button,
                                    textAlignVertical: TextAlignVertical.center,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!.final_button!.title =
                                          value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.final_button!.title =
                                          value;
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
                            SizedBox(height: height * 0.025,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: BuildWhiteMuiliTextBold(
                                    txt: "Final Button URL", fontsize: 0.022)),
                            SizedBox(height: height * 0.015,),

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
                                  child: TextFormField(
                                    initialValue: widget.desiredprofile!.final_button!
                                        .url,
                                    onEditingComplete: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    focusNode: final_button_url,
                                    textAlignVertical: TextAlignVertical.center,
                                    validator: (value) {

                                    },
                                    onSaved: (value) {
                                      widget.desiredprofile!.final_button!.url =
                                          value;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.desiredprofile!.final_button!.url =
                                          value;
                                    },
                                    style: TextStyle(
                                      color: Color(0xff5D5D5D),
                                      fontFamily: 'Muli-Regular',

                                    ),

                                    decoration: InputDecoration(
                                        hintText: "www.saintconnect.info",
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

                            isloading ?
                            Container(
                              height: height * 0.05,
                              width: width * 1,
                              child: Stack(
                                children: [

                                  LinearProgressIndicator(
                                    value: createpercentage,
                                    backgroundColor: bgcolor,
                                    color: mycolor,
                                    minHeight: height * 0.05,
                                  ),

                                  Center(child: Text(
                                    "Please wait, We are updating your profile",
                                    style: TextStyle(color: Colors.white),))

                                ],
                              ),
                            )


                                :
                            InkWell(
                                onTap: () {
                                  _submit();
                                },
                                child: BuildWhiteButton(
                                    text: "Update Profile")),
                            SizedBox(height: height * 0.025,),
                            InkWell(
                                onTap: () async{
                                 await  _show_delete(widget.desiredprofile!.docid!);

                                },
                                child: Center(child: BuildText(txt: "Delete Profile", fontsize: 0.02))
                      ),
                            SizedBox(height: height * 0.075,),
                          ],
                        ),
                      )
                    ])):
                SpinKitCircle(color: Colors.white,)
        ));
  }
  
}
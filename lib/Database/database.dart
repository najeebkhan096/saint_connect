import 'dart:io' show Platform;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saintconnect/constants.dart';
import 'package:saintconnect/module/MyProfile.dart';
import 'package:saintconnect/module/analytic.dart';
import 'package:saintconnect/module/cards.dart';
import 'package:saintconnect/module/myuser.dart';
import 'package:saintconnect/module/view.dart';
import 'package:saintconnect/widgets/buildtext.dart';
import 'package:saintconnect/widgets/wrapper.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
class Database {

  Future<ProfileAnalytic?> fetch_profileAnalatics({required String id,
  required
    DateTimeRange ? desired_date
  }) async {


    ProfileAnalytic ? myanalytic=ProfileAnalytic(
        date: '',
        most_engage: MostEngaged(

        ),
      pupolar_devices: PopularDevices()

    ) ;

    CollectionReference<Map<String, dynamic>> mainCollectionRef =  FirebaseFirestore.instance.collection('Profile');
    DocumentReference<Map<String, dynamic>> documentRef = mainCollectionRef.doc(id);
    CollectionReference<Map<String, dynamic>> nestedCollectionRef = documentRef.collection('analytics');

    QuerySnapshot<Map<String, dynamic>> nestedCollectionSnapshot = await nestedCollectionRef.get();

    if (nestedCollectionSnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot in nestedCollectionSnapshot.docs) {

        Map<String, dynamic> data = snapshot.data();

        // Access the fields within each document

        List splitted_data=[];

        if(data['date']!=null){

         myanalytic.date=data['date'].toString();

         String mydate=data['date'].toString();

         splitted_data =mydate.split("-");

        }


if(splitted_data.length>0 ){

  if(  desired_date!.start.isBefore(DateTime(
    int.parse( splitted_data[0]),
    int.parse( splitted_data[1]),
    int.parse( splitted_data[2]),


  ))
  &&

      desired_date.end.isAfter(DateTime(
        int.parse( splitted_data[0]),
        int.parse( splitted_data[1]),
        int.parse( splitted_data[2]),


      ))
  ){


    if(data['averageProfileTime']!=null){

      myanalytic.averageprofiletime=data['averageProfileTime'];

    }
    if(data['profileViews']!=null){
      myanalytic.profileviews=data['profileViews'];
    }
    print("kwas 11");
    if(data['popularDevices']!=null){

    if(data['popularDevices']['Desktop']!=null){

      myanalytic.pupolar_devices!.desktop=data['popularDevices']['Desktop'];
      print(' baba lala  '+snapshot.id.toString() );
    }
    if(data['popularDevices']['mobile']!=null){

      myanalytic.pupolar_devices!.mobile=data['popularDevices']['mobile'];
    print("jawaan");
    }
    else if(data['popularDevices']['Mobile']!=null){

      myanalytic.pupolar_devices!.mobile=data['popularDevices']['Mobile'];
      print("jawaan");
    }
    }

    if(data['mostEngage']!=null){

      var engagedata=data['mostEngage'];


      if(engagedata['businessInstagram']!=null){
        myanalytic.most_engage!.businessinst=engagedata['businessInstagram'];
      }
      if(engagedata['businessTwitter']!=null){
        myanalytic.most_engage!.businesstwitter=engagedata['businessTwitter'];
      }

      if(engagedata['businessSnapchat']!=null){
        myanalytic.most_engage!.businesssnapchat=engagedata['businessSnapchat'];
      }
      if(engagedata['businessSpotify']!=null){
        myanalytic.most_engage!.businessspotify=engagedata['businessSpotify'];
      }
      if(engagedata['businessYoutube']!=null){
        myanalytic.most_engage!.businessyoutube=engagedata['businessYoutube'];
      }
      if(engagedata['businessLinkedin']!=null){
        myanalytic.most_engage!.businesslinkedin=engagedata['businessLinkedin'];
      }
      if(engagedata['businessWhatsapp']!=null){
        myanalytic.most_engage!.businesswhatssapp=engagedata['businessWhatsapp'];
      }

      if(engagedata['businessFacebook']!=null){
        myanalytic.most_engage!.businessfb=engagedata['businessFacebook'];
      }

      //personaal connection
      if(engagedata['personalInstagram']!=null){
        myanalytic.most_engage!.perosonalinst=engagedata['personalInstagram'];
      }
      if(engagedata['personalTwitter']!=null){
        myanalytic.most_engage!.personaltwitter=engagedata['personalTwitter'];
      }

      if(engagedata['personalSnapchat']!=null){
        myanalytic.most_engage!.personalsnapchat=engagedata['personalSnapchat'];
      }
      if(engagedata['personalSpotify']!=null){
        myanalytic.most_engage!.personalspotify=engagedata['personalSpotify'];
      }
      if(engagedata['personalYoutube']!=null){
        myanalytic.most_engage!.personaltyoutube=engagedata['personalYoutube'];
      }
      if(engagedata['personalLinkedin']!=null){
        myanalytic.most_engage!.personallinkedin=engagedata['personalLinkedin'];
      }

      if(engagedata['personalWhatssapp']!=null){

        myanalytic.most_engage!.personalwhatsapp=engagedata['personalWhatssapp'];
      }
      if(engagedata['businessCustom']!=null){

        myanalytic.most_engage!.businesscustom=engagedata['businessCustom'];
      }

      if(engagedata['personalCustom']!=null){

        myanalytic.most_engage!.perosonalcustom=engagedata['personalCustom'];
      }

      if(engagedata['personalFacebook']!=null){
        myanalytic.most_engage!.personalfb=engagedata['personalFacebook'];
      }


      if(engagedata['personalEmail']!=null){
        myanalytic.most_engage!.personalEmail=engagedata['personalEmail'];
      }
      if(engagedata['personalPhone']!=null){
        myanalytic.most_engage!.personalPhone=engagedata['personalPhone'];
      }
      if(engagedata['contactDownload']!=null){
        myanalytic.most_engage!.contactDownload=engagedata['contactDownload'];
      }

    }

  }
}
else{

}


        // ...
      }
    }
else{

    }


    return myanalytic;
  }



  Future<List<MyProfile>> fetch_platform_desired_id(
      {required String id}) async {
    List<MyProfile> ? createprofile = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print(element);
        Map<dynamic, dynamic> fetcheddata =
        element.data() as Map<dynamic, dynamic>;

        if (fetcheddata['userid'] == id) {
          Timestamp stamp = element['date'];

          List<dynamic> profileview_dynamic = fetcheddata['views'];
          List<ProfileView> profileview = [];
          if (profileview_dynamic.length > 0) {
            profileview_dynamic.forEach((e) {
              Timestamp stamp = e['date'];
              profileview.add(
                  ProfileView(
                      date: stamp.toDate(),
                      userid: e['userid']
                  )
              );
            });
          }

          List<dynamic> accreditration_dynamic = fetcheddata['accreditaion'];

          List<dynamic> business_connection_dynamic =

          fetcheddata['business_connection'] == null
              ? []
              : fetcheddata['business_connection'];
          List<SocialMedia> business_connection = [];
          List<String> accreditation = [];
          List<dynamic> images_dynamic = fetcheddata['images'];
          List<String> images = [];
          List<
              dynamic> personal_connection_dynamic = fetcheddata['personal_connections'];
          List<SocialMedia> personal_connection = [];
          if (accreditration_dynamic.length > 0) {
            accreditration_dynamic.forEach((element) {
              accreditation.add(element['image']);
            });
          }
          if (images_dynamic.length > 0) {
            images_dynamic.forEach((element) {
              images.add(element['image']);
            });
          }
          if (personal_connection_dynamic.length > 0) {
            personal_connection_dynamic.forEach((element) {
              personal_connection.add(SocialMedia(
                  media: element['media'],
                  url: element['url'],
                title: element['title'],
                profile_handle: element['profile_handle']
              ));
            });
          }
          if (business_connection_dynamic.length > 0) {
            business_connection_dynamic.forEach((element) {
              business_connection.add(SocialMedia(
                  media: element['media'],
                  url: element['url'],
                title: element['title'],
                profile_handle: element['profile_handle']
              ));
            });
          }
          List<String> platforms=[];
          List<dynamic> platformsdynamic=fetcheddata['platform'];
          if(platformsdynamic.length>0){
            platformsdynamic.forEach((plat) {
              platforms.add(plat);
            });
          }

          Map qr=fetcheddata['qrcode'];
          createprofile.add(
              MyProfile(
                final_button: FinalButton(
                    title: fetcheddata['final_button_title'],
                    url: fetcheddata['final_button_url']
                ),

                personal_connection_title: fetcheddata['personal_connection_title'],
                businesss_connection_title: fetcheddata['businesss_connection_title'],
                date: stamp.toDate(),
                // year: fetcheddata['owner'],
                views: profileview,
                profile_image: fetcheddata['profile_image'],
                logo: fetcheddata['logo'],
                docid: element.id,
                qrcode: MyQrCode(docid: '', image: qr['image'],golden_image:  qr['goldem_image'],  secondarycolor: qr['secondary_color'],

                backgroundcolor: qr['background_color']
                ),
                uid: fetcheddata['userid'],
                business_connection: business_connection,
                your_details: YourDetails(
                  bio: fetcheddata['your_details']['bio'],
                  name: fetcheddata['your_details']['name'],
                  paragraph: fetcheddata['your_details']['paragraph'],
                  intro_heading: fetcheddata['your_details']['intro_heading'],
                  contact_no: fetcheddata['your_details']['contact_no'],
                  location: fetcheddata['your_details']['location'],
                  title: fetcheddata['your_details']['title'],
                  email: fetcheddata['your_details']['email'],
                ),
                personal_connection: personal_connection,
                Accreditation: accreditation,
                business_details: BusinessDetails(
                    website: fetcheddata['business_details']['website'],
                    company_sector: fetcheddata['business_details']['company_sector'],
                    company_contact_no: fetcheddata['business_details']['company_contact_no'],
                    Business_name: fetcheddata['business_details']['Business_name']
                ),
                design_appearance: Design_Appearance(
                    TextColor: CustomColor(hexcode: fetcheddata['design_appearance']['TextColor']),
                    ButtonColor: CustomColor(hexcode: fetcheddata['design_appearance']['ButtonColor']),
                    BackgroundTheme: CustomColor(hexcode: fetcheddata['design_appearance']['BackgroundTheme']),
                    BorderColor:  CustomColor(hexcode: fetcheddata['design_appearance']['BorderColor'])
                ),
                Backgroundimage: fetcheddata['background_image'],
                images: images,
                video: fetcheddata['video'],
                platforms: platforms
              ));
        }
      });
    });
    return createprofile;
  }

  //ferch profiles
  Future<List<MyProfile>> fetch_profiles_by_desired_id(
      {required String id}) async {

    List<MyProfile> ? createprofile = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print(element);
        Map<dynamic, dynamic> fetcheddata =
        element.data() as Map<dynamic, dynamic>;

        if (fetcheddata['userid'] == id) {
          Timestamp stamp = element['date'];
          Timestamp expirystamp = element['expiry_date'];
          List<dynamic> profileview_dynamic = fetcheddata['views'];
          List<ProfileView> profileview = [];
          if (profileview_dynamic.length > 0) {
            profileview_dynamic.forEach((e) {
              Timestamp stamp = e['date'];
              profileview.add(
                  ProfileView(
                      date: stamp.toDate(),
                      userid: e['userid']
                  )
              );
            });
          }

          List<dynamic> accreditration_dynamic = fetcheddata['accreditaion'];

          List<dynamic> business_connection_dynamic =

          fetcheddata['business_connection'] == null
              ? []
              : fetcheddata['business_connection'];
          List<SocialMedia> business_connection = [];
          List<String> accreditation = [];
          List<dynamic> images_dynamic = fetcheddata['images'];
          List<String> images = [];
          List<
              dynamic> personal_connection_dynamic = fetcheddata['personal_connections'];
          List<SocialMedia> personal_connection = [];
          if (accreditration_dynamic.length > 0) {
            accreditration_dynamic.forEach((element) {
              accreditation.add(element['image']);
            });
          }
          if (images_dynamic.length > 0) {
            images_dynamic.forEach((element) {
              images.add(element['image']);
            });
          }
          if (personal_connection_dynamic.length > 0) {
            personal_connection_dynamic.forEach((element) {
              personal_connection.add(SocialMedia(
                  media: element['media'],
                  url: element['url'],
                title: element['title'],
                profile_handle: element['profile_handle']
              ));
            });
          }
          if (business_connection_dynamic.length > 0) {
            business_connection_dynamic.forEach((element) {
              business_connection.add(SocialMedia(
                  media: element['media'],
                  url: element['url'],
                title: element['title'],
                profile_handle: element['profile_handle']
              ));
            });
          }
          List<String> platforms=[];
          List<dynamic> platformsdynamic=fetcheddata['platform'];
          if(platformsdynamic.length>0){
            platformsdynamic.forEach((plat) {
              platforms.add(plat);
            });
          }
          Map qr=fetcheddata['qrcode'];
          createprofile.add(
              MyProfile(
                ExpirayDate: expirystamp.toDate(),
                final_button: FinalButton(
                  title: fetcheddata['final_button_title'],
                  url: fetcheddata['final_button_url']
                ),

     personal_connection_title: fetcheddata['personal_connection_title'],
                  businesss_connection_title: fetcheddata['businesss_connection_title'],
                  date: stamp.toDate(),
                  // year: fetcheddata['year'],
                  views: profileview,
                  profile_image: fetcheddata['profile_image'],
                  logo: fetcheddata['logo'],
                  docid: element.id,
                  qrcode: MyQrCode(docid: '', image: qr['image'],
                      golden_image:  qr['goldem_image'],

                      secondarycolor: qr['secondary_color'],backgroundcolor:
                  qr['background_color']),
                  uid: fetcheddata['userid'],
                  business_connection: business_connection,
                  your_details: YourDetails(
                    bio: fetcheddata['your_details']['bio'],
                    name: fetcheddata['your_details']['name'],
                    paragraph: fetcheddata['your_details']['paragraph'],
                    intro_heading: fetcheddata['your_details']['intro_heading'],
                    contact_no: fetcheddata['your_details']['contact_no'],
                    location: fetcheddata['your_details']['location'],
                    title: fetcheddata['your_details']['title'],
                    email: fetcheddata['your_details']['email'],
                  ),
                  personal_connection: personal_connection,
                  Accreditation: accreditation,
                  business_details: BusinessDetails(
                      website: fetcheddata['business_details']['website'],
                      company_sector: fetcheddata['business_details']['company_sector'],
                      company_contact_no: fetcheddata['business_details']['company_contact_no'],
                      Business_name: fetcheddata['business_details']['Business_name']
                  ),
                  design_appearance: Design_Appearance(
                      TextColor: CustomColor(hexcode: fetcheddata['design_appearance']['TextColor']),
                      ButtonColor: CustomColor(hexcode: fetcheddata['design_appearance']['ButtonColor']),
                      BackgroundTheme: CustomColor(hexcode: fetcheddata['design_appearance']['BackgroundTheme']),
                    BorderColor:  CustomColor(hexcode: fetcheddata['design_appearance']['BorderColor'])
                  ),
                  Backgroundimage: fetcheddata['background_image'],
                  images: images,
                  video: fetcheddata['video'],
platforms: platforms
              ));
        }
      });
    }).then((value) {

     createprofile.sort((a, b) =>a.date!.compareTo(b.date!));



    });
    return createprofile;
  }

  Future<List<MyProfile>> fetch_all_types_profiles() async {
    List<MyProfile> ? createprofile = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print(element);
        Map<dynamic, dynamic> fetcheddata =
        element.data() as Map<dynamic, dynamic>;


        List<dynamic> profileview_dynamic = fetcheddata['views'];
        List<ProfileView> profileview = [];
        List<String> platforms=[];
        List<dynamic> platformsdynamic=fetcheddata['platform'];
        if(platformsdynamic.length>0){
          platformsdynamic.forEach((plat) {
            platforms.add(plat);
          });
        }
        if (profileview_dynamic.length > 0) {
          profileview_dynamic.forEach((e) {
            Timestamp stamp = e['date'];
            profileview.add(
                ProfileView(
                    date: stamp.toDate(),
                    userid: e['userid']
                )
            );
          });
        }

        List<dynamic> accreditration_dynamic = fetcheddata['accreditaion'];

        List<dynamic> business_connection_dynamic =

        fetcheddata['business_connection'] == null
            ? []
            : fetcheddata['business_connection'];
        List<SocialMedia> business_connection = [];
        List<String> accreditation = [];
        List<dynamic> images_dynamic = fetcheddata['images'];
        List<String> images = [];
        List<
            dynamic> personal_connection_dynamic = fetcheddata['personal_connections'];
        List<SocialMedia> personal_connection = [];
        if (accreditration_dynamic.length > 0) {
          accreditration_dynamic.forEach((element) {
            accreditation.add(element['image']);
          });
        }
        if (images_dynamic.length > 0) {
          images_dynamic.forEach((element) {
            images.add(element['image']);
          });
        }
        if (personal_connection_dynamic.length > 0) {
          personal_connection_dynamic.forEach((element) {
            personal_connection.add(SocialMedia(
                media: element['media'],
                url: element['url'],
              title: element['title'],
              profile_handle: element['profile_handle']
            ));
          });
        }
        if (business_connection_dynamic.length > 0) {
          business_connection_dynamic.forEach((element) {
            business_connection.add(SocialMedia(
                media: element['media'],
                url: element['url'],
              title: element['title'],
              profile_handle: element['profile_handle']
            ));
          });
        }
        Map qr=fetcheddata['qrcode'];
        createprofile.add(
            MyProfile(
                final_button: FinalButton(
                    title: fetcheddata['final_button_title'],
                    url: fetcheddata['final_button_url']
                ),
                personal_connection_title: fetcheddata['personal_connection_title'],
                businesss_connection_title: fetcheddata['businesss_connection_title'],
                // year: fetcheddata['year'],
                views: profileview,
                profile_image: fetcheddata['profile_image'],
                logo: fetcheddata['logo'],
                docid: element.id,
              qrcode: MyQrCode(docid: '', image: qr['image'],
                  golden_image:  qr['goldem_image'],
                  secondarycolor: qr['secondary_color'],
              backgroundcolor: qr['background_color']
              ),
                uid: fetcheddata['userid'],
                business_connection: business_connection,
                platforms: platforms,
                your_details: YourDetails(
                  bio: fetcheddata['your_details']['bio'],
                  name: fetcheddata['your_details']['name'],
                  paragraph: fetcheddata['your_details']['paragraph'],
                  intro_heading: fetcheddata['your_details']['intro_heading'],
                  contact_no: fetcheddata['your_details']['contact_no'],
                  location: fetcheddata['your_details']['location'],
                  title: fetcheddata['your_details']['title'],
                  email: fetcheddata['your_details']['email'],
                ),
                personal_connection: personal_connection,
                Accreditation: accreditation,
                business_details: BusinessDetails(
                    website: fetcheddata['business_details']['website'],
                    company_sector: fetcheddata['business_details']['company_sector'],
                    company_contact_no: fetcheddata['business_details']['company_contact_no'],
                    Business_name: fetcheddata['business_details']['Business_name']
                ),
                design_appearance: Design_Appearance(
                    TextColor:CustomColor(hexcode:  fetcheddata['design_appearance']['TextColor'],),
                    ButtonColor: CustomColor(hexcode: fetcheddata['design_appearance']['ButtonColor'],),
                    BackgroundTheme: CustomColor(hexcode: fetcheddata['design_appearance']['BackgroundTheme'],),
                    BorderColor: CustomColor(hexcode:  fetcheddata['design_appearance']['BorderColor'])
                ),
                Backgroundimage: fetcheddata['background_image'],
                images: images,
                video: fetcheddata['video'],
            ));
      });
    });
    return createprofile;
  }

  Future<List<MyProfile>> fetch_team_profiles_by_desired_id(
      {required String id}) async {
    List<MyProfile> ? createprofile = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print(element);
        Map<dynamic, dynamic> fetcheddata =
        element.data() as Map<dynamic, dynamic>;

        if (fetcheddata['userid'] == id) {
          Timestamp stamp = element['date'];

          List<dynamic> profileview_dynamic = fetcheddata['views'];
          List<ProfileView> profileview = [];
          if (profileview_dynamic.length > 0) {
            profileview_dynamic.forEach((e) {
              Timestamp stamp = e['date'];
              profileview.add(
                  ProfileView(
                      date: stamp.toDate(),
                      userid: e['userid']
                  )
              );
            });
          }

          List<dynamic> accreditration_dynamic = fetcheddata['accreditaion'];

          List<dynamic> business_connection_dynamic =

          fetcheddata['business_connection'] == null
              ? []
              : fetcheddata['business_connection'];
          List<SocialMedia> business_connection = [];
          List<String> accreditation = [];
          List<dynamic> images_dynamic = fetcheddata['images'];
          List<String> images = [];
          List<
              dynamic> personal_connection_dynamic = fetcheddata['personal_connections'];
          List<SocialMedia> personal_connection = [];
          if (accreditration_dynamic.length > 0) {
            accreditration_dynamic.forEach((element) {
              accreditation.add(element['image']);
            });
          }
          if (images_dynamic.length > 0) {
            images_dynamic.forEach((element) {
              images.add(element['image']);
            });
          }
          if (personal_connection_dynamic.length > 0) {
            personal_connection_dynamic.forEach((element) {
              personal_connection.add(SocialMedia(
                  media: element['media'],
                  url: element['url'],
                title: element['title'],
                profile_handle: element['profile_handle']
              ));
            });
          }
          if (business_connection_dynamic.length > 0) {
            business_connection_dynamic.forEach((element) {
              business_connection.add(SocialMedia(
                  media: element['media'],
                  url: element['url'],
                title: element['title'],
                profile_handle: element['profile_handle']
              ));
            });
          }
          List<String> platforms=[];
          List<dynamic> platformsdynamic=fetcheddata['platform'];
          if(platformsdynamic.length>0){
            platformsdynamic.forEach((plat) {
              platforms.add(plat);
            });
          }
          Map qr=fetcheddata['qrcode'];
          createprofile.add(
              MyProfile(
                final_button: FinalButton(
                    title: fetcheddata['final_button_title'],
                    url: fetcheddata['final_button_url']
                ),

                personal_connection_title: fetcheddata['personal_connection_title'],
                businesss_connection_title: fetcheddata['businesss_connection_title'],
                date: stamp.toDate(),
                views: profileview,
                profile_image: fetcheddata['profile_image'],
                logo: fetcheddata['logo'],
                docid: element.id,
                  qrcode: MyQrCode(docid: '', image: qr['image'], golden_image:  qr['goldem_image'], secondarycolor: qr['secondary_color'],
                      backgroundcolor: qr['background_color']
                  ),
                uid: fetcheddata['userid'],
                business_connection: business_connection,
                your_details: YourDetails(
                  bio: fetcheddata['your_details']['bio'],
                  name: fetcheddata['your_details']['name'],
                  paragraph: fetcheddata['your_details']['paragraph'],
                  intro_heading: fetcheddata['your_details']['intro_heading'],
                  contact_no: fetcheddata['your_details']['contact_no'],
                  location: fetcheddata['your_details']['location'],
                  title: fetcheddata['your_details']['title'],
                  email: fetcheddata['your_details']['email'],
                ),
                personal_connection: personal_connection,
                Accreditation: accreditation,
                business_details: BusinessDetails(
                    website: fetcheddata['business_details']['website'],
                    company_sector: fetcheddata['business_details']['company_sector'],
                    company_contact_no: fetcheddata['business_details']['company_contact_no'],
                    Business_name: fetcheddata['business_details']['Business_name']
                ),
                design_appearance: Design_Appearance(
                    TextColor: CustomColor(hexcode: fetcheddata['design_appearance']['TextColor']),
                    ButtonColor: CustomColor(hexcode: fetcheddata['design_appearance']['ButtonColor']),
                    BackgroundTheme: CustomColor(hexcode: fetcheddata['design_appearance']['BackgroundTheme']),
                    BorderColor:  CustomColor(hexcode: fetcheddata['design_appearance']['BorderColor'])
                ),
                Backgroundimage: fetcheddata['background_image'],
                images: images,
                video: fetcheddata['video'],
                platforms: platforms
              ));
        }
      });
    }).then((value) {
      createprofile.sort((a, b) =>a.date!.compareTo(b.date!));

    });
    return createprofile;
  }
  Future<MyProfile?> fetch_profile_by_docid({required String id}) async {
    MyProfile ? createprofile;
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print(element);
        Map<dynamic, dynamic> fetcheddata =
        element.data() as Map<dynamic, dynamic>;

        if (element.id == id) {

          List<dynamic> profileview_dynamic = fetcheddata['views'];
          List<ProfileView> profileview = [];
          if (profileview_dynamic.length > 0) {
            profileview_dynamic.forEach((e) {
              Timestamp stamp = e['date'];
              profileview.add(
                  ProfileView(
                      date: stamp.toDate(),
                      userid: e['userid']
                  )
              );
            });
          }

          List<dynamic> accreditration_dynamic = fetcheddata['accreditaion'];

          List<dynamic> business_connection_dynamic =

          fetcheddata['business_connection'] == null
              ? []
              : fetcheddata['business_connection'];
          List<SocialMedia> business_connection = [];
          List<String> accreditation = [];
          List<dynamic> images_dynamic = fetcheddata['images'];
          List<String> images = [];
          List<
              dynamic> personal_connection_dynamic = fetcheddata['personal_connections'];
          List<SocialMedia> personal_connection = [];
          if (accreditration_dynamic.length > 0) {
            accreditration_dynamic.forEach((element) {
              accreditation.add(element['image']);
            });
          }
          if (images_dynamic.length > 0) {
            images_dynamic.forEach((element) {
              images.add(element['image']);
            });
          }
          if (personal_connection_dynamic.length > 0) {
            personal_connection_dynamic.forEach((element) {
              personal_connection.add(SocialMedia(
                  media: element['media'],
                  url: element['url'],
                title: element['title'],
                profile_handle: element['profile_handle']
              ));
            });
          }
          if (business_connection_dynamic.length > 0) {
            business_connection_dynamic.forEach((element) {
              business_connection.add(SocialMedia(
                  media: element['media'],
                  url: element['url'],
                title: element['title'],
                profile_handle: element['profile_handle']
              ));
            });
          }
          List<String> platforms=[];
          List<dynamic> platformsdynamic=fetcheddata['platform'];
          if(platformsdynamic.length>0){
            platformsdynamic.forEach((plat) {
              platforms.add(plat);
            });
          }
          Map qr=fetcheddata['qrcode'];
          createprofile=
              MyProfile(
                  final_button: FinalButton(
                      title: fetcheddata['final_button_title'],
                      url: fetcheddata['final_button_url']
                  ),
                  personal_connection_title: fetcheddata['personal_connection_title'],
                  businesss_connection_title: fetcheddata['businesss_connection_title'],
                  // year: fetcheddata['year'],
                  views: profileview,
                  profile_image: fetcheddata['profile_image'],
                  logo: fetcheddata['logo'],
                  docid: element.id,
                  qrcode: MyQrCode(docid: '', image: qr['image'], golden_image:  qr['goldem_image'], secondarycolor: qr['secondary_color'],  backgroundcolor: qr['background_color']),
                  uid: fetcheddata['userid'],
                  business_connection: business_connection,
                  your_details: YourDetails(
                    bio: fetcheddata['your_details']['bio'],
                    name: fetcheddata['your_details']['name'],
                    paragraph: fetcheddata['your_details']['paragraph'],
                    intro_heading: fetcheddata['your_details']['intro_heading'],
                    contact_no: fetcheddata['your_details']['contact_no'],
                    location: fetcheddata['your_details']['location'],
                    title: fetcheddata['your_details']['title'],
                    email: fetcheddata['your_details']['email'],
                  ),
                  personal_connection: personal_connection,
                  Accreditation: accreditation,
                  business_details: BusinessDetails(
                      website: fetcheddata['business_details']['website'],
                      company_sector: fetcheddata['business_details']['company_sector'],
                      company_contact_no: fetcheddata['business_details']['company_contact_no'],
                      Business_name: fetcheddata['business_details']['Business_name']
                  ),
                  design_appearance: Design_Appearance(
                      TextColor: fetcheddata['design_appearance']['TextColor'],
                      ButtonColor: fetcheddata['design_appearance']['ButtonColor'],
                      BackgroundTheme: fetcheddata['design_appearance']['BackgroundTheme'],
                      BorderColor:  fetcheddata['design_appearance']['BorderColor']
                  ),
                  Backgroundimage: fetcheddata['background_image'],
                  images: images,
                  video: fetcheddata['video'],
                platforms: platforms
              );
        }
      });
    });
    return createprofile;
  }

  Future<MyProfile?> fetch_first_profile_userid({required String id}) async {
    MyProfile ? createprofile;
    List<MyProfile> myprofiles=[];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print(element);
        Map<dynamic, dynamic> fetcheddata =
        element.data() as Map<dynamic, dynamic>;

        if (fetcheddata['userid'] == id ) {

          List<dynamic> profileview_dynamic = fetcheddata['views'];
          List<ProfileView> profileview = [];
          if (profileview_dynamic.length > 0) {
            profileview_dynamic.forEach((e) {
              Timestamp stamp = e['date'];
              profileview.add(
                  ProfileView(
                      date: stamp.toDate(),
                      userid: e['userid']
                  )
              );
            });
          }

          List<dynamic> accreditration_dynamic = fetcheddata['accreditaion'];

          List<dynamic> business_connection_dynamic =

          fetcheddata['business_connection'] == null
              ? []
              : fetcheddata['business_connection'];
          List<SocialMedia> business_connection = [];
          List<String> accreditation = [];
          List<dynamic> images_dynamic = fetcheddata['images'];
          List<String> images = [];
          List<
              dynamic> personal_connection_dynamic = fetcheddata['personal_connections'];
          List<SocialMedia> personal_connection = [];
          if (accreditration_dynamic.length > 0) {
            accreditration_dynamic.forEach((element) {
              accreditation.add(element['image']);
            });
          }
          if (images_dynamic.length > 0) {
            images_dynamic.forEach((element) {
              images.add(element['image']);
            });
          }
          if (personal_connection_dynamic.length > 0) {
            personal_connection_dynamic.forEach((element) {
              personal_connection.add(SocialMedia(
                  media: element['media'],
                  url: element['url'],
                  title:element['title'],
                  profile_handle: element['profile_handle']
              ));
            });
          }
          if (business_connection_dynamic.length > 0) {
            business_connection_dynamic.forEach((element) {
              business_connection.add(SocialMedia(
                  media: element['media'],
                  url: element['url'],
                  title: element['title'],
                  profile_handle: element['profile_handle']
              ));
            });
          }
          List<String> platforms=[];
          List<dynamic> platformsdynamic=fetcheddata['platform'];
          if(platformsdynamic.length>0){
            platformsdynamic.forEach((plat) {
              platforms.add(plat);
            });
          }
          Map qr=fetcheddata['qrcode'];
          Timestamp stamp = fetcheddata['date'];
         myprofiles.add(
              MyProfile(
                date: stamp.toDate(),
                final_button: FinalButton(
                    title: fetcheddata['final_button_title'],
                    url: fetcheddata['final_button_url']
                ),
                personal_connection_title: fetcheddata['personal_connection_title'],
                businesss_connection_title: fetcheddata['businesss_connection_title'],
                // year: fetcheddata['year'],
                views: profileview,
                profile_image: fetcheddata['profile_image'],
                logo: fetcheddata['logo'],
                docid: element.id,
                qrcode: MyQrCode(docid: '', image: qr['image'],golden_image:  qr['goldem_image'],  secondarycolor: qr['secondary_color'],  backgroundcolor: qr['background_color']),
                uid: fetcheddata['userid'],
                business_connection: business_connection,
                your_details: YourDetails(
                  bio: fetcheddata['your_details']['bio'],
                  name: fetcheddata['your_details']['name'],
                  paragraph: fetcheddata['your_details']['paragraph'],
                  intro_heading: fetcheddata['your_details']['intro_heading'],
                  contact_no: fetcheddata['your_details']['contact_no'],
                  location: fetcheddata['your_details']['location'],
                  title: fetcheddata['your_details']['title'],
                  email: fetcheddata['your_details']['email'],
                ),
                personal_connection: personal_connection,
                Accreditation: accreditation,
                business_details: BusinessDetails(
                    website: fetcheddata['business_details']['website'],
                    company_sector: fetcheddata['business_details']['company_sector'],
                    company_contact_no: fetcheddata['business_details']['company_contact_no'],
                    Business_name: fetcheddata['business_details']['Business_name']
                ),
                design_appearance: Design_Appearance(
                    TextColor: CustomColor(hexcode: fetcheddata['design_appearance']['TextColor']),
                    ButtonColor: CustomColor(hexcode: fetcheddata['design_appearance']['ButtonColor']),
                    BackgroundTheme: CustomColor(hexcode: fetcheddata['design_appearance']['BackgroundTheme']),
                    BorderColor:  CustomColor(hexcode: fetcheddata['design_appearance']['BorderColor'])
                ),
                Backgroundimage: fetcheddata['background_image'],
                images: images,
                video: fetcheddata['video'],
                platforms: platforms,
              ));
        }
      });
    }).then((value) {
      if(myprofiles.length>0){
// Usage

        MyProfile oldestProfile = getOldestProfile(myprofiles);
      createprofile=oldestProfile;
      }
    });

    return createprofile;
  }

  MyProfile getOldestProfile(List<MyProfile> profiles) {
    return profiles.reduce((a, b) => a.date!.isBefore(b.date!) ? a : b);
  }
  Future<String?> delete_user_docid({User ? user,BuildContext ? context,
  bool ? googlesigned_in
  })async{
String ? result;
// Reference to the document you want to delete
    DocumentReference documentRef = FirebaseFirestore.instance.collection('Users').doc(currentuser!.docid);

// Delete the document
    documentRef.delete()
        .then((value) async {
      print('Document deleted successfully');
      result='success';

      if(googlesigned_in==true){
        final googleSignIn = GoogleSignIn();

        // Sign out the user from Google Sign-In
        await googleSignIn.signOut().then((value) {
          Navigator.of(context!).pushNamedAndRemoveUntil(Wrapper.routename, (route) => false );
        });
      }else{
        FirebaseAuth _auth=  FirebaseAuth.instance;
        await _auth.signOut().then((value) {


          Navigator.of(context!).pushNamedAndRemoveUntil(Wrapper.routename, (route) => false );
        });
      }



    })
        .catchError((error) {
      print('Failed to delete document: $error');
      result=error.toString();
    });
  return result;
  }
  Future _showErrorDialog(String msg,BuildContext context) async{
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
  Future deleteUserwith_password({required String ? password,
    required
    BuildContext?  context}) async {
    try {
      FirebaseAuth _auth=  FirebaseAuth.instance;

      AuthCredential credentials = EmailAuthProvider.credential(email: currentuser!.email!,
          password: password!);

      var  result = await _auth.currentUser!.reauthenticateWithCredential(credentials);
      await result.user!.delete().then((value) async {
        await delete_user_docid(
            user:
            result.user!,
            context:
            context!,
            googlesigned_in: false
        ).then((res) async{
          if(res!=null){
            if(res=='success'){

            }
            else{
              _showErrorDialog(res.toString(), context);
            }
          }
        });
      });


      return true;
    } catch (e) {
      print(e.toString());
      if(e.toString().contains('The password is invalid')){
        _showErrorDialog("The password is invalid", context!);
      }
      else{
        _showErrorDialog(e.toString(), context!);
      }

      return null;
    }
  }

  // Future<MyProfile?> fetch_profile_userid({required String id}) async {
  //   MyProfile ? createprofile;
  //   CollectionReference collection =
  //   FirebaseFirestore.instance.collection('Profile');
  //
  //   await collection.get().then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((element) {
  //       print(element);
  //       Map<dynamic, dynamic> fetcheddata =
  //       element.data() as Map<dynamic, dynamic>;
  //
  //       if (fetcheddata['userid'] == id ) {
  //
  //         List<dynamic> profileview_dynamic = fetcheddata['views'];
  //         List<ProfileView> profileview = [];
  //         if (profileview_dynamic.length > 0) {
  //           profileview_dynamic.forEach((e) {
  //             Timestamp stamp = e['date'];
  //             profileview.add(
  //                 ProfileView(
  //                     date: stamp.toDate(),
  //                     userid: e['userid']
  //                 )
  //             );
  //           });
  //         }
  //
  //         List<dynamic> accreditration_dynamic = fetcheddata['accreditaion'];
  //
  //         List<dynamic> business_connection_dynamic =
  //
  //         fetcheddata['business_connection'] == null
  //             ? []
  //             : fetcheddata['business_connection'];
  //         List<SocialMedia> business_connection = [];
  //         List<String> accreditation = [];
  //         List<dynamic> images_dynamic = fetcheddata['images'];
  //         List<String> images = [];
  //         List<
  //             dynamic> personal_connection_dynamic = fetcheddata['personal_connections'];
  //         List<SocialMedia> personal_connection = [];
  //         if (accreditration_dynamic.length > 0) {
  //           accreditration_dynamic.forEach((element) {
  //             accreditation.add(element['image']);
  //           });
  //         }
  //         if (images_dynamic.length > 0) {
  //           images_dynamic.forEach((element) {
  //             images.add(element['image']);
  //           });
  //         }
  //         if (personal_connection_dynamic.length > 0) {
  //           personal_connection_dynamic.forEach((element) {
  //             personal_connection.add(SocialMedia(
  //                 media: element['media'],
  //                 url: element['url'],
  //               title:element['title'],
  //               profile_handle: element['profile_handle']
  //             ));
  //           });
  //         }
  //         if (business_connection_dynamic.length > 0) {
  //           business_connection_dynamic.forEach((element) {
  //             business_connection.add(SocialMedia(
  //                 media: element['media'],
  //                 url: element['url'],
  //               title: element['title'],
  //               profile_handle: element['profile_handle']
  //             ));
  //           });
  //         }
  //         List<String> platforms=[];
  //         List<dynamic> platformsdynamic=fetcheddata['platform'];
  //         if(platformsdynamic.length>0){
  //           platformsdynamic.forEach((plat) {
  //             platforms.add(plat);
  //           });
  //         }
  //         Map qr=fetcheddata['qrcode'];
  //         Timestamp stamp = fetcheddata['date'];
  //         createprofile=
  //             MyProfile(
  //               date: stamp.toDate(),
  //                 final_button: FinalButton(
  //                     title: fetcheddata['final_button_title'],
  //                     url: fetcheddata['final_button_url']
  //                 ),
  //                 personal_connection_title: fetcheddata['personal_connection_title'],
  //                 businesss_connection_title: fetcheddata['businesss_connection_title'],
  //                 // year: fetcheddata['year'],
  //                 views: profileview,
  //                 profile_image: fetcheddata['profile_image'],
  //                 logo: fetcheddata['logo'],
  //                 docid: element.id,
  //                 qrcode: MyQrCode(docid: '', image: qr['image'],golden_image:  qr['goldem_image'],  secondarycolor: qr['secondary_color'],  backgroundcolor: qr['background_color']),
  //                 uid: fetcheddata['userid'],
  //                 business_connection: business_connection,
  //                 your_details: YourDetails(
  //                   bio: fetcheddata['your_details']['bio'],
  //                   name: fetcheddata['your_details']['name'],
  //                   paragraph: fetcheddata['your_details']['paragraph'],
  //                   intro_heading: fetcheddata['your_details']['intro_heading'],
  //                   contact_no: fetcheddata['your_details']['contact_no'],
  //                   location: fetcheddata['your_details']['location'],
  //                   title: fetcheddata['your_details']['title'],
  //                   email: fetcheddata['your_details']['email'],
  //                 ),
  //                 personal_connection: personal_connection,
  //                 Accreditation: accreditation,
  //                 business_details: BusinessDetails(
  //                     website: fetcheddata['business_details']['website'],
  //                     company_sector: fetcheddata['business_details']['company_sector'],
  //                     company_contact_no: fetcheddata['business_details']['company_contact_no'],
  //                     Business_name: fetcheddata['business_details']['Business_name']
  //                 ),
  //                 design_appearance: Design_Appearance(
  //                     TextColor: CustomColor(hexcode: fetcheddata['design_appearance']['TextColor']),
  //                     ButtonColor: CustomColor(hexcode: fetcheddata['design_appearance']['ButtonColor']),
  //                     BackgroundTheme: CustomColor(hexcode: fetcheddata['design_appearance']['BackgroundTheme']),
  //                     BorderColor:  CustomColor(hexcode: fetcheddata['design_appearance']['BorderColor'])
  //                 ),
  //                 Backgroundimage: fetcheddata['background_image'],
  //                 images: images,
  //                 video: fetcheddata['video'],
  //               platforms: platforms,
  //             );
  //       }
  //     });
  //   });
  //   return createprofile;
  // }

  Future<List<String>> fetch_total_profile_by_userid({required String id}) async {
    List<String> ? totalprofiles=[];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print(element);
        Map<dynamic, dynamic> fetcheddata =
        element.data() as Map<dynamic, dynamic>;

        if (fetcheddata['userid'] == id) {
          totalprofiles.add(fetcheddata['userid']);
        }
      }
      );
    }
    );
    return totalprofiles;
  }

  Future<List<MyUser?>> fetch_all_profile() async {
    List<MyUser> all_profiles = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print(element);
        Map<dynamic, dynamic> fetcheddata =
        element.data() as Map<dynamic, dynamic>;


        all_profiles.add(MyUser(
            imageurl: fetcheddata['imageurl'],
            year: fetcheddata['year'],
            docid: element.id,
            username: fetcheddata['username'],
            uid: fetcheddata['userid'],
            qr_image: fetcheddata['QR_image'],
            email: fetcheddata['email'],
            created_profile: fetcheddata['created_profile'],
          payment: fetcheddata['payment']

        ));
      });
    });
    return all_profiles;
  }

  Future<List<MyCard?>> fetch_all_cards() async {
    List<MyCard> all_cards = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Cards');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print(element);
        Map<dynamic, dynamic> fetcheddata =
        element.data() as Map<dynamic, dynamic>;


        if (fetcheddata['userid'] == currentuser!.uid) {
          all_cards.add(MyCard(
              card_image: fetcheddata['card_image'],
              userid: fetcheddata['userid'],
              docid: element.id,
              card_type: fetcheddata['card_type'],
              connected_profile_uid: fetcheddata['connected_profile_uid'],
              connected_profile_username: fetcheddata['connected_profile_username']
          ));
        }
      });
    });
    return all_cards;
  }

  Future<List<MyProfile>> fetch_team_profile({required String id}) async {
    List<MyProfile> createprofile = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('TeamProfile');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print(element);
        Map<dynamic, dynamic> fetcheddata =
        element.data() as Map<dynamic, dynamic>;

        if (fetcheddata['userid'] == id) {
          List<dynamic> accreditration_dynamic = fetcheddata['accreditaion'];

          List<dynamic> business_connection_dynamic =

          fetcheddata['business_connection'] == null
              ? []
              : fetcheddata['business_connection'];
          List<SocialMedia> business_connection = [];
          List<String> accreditation = [];
          List<dynamic> images_dynamic = fetcheddata['images'];
          List<String> images = [];
          List<
              dynamic> personal_connection_dynamic = fetcheddata['personal_connections'];
          List<SocialMedia> personal_connection = [];
          if (accreditration_dynamic.length > 0) {
            accreditration_dynamic.forEach((element) {
              accreditation.add(element['image']);
            });
          }
          if (images_dynamic.length > 0) {
            images_dynamic.forEach((element) {
              images.add(element['image']);
            });
          }
          if (personal_connection_dynamic.length > 0) {
            personal_connection_dynamic.forEach((element) {
              personal_connection.add(element['social_media']);
            });
          }
          if (business_connection_dynamic.length > 0) {
            business_connection_dynamic.forEach((element) {
              business_connection.add(element['social_media']);
            });
          }
          Map qr=fetcheddata['qrcode'];
          createprofile.add(
              MyProfile(
                  final_button: FinalButton(
                      title: fetcheddata['final_button_title'],
                      url: fetcheddata['final_button_url']
                  ),

                  personal_connection_title: fetcheddata['personal_connection_title'],
                  businesss_connection_title: fetcheddata['businesss_connection_title'],
                  profile_image: fetcheddata['profile_image'],
                  logo: fetcheddata['logo'],
                  docid: element.id,
                  qrcode: MyQrCode(docid: '', image: qr['image'],golden_image:  qr['goldem_image'],  secondarycolor: qr['secondary_color'],  backgroundcolor: qr['background_color']),
                  business_connection: business_connection,
                  your_details: YourDetails(
                    bio: fetcheddata['your_details']['bio'],
                    name: fetcheddata['your_details']['name'],
                    paragraph: fetcheddata['your_details']['paragraph'],
                    intro_heading: fetcheddata['your_details']['intro_heading'],
                    contact_no: fetcheddata['your_details']['contact_no'],
                    location: fetcheddata['your_details']['location'],
                    title: fetcheddata['your_details']['title'],
                    email: fetcheddata['your_details']['email'],
                  ),
                  personal_connection: personal_connection,
                  Accreditation: accreditation,
                  business_details: BusinessDetails(
                      website: fetcheddata['business_details']['website'],
                      company_sector: fetcheddata['business_details']['company_sector'],
                      company_contact_no: fetcheddata['business_details']['company_contact_no'],
                      Business_name: fetcheddata['business_details']['Business_name']
                  ),
                  design_appearance: Design_Appearance(
                      TextColor: CustomColor(hexcode: fetcheddata['design_appearance']['TextColor']),
                      ButtonColor: CustomColor(hexcode: fetcheddata['design_appearance']['ButtonColor']),
                      BackgroundTheme: CustomColor(hexcode: fetcheddata['design_appearance']['BackgroundTheme']),
                      BorderColor:  CustomColor(hexcode: fetcheddata['design_appearance']['BorderColor'])
                  ),
                  Backgroundimage: fetcheddata['background_image'],
                  images: images,
                  video: fetcheddata['video']
              ));
        }
      });
    });
    return createprofile;
  }

  Future<bool?> finduserByEmail({String? email}) async {
    bool found = false;

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;
        if (fetcheddata['email'] == email) {
          print("found matched");
          found = true;
        }
      });
    }).then((value) {});

    return found;
  }
  Future update_profile_platform({required String ?  profiledoc,required List<String> platforms }) async {

    String platform='';
    if (Platform.isAndroid) {
      // Android-specific code
      platform="android";
    } else if (Platform.isIOS) {
      // iOS-specific code
      platform="ios";
    }
    else{
      platform="windows";
    }
    platforms.add(platform);

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');
    await collection.doc(profiledoc).update({
      'platform': platforms
    });
  }
  Future<String> adduser(
      {String ? userid, String? email, String ? imageurl}) async {

    Map<String, dynamic> data = {
      'username': '',
      'email': email,
      'payment':true,
      'year':true,
      'userid': userid,
      'QR_image': 'https://firebasestorage.googleapis.com/v0/b/saintconnect-9c0c9.appspot.com/o/nav_icons%2FWhatsApp%20Image%202023-05-16%20at%202.29.10%20PM.jpeg?alt=media&token=59706c66-f1f3-4a81-8e5e-486788918f27',
      'imageurl': imageurl,
      'profile_created': false,
      'date': DateTime.now(),
      'platform':''
    };
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result = await collection.add(data);
    return result.id;
  }


  Future<String? > add_profile(MyProfile ? createdprofile) async {

    String profile_docid='';

    Map<String, dynamic> data = {
      'personal_connection_title':createdprofile!.personal_connection_title,
      'businesss_connection_title':createdprofile.businesss_connection_title,
      'final_button_title':createdprofile.final_button!.title,
      'final_button_url':createdprofile.final_button!.url,
      'userid': currentuser!.uid,
      'profile_image': createdprofile.profile_image,
      'logo': createdprofile.logo,
      'your_details': {
        'bio':createdprofile.your_details!.bio,
        'name': createdprofile.your_details!.name,
        'email': createdprofile.your_details!.email,
        'contact_no': createdprofile.your_details!.contact_no,
        'location': createdprofile.your_details!.location,
        'title': createdprofile.your_details!.title,
        'intro_heading': createdprofile.your_details!.intro_heading,
        'paragraph': createdprofile.your_details!.paragraph,

      },
      'personal_connections': createdprofile.personal_connection!.map((e) =>
      {
        'media': e.media,
        'url': e.title=="WhatsApp"?"https://api.whatsapp.com/send?phone=${e.url}": e.url,
        'title':e.title,
        'profile_handle':e.profile_handle
      }).toList(),
      'business_connection': createdprofile.business_connection!.map((e) =>
      {
        'media': e.media,
        'url': e.title=="WhatsApp"?"https://api.whatsapp.com/send?phone=${e.url}": e.url,
        'title':e.title,
        'profile_handle':e.profile_handle
      }).toList(),
      'accreditaion': createdprofile.Accreditation!.map((e) =>
      {
        'image': e
      }).toList(),
      'business_details': {
        'Business_name': createdprofile.business_details!.Business_name,
        'company_sector': createdprofile.business_details!.company_sector,
        'website': createdprofile.business_details!.website,
        'company_contact_no': createdprofile.business_details!
            .company_contact_no,
      },
      'design_appearance': {
        'BackgroundTheme': createdprofile.design_appearance!.BackgroundTheme!.hexcode,
        'TextColor': createdprofile.design_appearance!.TextColor!.hexcode,
        'ButtonColor': createdprofile.design_appearance!.ButtonColor!.hexcode,
        'BorderColor': createdprofile.design_appearance!.BorderColor!.hexcode,
      },
      'background_image': createdprofile.Backgroundimage,
      'images': createdprofile.images!.map((e) =>
      {
        'image': e
      }).toList(),
      'video': createdprofile.video,
      'qrcode': {
        'image':createdprofile.qrcode,
        'golden_image':createdprofile.qrcode,
        'secondary_color':createdprofile.design_appearance!.BorderColor!.hexcode,
        'goldencolor':'0xffDAC07A',
        'background_color':createdprofile.design_appearance!.BackgroundTheme!.hexcode
      },
      'views': [],
      'visit_time': [],
      'date': DateTime.now(),
      'vcf_url':createdprofile.vcf_url,
      'platform':[],
      'expiry_date':createdprofile.ExpirayDate,
      'payment':createdprofile.payment
    };
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');
    final reslult = await collection.add(data);
    profile_docid=reslult.id;
    return profile_docid;
  }

  Future update_card(
      {required String docid, String ? connected_profile_username, String ? connected_profile_uid}) async {
    Map<String, dynamic> data = {
      "connected_profile_uid": connected_profile_uid,
      "connected_profile_username": connected_profile_username
    };
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Cards');
    await collection.doc(docid).update(data);
  }
  Future update_profile_qrcode(
      {required MyQrCode mycode}) async {

    Map<String, dynamic> data = {

      'qrcode': {
        'goldem_image':mycode.golden_image,
          'image':mycode.image,
          'secondary_color':mycode.secondarycolor,
          'goldencolor':'0xffDAC07A',
        'background_color':mycode.backgroundcolor

      },


    };
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');
    await collection.doc(mycode.docid).update(data);
  }

  Future update_profile_golden_qrcode(
      {required goldenimageurl, required String docid}) async {

    Map<String, dynamic> data = {

      'qrcode': {
        'golden':goldenimageurl,

      },


    };
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');
    await collection.doc(docid).update(data);
  }


  Future update_profile_vcf(
      {required vcfurl, required String docid}) async {

    Map<String, dynamic> data = {

      'vcf_url': vcfurl


    };
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');
    await collection.doc(docid).update(data);
  }


  Future update_profile(
      {required MyProfile ? createdprofile, required String docid}) async {

    Map<String, dynamic> data = {
      'personal_connection_title':createdprofile!.personal_connection_title,
      'businesss_connection_title':createdprofile.businesss_connection_title,
      'final_button_title':createdprofile.final_button!.title,
      'final_button_url':createdprofile.final_button!.url,
      'profile_image': createdprofile.profile_image,
      'logo': createdprofile.logo,
      'your_details': {
        'bio':createdprofile.your_details!.bio,
        'name': createdprofile.your_details!.name,
        'email': createdprofile.your_details!.email,
        'contact_no': createdprofile.your_details!.contact_no,
        'location': createdprofile.your_details!.location,
        'title': createdprofile.your_details!.title,
        'intro_heading': createdprofile.your_details!.intro_heading,
        'paragraph': createdprofile.your_details!.paragraph,

      },
      'personal_connections': createdprofile.personal_connection!.map((e) =>
      {
        'media': e.media,
        'url': e.title=="WhatsApp"?"https://api.whatsapp.com/send?phone=${e.url}": e.url,
        'title':e.title,
        'profile_handle':e.profile_handle
      }).toList(),
      'business_connection': createdprofile.business_connection!.map((e) =>
      {
        'media': e.media,
        'url': e.title=="WhatsApp"?"https://api.whatsapp.com/send?phone=${e.url}": e.url,
        'title':e.title,
        'profile_handle':e.profile_handle
      }).toList(),
      'accreditaion': createdprofile.Accreditation!.map((e) =>
      {
        'image': e
      }).toList(),
      'business_details': {
        'Business_name': createdprofile.business_details!.Business_name,
        'company_sector': createdprofile.business_details!.company_sector,
        'website': createdprofile.business_details!.website,
        'company_contact_no': createdprofile.business_details!
            .company_contact_no,
      },
      'design_appearance': {
        'BackgroundTheme': createdprofile.design_appearance!.BackgroundTheme!.hexcode.toString(),
        'TextColor': createdprofile.design_appearance!.TextColor!.hexcode.toString(),
        'ButtonColor': createdprofile.design_appearance!.ButtonColor!.hexcode.toString(),
        'BorderColor': createdprofile.design_appearance!.BorderColor!.hexcode.toString(),
      },
      'background_image': createdprofile.Backgroundimage,
      'images': createdprofile.images!.map((e) =>
      {
        'image': e
      }).toList(),
      'video': createdprofile.video,
'vcf_url':createdprofile.vcf_url.toString(),
      'platform':createdprofile.platforms

    };
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');
    await collection.doc(docid).update(data);
  }

  Future update_team(
      {required MyProfile ? createdprofile, required String docid}) async {
    Map<String, dynamic> data = {
      'userid': currentuser!.uid,
      'profile_image': createdprofile!.profile_image,
      'logo': createdprofile.logo,
      'your_details': {
        'name': createdprofile.your_details!.name,
        'email': createdprofile.your_details!.email,
        'contact_no': createdprofile.your_details!.contact_no,
        'location': createdprofile.your_details!.location,
        'title': createdprofile.your_details!.title,
        'intro_heading': createdprofile.your_details!.intro_heading,
        'paragraph': createdprofile.your_details!.paragraph,

      },
      'personal_connections': createdprofile.personal_connection!.map((e) =>
      {
        'social_media': e
      }).toList(),
      'business_connection': createdprofile.business_connection!.map((e) =>
      {
        'social_media': e
      }).toList(),
      'accreditaion': createdprofile.Accreditation!.map((e) =>
      {
        'image': e
      }).toList(),
      'business_details': {
        'Business_name': createdprofile.business_details!.Business_name,
        'company_sector': createdprofile.business_details!.company_sector,
        'website': createdprofile.business_details!.website,
        'company_contact_no': createdprofile.business_details!
            .company_contact_no,
      },
      'design_appearance': {
        'BackgroundTheme': createdprofile.design_appearance!.BackgroundTheme!.hexcode.toString(),
        'TextColor': createdprofile.design_appearance!.TextColor!.hexcode.toString(),
        'ButtonColor': createdprofile.design_appearance!.ButtonColor!.hexcode.toString(),
      },
      'background_image': createdprofile.Backgroundimage,
      'images': createdprofile.images!.map((e) =>
      {
        'image': e
      }).toList(),
      'video': createdprofile.video,
      'qrcode': {

        'image':createdprofile.qrcode!.image,
        'secondary_color':createdprofile.qrcode!.secondarycolor,
        'goldencolor':'0xffDAC07A'

      },
    };
    CollectionReference collection =
    FirebaseFirestore.instance.collection('TeamProfile');
    await collection.doc(docid).update(data);
  }




  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  String ? goldenQRImage = '';
  Widget Qrimage({required BuildContext context,required Color?  qrcolor,
    required Color ?  backgdcolor,
    required String? profiledocumentid}){
    return Screenshot(
      controller: screenshotController,
      child: Container(
        height: MediaQuery.of(context).size.height*0.25,
        width: MediaQuery.of(context).size.width*0.5,
        child: QrImageView(
          foregroundColor: qrcolor,
          backgroundColor: backgdcolor!,
          data: "https://www.saintconnect.info/profile?uid=${profiledocumentid}",
          version: QrVersions.auto,
          size: MediaQuery.of(context).size.height*0.25,
          gapless: false,
        ),
      ),
    );
  }
  Widget DefaultQrimage({required BuildContext context}){
    return Screenshot(
      controller: screenshotController,
      child: Container(
        height: MediaQuery.of(context).size.height*0.25,
        width: MediaQuery.of(context).size.width*0.5,
        child: QrImageView(
          foregroundColor: goldencolor,
          data: "https://www.saintconnect.info",
          version: QrVersions.auto,
          size: MediaQuery.of(context).size.height*0.25,
          gapless: false,
        ),
      ),
    );
  }

  Future<File?> GenerateDefaultQRCode({required BuildContext context}) async {
    File ? myfile;
    final Uint8List ? image = await screenshotController.captureFromWidget(
        DefaultQrimage(context: context,


        ));




    if (image != null) {
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/$user_id.jpg').create();
      file.writeAsBytesSync(image);
      myfile = file;

    }
  return myfile;
  }


  Future<File?> GenerateQRCode({required String ? documentid,required BuildContext context,required Color ? qrcolor,
    required Color ? backgroundgcolor}) async {
    File ? myfile;
    final Uint8List ? image = await screenshotController.captureFromWidget(
        Qrimage(context: context,
          qrcolor: qrcolor,
          profiledocumentid: documentid,
          backgdcolor: backgroundgcolor
        ));



    if (image != null) {
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/${DateTime.now().toString()}.jpg').create();
      file.writeAsBytesSync(image);
      myfile = file;

      // await uploadQR(docid: documentid);
    }
    return myfile;
  }
  Future<File?> GenerateGoldenQRCode({required String ? documentid,required BuildContext context}) async {
    File ? myfile2;
    final Uint8List ? image = await screenshotController.captureFromWidget(
        Screenshot(
          controller: screenshotController,
          child: Container(
            height: MediaQuery.of(context).size.height*0.25,
            width: MediaQuery.of(context).size.width*0.5,
            child: QrImageView(
              foregroundColor: goldencolor,
              data: "https://www.saintconnect.info/profile?uid=${documentid}",
              version: QrVersions.auto,
              size: MediaQuery.of(context).size.height*0.25,
              gapless: false,
            ),
          ),
        )
    );



    if (image != null) {
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/${DateTime.now().toString()}.jpg').create();
      file.writeAsBytesSync(image);
      myfile2 = file;

      // await uploadQR(docid: documentid);
    }
    return myfile2;
  }

  CollectionReference ? imgRef;

  firebase_storage.Reference ? ref;

  Future uploadQR({required String ? docid,required File ? myfile}) async {
    try {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('QRCode/${Path.basename(myfile!.path)}');
      await ref!.putFile(myfile).whenComplete(() async {
        await ref!.getDownloadURL().then((img) async {

          await database.updateqrcode(img.toString(), docid.toString())
              .then((value) {

          });
        });
      });
    }
    catch (error) {

    }
  }
  Future<String?> uploadprofileQR({required MyQrCode ? mycode,required File ? myfile}) async {
String ? uploaded_image;
    try {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('QRCode/${Path.basename(myfile!.path)}');
      await ref!.putFile(myfile).whenComplete(() async {
        await ref!.getDownloadURL().then((img) async {
       uploaded_image=img;

          // mycode!.image=QRImage;
          // await database.update_profile_qrcode(mycode: mycode)
          //     .then((value) {
          //
          // });

        });
      });
    }
    catch (error) {

    }
return uploaded_image;
  }
  Future<String?> uploadGoldenprofileQR({required MyQrCode ? mycode,required File ? myfile}) async {
    String ? uploaded_image;
    try {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('GoldenQRCode/${Path.basename(myfile!.path)}');
      await ref!.putFile(myfile).whenComplete(() async {
        await ref!.getDownloadURL().then((img) async {
          uploaded_image=img;


        });
      });
    }
    catch (error) {

    }
    return uploaded_image;
  }


  Future  upload_updateprofileQR({required MyProfile ? desiredprofile,required File ? myfile}) async {
    try {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('QRCode/${Path.basename(myfile!.path)}');
      await ref!.putFile(myfile).whenComplete(() async {
        await ref!.getDownloadURL().then((img) async {

          desiredprofile!.qrcode!.image=img;
          await database.update_profile(createdprofile: desiredprofile,
          docid: desiredprofile.docid!
          )
              .then((value) {

          });
        });
      });
    }
    catch (error) {

    }
  }



  Future update_user_payment({bool ? status,bool ? profile_created,bool ? year}) async {
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    await collection.doc(currentuser!.docid).update({
      'payment': status,
      if(year!=null)
        'year':year,
      if(profile_created!=null)
        'profile_created': true
    });
  }



  // }
  // Future updateser() async {
  //   CollectionReference collection =
  //   FirebaseFirestore.instance.collection('Users');
  //   await collection.doc(currentuser!.docid).update({
  //     'profile_created': true
  //   });
  // }


  Future update_email(String newEmail) async {
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    await collection.doc(currentuser!.docid).update({
      'email': newEmail
    });
  }



  //QrCode
  Future updateqrcode(String url, String doc) async {
    Map<String, dynamic> data = {
      'QR_image': url,
    };

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    collection.doc(doc).update(data);
  }


  //QrCode
  Future update_payment({required String ? profiledocid, DateTime ? expirydate}) async {
    Map<String, dynamic> data = {
      'payment': true,
      'expiry_date': expirydate
    };

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Profile');
    await collection.doc(profiledocid).update(data);
  }

  Future signInWithFacebook(BuildContext context) async {

      final LoginResult result = await FacebookAuth.instance.login(
          permissions: (['email', 'public_profile']));
      print("result is "+result.message .toString());
      final token = result.accessToken!.token;
      print(
          'Facebook token userID : ${result.accessToken!.grantedPermissions}');
      final graphResponse = await http.get(
          Uri.parse('https://graph.facebook.com/'
              'v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));

      final profile = jsonDecode(graphResponse.body);

      print("Profile is equal to $profile");
      try {

        final AuthCredential facebookCredential = FacebookAuthProvider.credential(result.accessToken!.token);

        final userCredential = await FirebaseAuth.instance.signInWithCredential(facebookCredential);

        Database _database = Database();

        bool ? data = await _database.finduserByEmail(email: userCredential.user!.email);

        if (data!) {
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

          await database.adduser(
              userid:
              userCredential.user!.uid,
              imageurl:  userCredential.user!.photoURL,
              email:  userCredential.user!.email!,

          ).then((value) async {


            await GenerateDefaultQRCode(context: context,
            ).then((value) async {
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
      } catch (e) {
        final snackBar = SnackBar(
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString()),
          backgroundColor: (Colors.redAccent),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

  }


}

Database database=Database();
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:saintconnect/Screens/ActivateDevice.dart';
import 'package:saintconnect/Screens/CreateAccount.dart';
import 'package:saintconnect/Screens/CreateProfile.dart';
import 'package:saintconnect/Screens/HomePage.dart';
import 'package:saintconnect/Screens/Insight.dart';
import 'package:saintconnect/Screens/MyCardStage2.dart';
import 'package:saintconnect/Screens/MyCardStage3.dart';
import 'package:saintconnect/Screens/MyCard_1.dart';
import 'package:saintconnect/Screens/MyTeam.dart';
import 'package:saintconnect/Screens/MyTeamNewProfile.dart';
import 'package:saintconnect/Screens/Newpassword.dart';
import 'package:saintconnect/Screens/Profile.dart';
import 'package:saintconnect/Screens/CardCreationSuccess.dart';
import 'package:saintconnect/Screens/PurchaseNewDevice.dart';
import 'package:saintconnect/Screens/QrCode.dart';
import 'package:saintconnect/Screens/Register.dart';
import 'package:saintconnect/Screens/ShareDetails.dart';

import 'package:saintconnect/Screens/change_email.dart';
import 'package:saintconnect/Screens/edit_profile.dart';
import 'package:saintconnect/Screens/forget_password/enter_email.dart';
import 'package:saintconnect/Screens/nfcscreen.dart';
import 'package:saintconnect/Screens/profile_created.dart';
import 'package:saintconnect/Screens/setting.dart';
import 'package:saintconnect/Screens/splash.dart';
import 'package:saintconnect/Screens/update_nfc.dart';
import 'package:saintconnect/Screens/uploadCardDesign.dart';
import 'package:saintconnect/Screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:saintconnect/auth/auth.dart';
import 'package:saintconnect/widgets/wrapper.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:saintconnect/Screens/webview.dart';

void main() async {


  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initilization();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);


  await Firebase.initializeApp();
  Stripe.publishableKey = 'pk_test_51K1GtiD5z0PA4b4fVeiLsLZeybhP8WNeFOf4If4PMWgTDVhAlHR3C1h2i9IeVRl0yWjUDmrccpgR3Is3qjKYNcG700YBFcIehs';

  await Stripe.instance.applySettings();

  runApp(const MyApp());

}

Future initilization()async{
  await  Future.delayed(Duration(seconds: 3));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    return  MultiProvider(

        providers: [

        Provider<AuthService>(create: (_)=>AuthService()),

        ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
      routes: {
        'update_NFC':(context)=>update_NFC(),
        'ProfileCreated':(context)=>ProfileCreated(),
        'NFC_Screen':(context)=>NFC_Screen(),
        'Wrapper':(context)=>Wrapper(),
        'CreateAccount':(context)=>CreateAccount(),
        'ActivateDevice':(context)=>ActivateDevice(),
        'Createprofile':(context)=>Createprofile(),
        'HomeScreen':(context)=>HomeScreen(),
        'Insights':(context)=>Insights(),
        'MyCardStage2':(context)=>MyCardStage2(),
        'MyCardStage3':(context)=>MyCardStage3(),
        'MyTeam':(context)=>MyTeam(),
        'MyTeamNewProfile':(context)=>MyTeamNewProfile(),
        'Profile':(context)=>Profile(),
        'CardCreationSuccesScreen':(context)=>CardCreationSuccesScreen(),
        'PurchaseNewDevice':(context)=>PurchaseNewDevice(),
        'QrCode':(context)=>QrCode(),
        'Setting':(context)=>Setting(),
        // 'Edit_Team':(context)=>Edit_Team(),
        'ChangeEmail':(context)=>ChangeEmail(),
        'NewPassword':(context)=>NewPassword(),
        'ShareDetails':(context)=>ShareDetails(),
        'SplashScreen':(context)=>SplashScreen(),

        'UploadCardDesign':(context)=>UploadCardDesign(),
        'Welcome':(context)=>Welcome(),
        'ActivateDevice':(context)=>ActivateDevice(),
        'ActivateDevice':(context)=>ActivateDevice(),
        'RegisterScreen':(context)=>RegisterScreen()

      },
    )
    );

  }

}

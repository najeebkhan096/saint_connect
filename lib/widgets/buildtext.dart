import 'package:flutter/material.dart';


class BuildText extends StatelessWidget {

  final String ? txt;
  final double ? fontsize;

  BuildText({required this.txt,required this.fontsize});


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return       Text(txt!,
      style: TextStyle(
          color: Color(0xffDAC07A),
          fontFamily: 'corporate_s_regular',
          fontSize: height*(fontsize!),

      ),
    );
  }
}

class BuildDTextDemiItalic extends StatelessWidget {

  final String ? txt;
  final double ? fontsize;

  BuildDTextDemiItalic({required this.txt,required this.fontsize});


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return       Text(txt!,
      style: TextStyle(
        color: Color(0xffDAC07A),
        fontFamily: 'CorporateA Demi Italic',
        fontSize: height*(fontsize!),

      ),
    );
  }
}

class BuildItalicText extends StatelessWidget {

  final String ? txt;
  final double ? fontsize;

  BuildItalicText({required this.txt,required this.fontsize});


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return       Text(txt!,
      style: TextStyle(
        color: Color(0xffDAC07A),
        fontFamily: 'CorporateA-BoldItalic',
        fontSize:height* fontsize!,
        fontWeight: FontWeight.bold

      ),
    );
  }
}


class BuildItalicTextwhite extends StatelessWidget {

  final String ? txt;
  final double ? fontsize;

  BuildItalicTextwhite({required this.txt,required this.fontsize});


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return       Text(txt!,
      style: TextStyle(
          color: Colors.white,
          fontFamily: 'CorporateA-BoldItalic',
          fontSize:height* fontsize!,
          fontWeight: FontWeight.bold

      ),
    );
  }
}

class BuildWhiteText extends StatelessWidget {

  final String ? txt;
  final double ? fontsize;
  final bool ?center;

  BuildWhiteText({required this.txt,required this.fontsize,this.center});


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return       Text(txt!,
      textAlign:
      (center!=null && center==true)?
          TextAlign.center:
      TextAlign.start,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'corporate_s_regular',
        fontSize: height*(fontsize!),

      ),
    );
  }
}
class BuildWhiteMuiliText extends StatelessWidget {

  final String ? txt;
  final double ? fontsize;

  BuildWhiteMuiliText({required this.txt,required this.fontsize});


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return       Text(txt!,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Muli-Regular',
        fontSize: height*(fontsize!),

      ),
    );
  }
}
class BuildBlackMuiliText extends StatelessWidget {

  final String ? txt;
  final double ? fontsize;

  BuildBlackMuiliText({required this.txt,required this.fontsize});


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return       Text(txt!,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Color(0xff000000),
        fontFamily: 'Muli-Regular',
        fontSize: height*(fontsize!),
        fontWeight: FontWeight.bold

      ),
    );
  }
}

class BuildMuliGrey extends StatelessWidget {

  final String ? txt;
  final double ? fontsize;

  BuildMuliGrey({required this.txt,required this.fontsize});


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return       Text(txt!,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Color(0xff757575),
        fontFamily: 'Muli-Regular',
        fontSize: height*(fontsize!),

      ),
    );
  }
}
class BuildMuliGreyBold extends StatelessWidget {

  final String ? txt;
  final double ? fontsize;

  BuildMuliGreyBold({required this.txt,required this.fontsize});


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return       Text(txt!,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Color(0xff757575),
        fontFamily: 'Muli-Regular',
        fontWeight: FontWeight.bold,
        fontSize: height*(fontsize!),

      ),
    );
  }
}
class BuildWhiteMuiliTextBold_shadow_more extends StatelessWidget {

  final String ? txt;
  final double ? fontsize;
  final bool ? start;

  BuildWhiteMuiliTextBold_shadow_more({required this.txt,required this.fontsize,this.start});


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return       Text(txt!,
      textAlign:
      (start!=null && start==true)?
      TextAlign.start
          :
      TextAlign.center,
      style: TextStyle(
          color: Colors.white,
          fontFamily: 'Muli-Regular',
          fontSize: height*(fontsize!),
          //21 heigt 0.027

          fontWeight: FontWeight.w700
      ),
    );
  }
}
class BuildWhiteMuiliTextBold_shadow extends StatelessWidget {

  final String ? txt;
  final double ? fontsize;
  final bool ? start;

  BuildWhiteMuiliTextBold_shadow({required this.txt,required this.fontsize,this.start});


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return       Text(txt!,
      textAlign:
      (start!=null && start==true)?
      TextAlign.start
          :
      TextAlign.center,
      style: TextStyle(
          color: Colors.white,
          fontFamily: 'Muli-Regular',
          fontSize: height*(fontsize!),
          //21 heigt 0.027

          fontWeight: FontWeight.w700
      ),
    );
  }
}
class BuildWhiteMuiliTextBold extends StatelessWidget {

  final String ? txt;
  final double ? fontsize;
  final bool ? start;

  BuildWhiteMuiliTextBold({required this.txt,required this.fontsize,this.start});


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return       Text(txt!,
      textAlign:
      (start!=null && start==true)?
          TextAlign.start
          :
      TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Muli-Regular',
        fontSize: height*(fontsize!),
        //21 heigt 0.027

        fontWeight: FontWeight.w700
      ),
    );
  }
}
class BuildMuliLightWhite extends StatelessWidget {

  final String ? txt;
  final double ? fontsize;

  BuildMuliLightWhite({required this.txt,required this.fontsize});


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return       Text(txt!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xffFFFFFF),
        fontFamily: 'Muli-Light',

        fontSize: height*(fontsize!),

      ),
    );
  }
}
import 'dart:async';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hovering/hovering.dart';
import 'package:kace/const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kace/extensions/hover_extensions.dart';
import 'package:kace/pages/about.dart';
import 'package:share_everywhere/share_everywhere.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Homepage.dart';
import 'dart:html' as html;

class Conditions extends StatefulWidget {
  const Conditions({Key? key}) : super(key: key);
  static const String route = 'conditions';

  @override
  _ConditionsState createState() => _ConditionsState();
}

ShareController shareController = ShareController(
  title: "Partager Kacé avec ses amis:",
  elevatedButtonText:
      Text("Partager", style: GoogleFonts.poppins(fontSize: 10)),
  networks: [
    SocialConfig(type: "facebook", appId: "484678409907042"),
    SocialConfig(type: "linkedin"),
    SocialConfig(type: "twitter"),
  ],
);

class _ConditionsState extends State<Conditions> with TickerProviderStateMixin {
  final _controller = ScrollController();
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: '1666kace@gmail.com',
    query: encodeQueryParameters(<String, String>{
      'subject':
          'commande - autre (gardez seulement la mention appropriée à votre demande)'
    }),
  );
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        floatingActionButton:
            ShareButton(shareController, "https://kace-6000.web.app"),
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: Material(
            elevation: 5,
            shadowColor: rose,
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(Homepage.route);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/commun_toutes_pages/logo_général/logo_lettre_K.svg",
                            width: 50,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          SvgPicture.asset(
                            "assets/commun_toutes_pages/logo_général/logo_nom_kacé.svg",
                            width: 75,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(width: screenSize.width / 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15 * 5),
                      child: Row(
                        children: [
                          HoverCrossFadeWidget(
                            duration: Duration(milliseconds: 300),
                            firstChild: InkWell(
                              onTap: () {
                                Timer(
                                  Duration(milliseconds: 500),
                                  () => _controller.jumpTo(
                                      _controller.position.maxScrollExtent),
                                );
                              },
                              child: Text(
                                'Contact',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            secondChild: InkWell(
                              onTap: () {
                                Timer(
                                  Duration(milliseconds: 500),
                                  () => _controller.jumpTo(
                                      _controller.position.maxScrollExtent),
                                );
                              },
                              child: Text(
                                'Contact',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: rose),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width / 50,
                          ),
                          HoverCrossFadeWidget(
                              duration: Duration(milliseconds: 300),
                              firstChild: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(About.route);
                                  },
                                  child: Text(
                                    'À propos',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  )),
                              secondChild: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(About.route);
                                  },
                                  child: Text('À propos',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: rose)))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            controller: _controller,
            children: [
              Material(
                elevation: 0,
                child: Container(
                  height: screenSize.height / 8,
                  color: rose,
                ),
              ),
              Material(
                elevation: 5,
                child: Column(
                  children: [
                   
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15 * 6, right: 15 * 6,  top: 15 * 3,
                        ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SelectableText(
                              'Conditions générales de vente et mentions légales',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          SelectableText(""),
                          SelectableText(
                              "Aucun retour, ni échange, ni remboursement n’est possible.",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w300)),
                          SelectableText(""),
                          SelectableText(condTitle1,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w300)),
                          SelectableText(condDesc1,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.w300)),
                          SelectableText(""),
                          SelectableText(condTitle2,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w300)),
                          SelectableText(condDesc2,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.w300)),
                          SelectableText(""),
                          SelectableText(condTitle3,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w300)),
                          SelectableText(condDesc3,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.w300)),
                          SelectableText(""),
                          SelectableText(condTitle4,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w300)),
                          SelectableText(condDesc4,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.w300)),
                          SelectableText(""),
                          SelectableText(condTitle5,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w300)),
                          SelectableText(condDesc5,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.w300)),
                          SelectableText(""),
                          SelectableText(condTitle6,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w300)),
                          SelectableText(condDesc6,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.w300)),
                          SelectableText(""),
                          SelectableText(condTitle7,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w300)),
                          SelectableText(condDesc7,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.w300)),
                          SelectableText(""),
                          SelectableText(condTitle8,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w300)),
                          SelectableText(condDesc8,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.w300)),
                          SelectableText(""),
                          SelectableText(condTitle9,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w300)),
                          SelectableText(condDesc9,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.w300)),
                          SelectableText(""),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0 * 6,
                        right: 15.0 * 6,
                        top: 15 * 3,
                        bottom: 15.0 * 3,
                      ),
                      child: new Divider(
                        thickness: 1,
                        color: rose,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15 * 6, right: 15 * 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: SelectableText('INFORMATIONS',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(Conditions.route);
                                },
                                child: HoverCrossFadeWidget(
                                    duration: Duration(milliseconds: 300),
                                    firstChild: Text(
                                            'Conditions générales de vente et mentions légales',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12))
                                        .showCursorOnHover,
                                    secondChild: Text(
                                            'Conditions générales de vente et mentions légales',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12, color: rose))
                                        .showCursorOnHover)),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 12, right: 12, bottom: 12, top: 0)),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      HoverCrossFadeWidget(
                                          duration: Duration(milliseconds: 300),
                                          firstChild: GestureDetector(
                                            onTap: () {
                                              html.window.location.href =
                                                  "https://www.instagram.com/_kacekace/";
                                            },
                                            child: Image.asset(
                                                "assets/commun_toutes_pages/logos_contact/logo_insta_noir.png",
                                                height: 32,
                                                width: 32,
                                                fit: BoxFit.contain),
                                          ),
                                          secondChild: GestureDetector(
                                            onTap: () {
                                              html.window.location.href =
                                                  "https://www.instagram.com/_kacekace/";
                                            },
                                            child: Image.asset(
                                                "assets/commun_toutes_pages/logos_contact/logo_insta_rose.png",
                                                height: 32,
                                                width: 32,
                                                fit: BoxFit.contain),
                                          )).showCursorOnHover,
                                      Padding(padding: EdgeInsets.all(4)),
                                      GestureDetector(
                                          onTap: () {
                                            html.window.location.href =
                                                "https://www.instagram.com/_kacekace/";
                                          },
                                          child: HoverCrossFadeWidget(
                                            duration:
                                                Duration(milliseconds: 300),
                                            firstChild: Text("@_kacekace",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12)),
                                            secondChild: Text("@_kacekace",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12, color: rose)),
                                          )).showCursorOnHover.moveUpPOnHover,
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      HoverCrossFadeWidget(
                                          duration: Duration(milliseconds: 300),
                                          firstChild: GestureDetector(
                                            onTap: () {
                                              launch(emailLaunchUri.toString());
                                            }, // Image tapped
                                            child: Image.asset(
                                              "assets/commun_toutes_pages/logos_contact/logo_mail_noir.png",
                                              height: 32,
                                              width: 32,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          secondChild: GestureDetector(
                                            onTap: () {
                                              launch(emailLaunchUri.toString());
                                            }, // Image tapped
                                            child: Image.asset(
                                              "assets/commun_toutes_pages/logos_contact/logo_mail_rose.png",
                                              height: 32,
                                              width: 32,
                                              fit: BoxFit.contain,
                                            ),
                                          )).showCursorOnHover,
                                      Padding(padding: EdgeInsets.all(4)),
                                      GestureDetector(
                                              onTap: () {
                                                launch(
                                                    emailLaunchUri.toString());
                                              },
                                              child: HoverCrossFadeWidget(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  firstChild: Text(
                                                      "contact.kacekace@gmail.com",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12)),
                                                  secondChild: Text(
                                                      "contact.kacekace@gmail.com",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              color: rose))))
                                          .showCursorOnHover
                                          .moveUpPOnHover
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0 * 6,
                        right: 15.0 * 6,
                        top: 15 * 3,
                        bottom: 15 * 3,
                      ),
                      child: new Divider(
                        thickness: 1,
                        color: rose,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 15.0 * 6,
                            left: 15 * 6,
                            bottom: 15 * 4,
                            top: 15 * 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SelectableText("© 2022 Kacé",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400, fontSize: 12)),
                            HoverCrossFadeWidget(
                                    duration: Duration(milliseconds: 300),
                                    firstChild: GestureDetector(
                                        onTap: () {
                                          launch(emailLaunchUri.toString());
                                        }, // Image tapped
                                        child: GestureDetector(
                                            onTap: () {
                                              html.window.location.href =
                                                  "https://fakman99.github.io/portfolioo";
                                            },
                                            child: Text(
                                                "Site réalisé par Fatih Akman",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12)))),
                                    secondChild: GestureDetector(
                                        onTap: () {
                                          html.window.location.href =
                                              "https://fakman99.github.io/portfolioo";
                                        },
                                        child: Text(
                                            "Site réalisé par Fatih Akman",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: rose))))
                                .showCursorOnHover,
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

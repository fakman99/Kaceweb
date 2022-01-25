import 'dart:async';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hovering/hovering.dart';
import 'package:kace/const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kace/extensions/hover_extensions.dart';
import 'package:kace/pages/about.dart';
import 'package:kace/pages/conditions.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:auto_animated/auto_animated.dart';
import 'dart:html' as html;
import 'package:extended_image/extended_image.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:share_everywhere/share_everywhere.dart';
import 'package:invert_colors/invert_colors.dart';

import 'showImage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  _HomepageState createState() => _HomepageState();
}

CarouselController buttonCarouselController = CarouselController();

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'contact.kacekace@gmail.com',
    query: encodeQueryParameters(<String, String>{
      'subject':
          'commande - autre (gardez seulement la mention appropriée à votre demande)'
    }),
  );

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

  final _controller = ScrollController();
  int _current = 0;
  final CarouselController _controllerr = CarouselController();

  @override
  Widget build(BuildContext context) {
    TabController tabController;
    @override
    void initState() {
      super.initState();
      tabController = TabController(
        initialIndex: 0,
        length: 2,
        vsync: this,
      );
    }

    final List<String> imgList = [
      "assets/homepage/mockup.png",
      "assets/homepage/design_T-shirt_final.png",
      "assets/homepage/design_T-shirt_front.png"
    ];

    final List<String> imgListDesc = ["T-Shirt Charleroi", "Dos", "Face"];

    final List<Widget> imageSliders = imgList
        .map((item) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SliderShowFullmages(title:imgListDesc[imgList.indexOf(item)],
                          indexPhoto:
            imgList[imgList.indexOf(item)]
                        )));
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              imgListDesc[imgList.indexOf(item)],
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    TabController _tabController = TabController(length: 2, vsync: this);

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
                  height: screenSize.height / 12,
                  color: rose,
                ),
              ),
              Material(
                elevation: 10,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CarouselSlider(
                          carouselController: _controllerr,
                          options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            },
                            height: 400,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 1000),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: false,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: imageSliders),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controllerr.animateToPage(entry.key),
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black)
                                      .withOpacity(
                                          _current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Material(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(15 * 2),
                        child: Container(
                            child: Center(
                          child: Column(
                            children: [
                              SelectableText(
                                "T-shirt Charleroi",
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SelectableText(
                                "Noir",
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                              SelectableText(
                                "25€ taxes incluses.",
                                style: GoogleFonts.poppins(),
                              )
                            ],
                          ),
                        )),
                      ),
                    ),
                    Material(
                      elevation: 0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0 * 6,
                              right: 15.0 * 6,
                              top: 15.0 * 3,
                              bottom: 15.0 * 3,
                            ),
                            child: new Divider(
                              thickness: 1,
                              color: rose,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                15.0 * 6.0, 0, 15.0 * 6.0, 0),
                            child: new Container(
                              child: new TabBar(
                                labelStyle: GoogleFonts.poppins(),
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.black,
                                indicatorColor: rose,
                                controller: _tabController,
                                tabs: [
                                  new Tab(
                                    text: 'Description',
                                  ).showCursorOnHover.moveUpPOnHover,
                                  new Tab(
                                    text: 'Guide des tailles',
                                  ).showCursorOnHover.moveUpPOnHover,
                                ],
                              ),
                            ),
                          ),
                          new Container(
                            height: screenSize.height / 2,
                            width: double.infinity,
                            child: new TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        15.0 * 6, 24, 15.0 * 6, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SelectableText(
                                            "Visuel visant à promouvoir l’aspect culturel de la ville de",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300)),
                                        SelectableText(
                                            "Charleroi. Chaque élément de la composition est une",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300)),
                                        SelectableText(
                                            "référence. Les as-tu toutes trouvées ?",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300)),
                                        SelectableText(""),
                                        SelectableText("100% coton",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300)),
                                        SelectableText(""),
                                        SelectableText("Sérigraphie",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300)),
                                        Text(""),
                                        Text(''),
                                        Text(""),
                                        Text(''),
                                        RichText(
                                          textAlign: TextAlign.justify,
                                          text: new TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black),

                                            children: <TextSpan>[
                                              new TextSpan(
                                                  text:
                                                      'Pour toute commande (ou question), contactez-moi via '),
                                              new TextSpan(
                                                recognizer:
                                                    new TapGestureRecognizer()
                                                      ..onTap = () => html
                                                              .window
                                                              .location
                                                              .href =
                                                          "https://www.instagram.com/_kacekace/",
                                                text: 'Instagram ',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w300,
                                                    color: rose),
                                              ),
                                              new TextSpan(
                                                text: "ou par ",
                                              ),
                                              new TextSpan(
                                                recognizer:
                                                    new TapGestureRecognizer()
                                                      ..onTap = () => launch(
                                                          emailLaunchUri
                                                              .toString()),
                                                text: "mail ",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w300,
                                                    color: rose),
                                              ),
                                              new TextSpan(
                                                  text:
                                                      'en indiquant : « prénom nom - quantité - taille ». Livraison possible dans un rayon de 10km de Charleroi moyennant 5€ supplémentaires ou à venir chercher au 5 Place Communale, Couillet 6010.'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      15.0 * 6, 4, 15 * 6, 0),
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: DataTable(
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: SelectableText(
                                            'Taille',
                                            style: GoogleFonts.poppins(),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SelectableText(
                                              'Mensurations (cm)',
                                              style: GoogleFonts.poppins()),
                                        ),
                                      ],
                                      rows: <DataRow>[
                                        DataRow(
                                          cells: <DataCell>[
                                            DataCell(SelectableText('XS',
                                                style: GoogleFonts.poppins())),
                                            DataCell(SelectableText('87/92',
                                                style: GoogleFonts.poppins())),
                                          ],
                                        ),
                                        DataRow(
                                          cells: <DataCell>[
                                            DataCell(SelectableText('S',
                                                style: GoogleFonts.poppins())),
                                            DataCell(SelectableText('92/97',
                                                style: GoogleFonts.poppins())),
                                          ],
                                        ),
                                        DataRow(
                                          cells: <DataCell>[
                                            DataCell(SelectableText('M',
                                                style: GoogleFonts.poppins())),
                                            DataCell(SelectableText('97/102',
                                                style: GoogleFonts.poppins())),
                                          ],
                                        ),
                                        DataRow(
                                          cells: <DataCell>[
                                            DataCell(SelectableText('L',
                                                style: GoogleFonts.poppins())),
                                            DataCell(SelectableText('102/107',
                                                style: GoogleFonts.poppins())),
                                          ],
                                        ),
                                        DataRow(
                                          cells: <DataCell>[
                                            DataCell(SelectableText('XL',
                                                style: GoogleFonts.poppins())),
                                            DataCell(SelectableText('107/112',
                                                style: GoogleFonts.poppins())),
                                          ],
                                        ),
                                        DataRow(
                                          cells: <DataCell>[
                                            DataCell(SelectableText('XXL',
                                                style: GoogleFonts.poppins())),
                                            DataCell(SelectableText('112/117',
                                                style: GoogleFonts.poppins())),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0 * 6,
                              right: 15.0 * 6,
                              top: 15.0 * 3,
                              bottom: 15.0 * 3,
                            ),
                            child: new Divider(
                              thickness: 1,
                              color: rose,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15 * 6, right: 15 * 6),
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
                                                      fontSize: 12,
                                                      color: rose))
                                              .showCursorOnHover)),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            HoverCrossFadeWidget(
                                                duration:
                                                    Duration(milliseconds: 300),
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
                                                      html.window.location
                                                              .href =
                                                          "https://www.instagram.com/_kacekace/";
                                                    },
                                                    child: HoverCrossFadeWidget(
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      firstChild: Text(
                                                          "@_kacekace",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize:
                                                                      12)),
                                                      secondChild: Text(
                                                          "@_kacekace",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 12,
                                                                  color: rose)),
                                                    ))
                                                .showCursorOnHover
                                                .moveUpPOnHover,
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
                                                duration:
                                                    Duration(milliseconds: 300),
                                                firstChild: GestureDetector(
                                                  onTap: () {
                                                    launch(emailLaunchUri
                                                        .toString());
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
                                                    launch(emailLaunchUri
                                                        .toString());
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
                                                      launch(emailLaunchUri
                                                          .toString());
                                                    },
                                                    child: HoverCrossFadeWidget(
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        firstChild: Text(
                                                            "contact.kacekace@gmail.com",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        12)),
                                                        secondChild: Text(
                                                            "contact.kacekace@gmail.com",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        rose))))
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
                                right: 15.0 * 6, left: 15 * 6, top: 15 * 3),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SelectableText("© 2022 Kacé",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12)),
                                  HoverCrossFadeWidget(
                                          duration: Duration(milliseconds: 300),
                                          firstChild: GestureDetector(
                                              onTap: () {
                                                launch(
                                                    emailLaunchUri.toString());
                                              }, // Image tapped
                                              child: GestureDetector(
                                                  onTap: () {
                                                    html.window.location.href =
                                                        "https://fakman99.github.io/portfolioo";
                                                  },
                                                  child: Text(
                                                      "Site réalisé par Fatih Akman",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12)))),
                                          secondChild: GestureDetector(
                                              onTap: () {
                                                html.window.location.href =
                                                    "https://fakman99.github.io/portfolioo";
                                              },
                                              child: Text(
                                                  "Site réalisé par Fatih Akman",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w400,
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
              ),
            ],
          ),
        ));
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kace/const.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class SliderShowFullmages extends StatefulWidget {
 final String title;
   final String indexPhoto;
  
  const SliderShowFullmages({required this.indexPhoto, required this.title }) : super();
  _SliderShowFullmagesState createState() => _SliderShowFullmagesState();
}

class _SliderShowFullmagesState extends State<SliderShowFullmages> {
  @override
  void initState() {
    super.initState();
  }
 final List<String> imgList = [
      "assets/homepage/mockup.png",
      "assets/homepage/design_T-shirt_final.png",
      "assets/homepage/design_T-shirt_front.png"
    ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
          iconTheme: IconThemeData(
    color: rose, //change your color here
  ),
          backgroundColor: Colors.transparent,
          //title: const Text('Transaction Detail'),
        ),
        body: 
             Container(
    child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: AssetImage(widget.indexPhoto),
          initialScale: PhotoViewComputedScale.contained * 0.8,
          minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        
    
       
      },
       
     
      itemCount: imgList.length,
          
             )));
  }
}

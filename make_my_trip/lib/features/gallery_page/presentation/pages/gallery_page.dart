

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';


import 'view_full_image_page.dart';

List<String> imageList = [
  'https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F1.jpg?alt=media&token=3148b5f2-af26-4094-8c7c-59dd4c5c9a5f',
  'https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F10.jpg?alt=media&token=957ff0b4-4e9d-49c7-a073-5acee6718bf9',
  "https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F100.jpg?alt=media&token=95abd6b8-d27e-4f3f-93bb-984175b41beb",
  'https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F11.jpg?alt=media&token=800ca785-fab3-4b52-8f48-f050aece4d48',
  'https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F12.jpg?alt=media&token=817b5b0a-4acf-4030-8842-027578f5c105',
  'https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F13.jpg?alt=media&token=5eb95a9a-09ed-459f-99af-ebc8de28ad30',
  'https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F14.jpeg?alt=media&token=6edb351a-2bcf-4935-9ed6-75a45f008ab0',
  'https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F15.jpg?alt=media&token=b637950d-3fde-418e-911f-cc2eaafa00a1',
  'https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F99.jpg?alt=media&token=4b7ad5dc-68e5-4cf7-90b8-36974a3a6d07',
  'https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F16.jpg?alt=media&token=b013cb81-c174-43ac-9c24-cbc4064d1924',
  'https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F21.jpg?alt=media&token=0b473db2-9f81-41da-b177-bb16f6177b8f',
  'https://firebasestorage.googleapis.com/v0/b/travelproject22-6b9d4.appspot.com/o/hotel_image%2F47.jpg?alt=media&token=b3e15d65-d7d0-4da3-b0e2-a23d348cbc1c'
];

class GalleryPage extends StatelessWidget {
  GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Gallery',
            style: AppTextStyles.unselectedLabelStyle,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: GridView.custom(
            gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 20,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                repeatPattern: QuiltedGridRepeatPattern.same,
                pattern: getPattern()),
            childrenDelegate: SliverChildListDelegate(List.generate(
              imageList.length,
              (index) => Tile(
                index: index,
              ),
            )),
          ),
        ));
  }

  List<QuiltedGridTile> getPattern() {
    List<QuiltedGridTile> patternList = [];

    for (int i = imageList.length; i > 0; i -= 6) {
      if (i > 6) {
        patternList.add(QuiltedGridTile(10, 12));
        patternList.add(QuiltedGridTile(5, 8));
        patternList.add(QuiltedGridTile(5, 8));
        patternList.add(QuiltedGridTile(10, 20));
        patternList.add(QuiltedGridTile(7, 10));
        patternList.add(QuiltedGridTile(7, 10));
      } else {
        if (i == 1) {
          patternList.add(QuiltedGridTile(12, 20));
        } else if (i == 2) {
          patternList.add(QuiltedGridTile(8, 10));
          patternList.add(QuiltedGridTile(8, 10));
        } else if (i == 3) {
          patternList.add(QuiltedGridTile(10, 12));
          patternList.add(QuiltedGridTile(5, 8));
          patternList.add(QuiltedGridTile(5, 8));
        } else if (i == 4) {
          patternList.add(QuiltedGridTile(10, 12));
          patternList.add(QuiltedGridTile(5, 8));
          patternList.add(QuiltedGridTile(5, 8));
          patternList.add(QuiltedGridTile(12, 20));
        } else if (i == 5) {
          patternList.add(QuiltedGridTile(10, 12));
          patternList.add(QuiltedGridTile(5, 8));
          patternList.add(QuiltedGridTile(5, 8));
          patternList.add(QuiltedGridTile(8, 10));
          patternList.add(QuiltedGridTile(8, 10));
        } else if (i == 6) {
          patternList.add(QuiltedGridTile(10, 12));
          patternList.add(QuiltedGridTile(5, 8));
          patternList.add(QuiltedGridTile(5, 8));
          patternList.add(QuiltedGridTile(10, 20));
          patternList.add(QuiltedGridTile(7, 10));
          patternList.add(QuiltedGridTile(7, 10));
        }
      }
    }

    return patternList;
  }
}

class Tile extends StatelessWidget {
  Tile({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ViewImage(
                    index: index,
                    imgStr: imageList[index],
                  )));
          //Navigator.pushNamedAndRemoveUntil(context, newRouteName, (route) => false,arguments: {})
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Hero(
                tag: index.toString(),
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    placeholder: 'assets/img/placeholder.png',
                    image: imageList[index],
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                          'assets/img/placeholder.png',
                          fit: BoxFit.fitWidth,);
                    })
            )));
  }
}

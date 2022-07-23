import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/gallery_page/presentation/cubit/gallery_cubit.dart';
import 'view_full_image_page.dart';

List<String> imageList = [];

class GalleryPage extends StatelessWidget {
  GalleryPage({Key? key, required this.arg}) : super(key: key);
  Map<String, dynamic> arg;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryCubit, BaseState>(
      builder: (context, state) {
        if(state is StateOnSuccess){
          imageList = state.response;
        }
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
                      (index) =>
                      Tile(
                        index: index,
                      ),
                )),
              ),
            ));
      },
    );
  }

  List<QuiltedGridTile> getPattern() {
    List<QuiltedGridTile> patternList = [];

    for (int i = imageList.length; i > 0; i -= 6) {
      if (i > 6) {
        patternList.add(const QuiltedGridTile(10, 12));
        patternList.add(const QuiltedGridTile(5, 8));
        patternList.add(const QuiltedGridTile(5, 8));
        patternList.add(const QuiltedGridTile(10, 20));
        patternList.add(const QuiltedGridTile(7, 10));
        patternList.add(const QuiltedGridTile(7, 10));
      } else {
        if (i == 1) {
          patternList.add(const QuiltedGridTile(12, 20));
        } else if (i == 2) {
          patternList.add(const QuiltedGridTile(8, 10));
          patternList.add(const QuiltedGridTile(8, 10));
        } else if (i == 3) {
          patternList.add(const QuiltedGridTile(10, 12));
          patternList.add(const QuiltedGridTile(5, 8));
          patternList.add(const QuiltedGridTile(5, 8));
        } else if (i == 4) {
          patternList.add(const QuiltedGridTile(10, 12));
          patternList.add(const QuiltedGridTile(5, 8));
          patternList.add(const QuiltedGridTile(5, 8));
          patternList.add(const QuiltedGridTile(12, 20));
        } else if (i == 5) {
          patternList.add(const QuiltedGridTile(10, 12));
          patternList.add(const QuiltedGridTile(5, 8));
          patternList.add(const QuiltedGridTile(5, 8));
          patternList.add(const QuiltedGridTile(8, 10));
          patternList.add(const QuiltedGridTile(8, 10));
        } else if (i == 6) {
          patternList.add(const QuiltedGridTile(10, 12));
          patternList.add(const QuiltedGridTile(5, 8));
          patternList.add(const QuiltedGridTile(5, 8));
          patternList.add(const QuiltedGridTile(10, 20));
          patternList.add(const QuiltedGridTile(7, 10));
          patternList.add(const QuiltedGridTile(7, 10));
        }
      }
    }

    return patternList;
  }
}

class Tile extends StatelessWidget {
  const Tile({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ViewImage(
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
                        fit: BoxFit.fitWidth,
                      );
                    }))));
  }
}

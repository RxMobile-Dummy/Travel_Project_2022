  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/gallery_page/presentation/cubit/gallery_cubit.dart';
import 'package:make_my_trip/features/gallery_page/presentation/pages/gallery_page.dart';

class ViewImage extends StatelessWidget {
  ViewImage({
    Key? key,
    required this.arg,
    // required this.index,
    // required this.imgStr,
  }) : super(key: key);
  // final int index;
  // final String imgStr;
  final Map<String, dynamic> arg;
  @override
  Widget build(BuildContext context) {
    //Map map =  ModalRoute.of(context)!.settings.arguments;
    PageController controller =
        PageController(initialPage: int.parse(arg['index']));
    return BlocProvider<GalleryCubit>(
      create: (context) => GalleryCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: MakeMyTripColors.colorWhite),
        ),
        backgroundColor: MakeMyTripColors.colorBlack,
        body: BlocBuilder<GalleryCubit, BaseState>(
          builder: (context, state) {
            return Center(
              child: Hero(
                  tag: (state is StateOnSuccess)
                      ? state.response.toString()
                      : arg['index'].toString(),
                  child: PageView.builder(
                      controller: controller,
                      itemCount: imageList.length,
                      pageSnapping: true,
                      onPageChanged: (val) {
                        context.read<GalleryCubit>().setPage(val);
                      },
                      itemBuilder: (context, pagePosition) {
                        return InteractiveViewer(
                          panEnabled: true,
                          minScale: 0.1,
                          maxScale: 1.6,
                          child: Container(
                              margin: const EdgeInsets.all(10),
                              child: FadeInImage.assetNetwork(
                                  alignment: Alignment.center,
                                  placeholder: 'assets/img/placeholder.png',
                                  image: imageList[pagePosition],
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/img/placeholder.png',
                                        fit: BoxFit.fitWidth);
                                  })),
                        );
                      })),
            );
          },
        ),
      ),
    );
  }
}

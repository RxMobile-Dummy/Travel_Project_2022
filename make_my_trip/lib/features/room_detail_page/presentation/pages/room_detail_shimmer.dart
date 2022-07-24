import 'package:flutter/material.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/container_widget.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/list_container_widget.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:shimmer/shimmer.dart';

class RoomDetailsShimmer extends StatelessWidget {
  const RoomDetailsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SafeArea(
              child: Center(
                  child: ContainerWidget(width: size.width,hight: size.height * 0.3)
              ),
            ),
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                direction: ShimmerDirection.ltr,
                child: ListView.builder(
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(bottom: 20.0,left: 23,top: 10,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        // room title
                        ListContainer(hight: 35,width: size.width * 0.35,),

                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              // room size
                              ListContainer(
                                width: size.width * 0.44,
                                hight: size.height * 0.12,
                              ),
                              6.horizontalSpace,
                              // room beds
                              ListContainer(
                                width: size.width * 0.44,
                                hight: size.height * 0.12,
                              )
                            ],
                          ),
                        ),

                        // room description title
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: ListContainer(hight: 35,width: size.width * 0.35,),
                        ),

                        // room description details
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListContainer(hight: size.height * 0.15,width: size.width * 0.9,),
                        ),

                        // room amenities
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: ListContainer(hight: 35,width: size.width * 0.35,),
                        ),

                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ListContainer(width: size.width * 0.3 ,hight: 20,)
                            ),
                            const Spacer(),
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ListContainer(width: size.width * 0.3 ,hight: 20,)
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ListContainer(width: size.width * 0.3 ,hight: 20,)
                            ),
                            const Spacer(),
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ListContainer(width: size.width * 0.3 ,hight: 20,)
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  itemCount: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

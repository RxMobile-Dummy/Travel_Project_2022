import 'package:flutter/material.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/list_container_widget.dart';
import 'package:shimmer/shimmer.dart';

class HotelListShimmer extends StatelessWidget {
  const HotelListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.white,
              direction: ShimmerDirection.ltr,
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20.0, left: 23, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListContainer(
                        hight: size.height * 0.25,
                        width: size.width * 0.9,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListContainer(
                            width: size.width * 0.4,
                            hight: 25,
                          )),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListContainer(
                                width: size.width * 0.53,
                                hight: 50,
                              )),
                          const Spacer(),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 23),
                              child: ListContainer(
                                width: size.width * 0.25,
                                hight: 50,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                itemCount: 4,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

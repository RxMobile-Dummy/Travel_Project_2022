import 'package:flutter/material.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/list_container_widget.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:shimmer/shimmer.dart';

class RoomCategoriesShimmerPage extends StatelessWidget {
  const RoomCategoriesShimmerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.white,
                  direction: ShimmerDirection.ltr,
                  child: ListView.builder(
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20.0, left: 23, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListContainer(
                            hight: 30,
                            width: size.width * 0.45,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ListContainer(
                              hight: size.height * 0.10,
                              width: size.width * 0.9,
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: ListContainer(
                                        width: size.width * 0.44,
                                        hight: size.height * 0.2,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ListContainer(
                                      hight: 20,
                                      width: size.width * 0.20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ListContainer(
                                      hight: 20,
                                      width: size.width * 0.30,
                                    ),
                                  ),
                                ],
                              ),
                              7.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: ListContainer(
                                        width: size.width * 0.44,
                                        hight: size.height * 0.2,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ListContainer(
                                      hight: 20,
                                      width: size.width * 0.30,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ListContainer(
                                      hight: 20,
                                      width: size.width * 0.20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ListContainer(
                              hight: 45,
                              width: size.width * 0.9,
                            ),
                          ),
                        ],
                      ),
                    ),
                    itemCount: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
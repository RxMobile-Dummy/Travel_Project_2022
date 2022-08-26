import 'package:flutter/material.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../wishlist/presentation/widgets/list_container_widget.dart';

class HistoryDetailPageShimmer extends StatelessWidget {
  const HistoryDetailPageShimmer({Key? key}) : super(key: key);

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
                          bottom: 20.0, left: 10, top: 0, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListContainer(
                                width: double.infinity,
                                hight: size.height * 0.26,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListContainer(
                                  hight: size.height * 0.050,
                                  width: size.width * 0.75,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ListContainer(
                                    hight: size.height * 0.028,
                                    width: size.width * 0.20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ListContainer(
                                    hight: size.height * 0.035,
                                    width: size.width * 0.50,
                                  ),
                                ),
                                12.verticalSpace,
                                Center(
                                  child: Container(
                                    height: size.height * 0.4,
                                    width: size.width * 0.6,
                                    child: ListView.builder(
                                      itemCount: 10,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: ListContainer(
                                            hight: size.height * 0.035,
                                            width: size.width * 0.50,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
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
      ),
    );
  }
}

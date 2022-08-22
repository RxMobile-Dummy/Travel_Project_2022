import 'package:flutter/material.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/list_container_widget.dart';
import 'package:shimmer/shimmer.dart';

class HistoryPageShimmer extends StatelessWidget {
  const HistoryPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ListContainer(
                                    width: size.width * 0.30,
                                    hight: size.height * 0.16,
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListContainer(
                                      hight: size.height * 0.030,
                                      width: size.width * 0.35,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    itemCount: 5,
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


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/container_widget.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/list_container_widget.dart';
import 'package:shimmer/shimmer.dart';



class WishlistShimmer extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shimmer Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShimmerEffect(),
    );
  }
}

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
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
              baseColor: Colors.grey,
              highlightColor: Colors.grey[300]!,
              direction: ShimmerDirection.ltr,
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0,left: 23,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      ListContainer(hight: size.height * 0.2,width: size.width * 0.9,),

                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListContainer(width: size.width * 0.4 ,hight: 20,)
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListContainer(width: size.width * 0.3 ,hight: 20,)
                          ),
                          Spacer(),
                          Padding(
                              padding: const EdgeInsets.only(top: 10,right: 23),
                              child: ListContainer(width: size.width * 0.3 ,hight: 20,)
                          ),

                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListContainer(width: size.width * 0.8 ,hight: 20,)
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
    );
  }
}

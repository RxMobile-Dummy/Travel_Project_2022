import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../manager/cubit/imageslider_cubit.dart';
class Room_Details extends StatelessWidget {
  Room_Details({Key? key}) : super(key: key);

  final List<String> imgList = [
    ImagePath.imagecenter,
    ImagePath.imagecenter2,
    ImagePath.imagecenter3

  ];
  @override
  Widget build(BuildContext context) {




    return Scaffold(
        bottomNavigationBar: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color:MakeMyTripColors.colorBlack,
            borderRadius: BorderRadius.circular(3),

          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Price",style:AppTextStyles.infoContentStyle3,),
                ElevatedButton(onPressed: (){}, child: Text(StringConstants.continue_button,style: AppTextStyles.infoContentStyle3))
              ],
            ),
          ),
        ),
        body:  SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                    children: [
                          CarouselSlider(
                              options: CarouselOptions(
                                  height: 200,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  // autoPlay: false,
                                  onPageChanged: (i, r) {
                                   BlocProvider.of<ImagesliderCubit>(context).getindex(i);

                                  }
                              ),
                              items: imgList
                                  .map((item) =>
                                  Container(
                                    child: Center(
                                        child: Image.asset(
                                          item,
                                          fit: BoxFit.cover,
                                          height: 200,
                                          width: double.infinity,
                                        )),
                                  ))
                                  .toList(),





),
                     Container(
                       height: 200,
                       child: Column(
                         children: [
                           Expanded(child:
                           Column(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Row(
                                       children: [
                                         Icon(Icons.arrow_back_ios_outlined,size: 20,color: MakeMyTripColors.colorWhite,),
                                         Text(StringConstants.back,style:AppTextStyles.confirmButtonTextStyle,)
                                       ],
                                     ),
                                     Text(StringConstants.deluxroom,style:AppTextStyles.confirmButtonTextStyle),
                                     Icon(Icons.settings,size: 20,color: MakeMyTripColors.colorWhite,)


                                   ],
                                 ),
                               )
                             ],
                           )),
                           Center(
                             child: BlocBuilder<ImagesliderCubit,ImagesliderState>(
                                builder: (context, state) {
                                  if(state is GetIndexState) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      child: AnimatedSmoothIndicator(
                                        activeIndex:state.i,
                                        count: imgList.length,
                                        effect: ExpandingDotsEffect(
                                            dotColor: MakeMyTripColors.colorWhite,
                                            activeDotColor: MakeMyTripColors.colorBlue,
                                            dotWidth: 8,
                                            dotHeight: 8),
                                      ),
                                    );

                                  }
                                  else{
                                    return Text("No Data Available");
                                  }
    },
),
                           ),
                         ],
                       ),
                     ),



                ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 70,
                            width: 120,
                            decoration: BoxDecoration(
                              color: MakeMyTripColors.color10gray,
                              borderRadius: BorderRadius.circular(10),

                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(StringConstants.room_size,style: TextStyle(fontSize: 17),),
                                  SizedBox(height: 3,),
                                  Text("72 m2",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                              color: MakeMyTripColors.color10gray,
                              borderRadius: BorderRadius.circular(10),

                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(StringConstants.bed,style: TextStyle(fontSize: 17),),
                                  SizedBox(height: 3,),
                                  Text("2 Twins",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],

                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,bottom: 10),
                  child: Text(StringConstants.description,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,bottom: 10),
                  child: Text("Monteverde Country Lodge is a quiet, comfortable hotel located near the Ecological Sanctuary and the Monteverde Butterfly Gardens in an area called Cerro Plano, an ideal location half way between the Monteverde Cloud Forest reserve and the main village of the Monteverde area (Santa Elena), in close proximity to several restaurants and activities. All rooms have private bathrooms with hot water.",style: TextStyle(fontSize: 14),),
                ),
                SizedBox(height: 35,),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0,bottom: 10),
                  child: Text(StringConstants.amenities,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Column(

                    children: [
                     amenities(ImagePath.demoroom, "72 m2"),


                      SizedBox(height: 15,),
                     amenities(ImagePath.tv, "Flat Screen Tv")

                    ],
                  ),
                  Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      amenities(ImagePath.wifi, "Free WiFi"),
                      SizedBox(height: 15,),
                      amenities(ImagePath.ac, "Air Conditioning"),

                    ],
                  )
                ],),
                SizedBox(height: 20,)

              ],
            ),
          ),
        )
      );
  }
}
Widget amenities(String image,String title){
  return    Container(
height: 100,
width: 170,
decoration: BoxDecoration(
boxShadow: [BoxShadow(
color: MakeMyTripColors.color0gray,
blurRadius: 5.0,
),],

borderRadius: BorderRadius.circular(10),
image: DecorationImage(
image: AssetImage(image),
fit: BoxFit.cover,

)
),
child:  Column(

children: [
Expanded(child: SizedBox()),
Container(
decoration: BoxDecoration(
color: MakeMyTripColors.color10gray,
borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10) ,bottomRight:Radius.circular(10)),

),

height: 20,
width: double.infinity,
child: Center(child: Text(title,style: TextStyle(color:MakeMyTripColors.colorBlack),)))],
),
);
}
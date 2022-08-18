import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/booking/presentation/cubit/payment_integeration_cubit.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/coupon_widget.dart';

class ApplyCouponPage extends StatelessWidget {
  const ApplyCouponPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('app');
    List<ViewCouponModel>? couponList;
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text('Apply Coupon'),
        ),
        body: BlocBuilder<PaymentCubit, BaseState>(
          builder: (context, state) {
            // if(state is StateOnSuccess<List<ViewCouponModel>>){
            //   couponList=state.response;
            // }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Stack(children: [
                      Positioned(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Enter Coupon Code Here',
                            hintStyle: AppTextStyles.labelDescriptionStyle,
                            enabledBorder: InputBorder.none,
                          ),
                          controller: textEditingController,
                        ),
                      ),
                      Positioned(
                          right: 20,
                          top: 12,
                          child: GestureDetector(
                              onTap: () {
                                //on Tap of apply
                              },
                              child: const Text(
                                "Apply",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.orangeAccent),
                              )))
                    ]),
            //         ListView.builder(
            //             itemCount:5,
            //             itemBuilder: (context, index ){
            //               return Container(
            //                 child: Text('hello'),
            //               );
            // }
            //         )
                  ],
                ),
              ),


            );
          },
        ));
  }
}

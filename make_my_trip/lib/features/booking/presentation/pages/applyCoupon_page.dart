import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/booking/presentation/cubit/payment_integeration_cubit.dart';
import 'package:make_my_trip/features/booking/presentation/pages/booking_page.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';
import 'package:make_my_trip/features/home_page/presentation/pages/view_full_coupon_page.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/coupon_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class ApplyCouponPage extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  bool flag = false;
  final String data = '';

  Map<String, dynamic> arg;

  ApplyCouponPage({Key? key, required this.arg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('app');
    List<ViewCouponModel>? couponList;

    return Scaffold(
        appBar: AppBar(
          title: Text('Apply Coupon'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                    onChanged: (value) {
                      //value = data;
                      if (value.isNotEmpty) {
                        context
                            .read<PaymentCubit>()
                            .applyButton(value.isNotEmpty ? true : false);
                      }
                    },
                  ),
                ),
                Positioned(
                    right: 20,
                    top: 12,
                    child: BlocListener<PaymentCubit, BaseState>(
                      listener: (context, state) {
                        if (state
                            is StateOnResponseSuccess<List<ViewCouponModel>>) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) {
                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.of(context).pushNamed(
                                      RoutesName.bookingPage,
                                      arguments: {
                                        'model': arg['model'],
                                        'coupon_id': state.response[0].id
                                      });
                                });
                                return AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(32.0))),
                                  elevation: 4,
                                  title: Column(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1.6,
                                        child: Image.asset(
                                          ImagePath.confirmSuccess,
                                        ),
                                      ),
                                      30.verticalSpace,
                                      Text(
                                        "Coupon SuccessFully Applied",
                                        style: const TextStyle(
                                            color: MakeMyTripColors.accentColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      25.verticalSpace,
                                    ],
                                  ),
                                );
                              });
                        } else {}
                      },
                      child: GestureDetector(onTap: () {
                        context.read<PaymentCubit>.call().checkCoupon(
                            arg['price'], textEditingController.text);
                      }, child: BlocBuilder<PaymentCubit, BaseState>(
                        builder: (context, state) {
                          return Text("Apply",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: state is StateSearchResult
                                    ? (state.response == true
                                        ? Colors.orangeAccent
                                        : Colors.grey)
                                    : Colors.grey,
                              ));
                        },
                      )),
                    ))
              ]),
              BlocBuilder<PaymentCubit, BaseState>(builder: (context, state) {
                if (state is StateOnSuccess<List<ViewCouponModel>>) {
                  couponList = state.response;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: couponList!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewFullCoupon(
                                      discountText: couponList![index]
                                          .discount
                                          .toString(),
                                      imgUrl: couponList![index]
                                          .couponImgUrl
                                          .toString(),
                                      expiryDate: couponList![index]
                                          .endDate
                                          .toString()
                                          .substring(0, 10),
                                      couponTitle: couponList![index].title!,
                                      couponCode:
                                          couponList![index].code.toString(),
                                      couponDetails: couponList![index]
                                          .description
                                          .toString())));
                            },
                            child: CouponWidget(
                                couponTitle: couponList![index].title!,
                                discountText:
                                    couponList![index].discount.toString(),
                                expiryDate: couponList![index]
                                    .endDate
                                    .toString()
                                    .substring(0, 10),
                                imgUrl:
                                    couponList![index].couponImgUrl.toString()),
                          );
                        }),
                  );
                } else if (state is StateErrorGeneral) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return Center(
                    child: Container(),
                  );
                }
              })
            ],
          ),
        ));
  }
}

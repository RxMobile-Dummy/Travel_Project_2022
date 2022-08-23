import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/navigation/route_info.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelPutModel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/cubit/hotel_cubit.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/pages/get_hotels_ui.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/checkBoxWidget.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/lognText_textField.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/textFieldWidget.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/common/common_extensions.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip_admin_panel/utils/validations/user_info/user_information_validations.dart';
import 'package:make_my_trip_admin_panel/utils/widgets/common_primary_button.dart';

class AddHotels extends StatelessWidget {
  AddHotels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(flex: 4, child: Container()),
        Expanded(flex: 8, child: AddNewHotels()),
        Expanded(flex: 4, child: Container())
      ],
    ));
  }
}

class AddNewHotels extends StatefulWidget {
  AddNewHotels({Key? key}) : super(key: key);

  @override
  State<AddNewHotels> createState() => _AddNewHotelsState();
}

class _AddNewHotelsState extends State<AddNewHotels> {
  TextEditingController hotelName = TextEditingController();

  TextEditingController hotelAddress = TextEditingController();

  TextEditingController cityId = TextEditingController();

  TextEditingController pincode = TextEditingController();

  TextEditingController hotelRating = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController phone_number = TextEditingController();

  TextEditingController no_of_rooms = TextEditingController();

  TextEditingController hotel_Description = TextEditingController();

  TextEditingController no_of_deluxeRoom = TextEditingController();

  TextEditingController deluxe_roomSize = TextEditingController();

  TextEditingController deluxe_room_bed_details = TextEditingController();

  TextEditingController deluxe_room_max_capacity = TextEditingController();

  TextEditingController deluxe_room_price = TextEditingController();

  TextEditingController deluxe_room_description = TextEditingController();

  TextEditingController no_of_semiDeluxeRoom = TextEditingController();

  TextEditingController semiDeluxe_roomSize = TextEditingController();

  TextEditingController semiDeluxe_room_bed_details = TextEditingController();

  TextEditingController semiDeluxe_room_max_capacity = TextEditingController();

  TextEditingController semiDeluxe_room_price = TextEditingController();

  TextEditingController semiDeluxe_room_description = TextEditingController();

  TextEditingController no_of_superDeluxeRoom = TextEditingController();

  TextEditingController superDeluxe_roomSize = TextEditingController();

  TextEditingController superDeluxe_room_bed_details = TextEditingController();

  TextEditingController superDeluxe_room_max_capacity = TextEditingController();

  TextEditingController superDeluxe_room_price = TextEditingController();

  TextEditingController superDeluxe_room_description = TextEditingController();

  bool parking = false;
  bool healthy_breakfast = false;
  bool transportation = false;
  bool laundry = false;
  bool entertainment = false;
  bool extra = false;

  bool internate = false;
  bool coffee = false;
  bool soundproofWall = false;
  bool smartTv = false;
  bool airCondition = false;

  List<String> hotelFeatures = [];
  List<String> deluxeRoomFeatures = [];
  List<String> semiDeluxeRoomFeatures = [];
  List<String> superDeluxeRoomFeatures = [];

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    const pattern = r'[0-9]';
    final regExp = RegExp(pattern);
    return BlocListener<HotelCubit, BaseState>(
      listener: (context, state) {
        if (state is StateOnResponseSuccess<HotelPutModel>) {
          hotelName.text = state.response.hotelName!;
          hotelAddress.text = state.response.address!.addressLine!;
          pincode.text = state.response.address!.pincode.toString();
          cityId.text = state.response.address!.cityId.toString();
          hotelRating.text = state.response.rating.toString();
          price.text = state.response.price.toString();
          phone_number.text = state.response.phoneNumber.toString();
          no_of_rooms.text = state.response.noOfRoom.toString();
          hotel_Description.text = state.response.description!;

          // hotelFeatures = state.response.features!.toList(growable: true)!;

          no_of_deluxeRoom.text = state.response.noofdeluxe.toString();
          deluxe_roomSize.text = state.response.deluxesize!;
          deluxe_room_bed_details.text = state.response.deluxebadsize!;
          deluxe_room_max_capacity.text =
              state.response.deluxemaxcapacity.toString();
          deluxe_room_price.text = state.response.deluxeprice.toString();
          deluxe_room_description.text =
              state.response.deluxedescription.toString();

          no_of_semiDeluxeRoom.text = state.response.noofsemideluxe.toString();
          semiDeluxe_roomSize.text = state.response.semideluxesize!;
          semiDeluxe_room_bed_details.text = state.response.semideluxebadsize!;
          semiDeluxe_room_max_capacity.text =
              state.response.semideluxemaxcapacity.toString();
          semiDeluxe_room_price.text =
              state.response.semideluxeprice.toString();
          semiDeluxe_room_description.text =
              state.response.semideluxedescription!;

          no_of_superDeluxeRoom.text =
              state.response.noodsuperdeluxe.toString();
          superDeluxe_roomSize.text = state.response.superdeluxesize!;
          superDeluxe_room_bed_details.text =
              state.response.superdeluxebadsize!;
          superDeluxe_room_max_capacity.text =
              state.response.superdeluxemaxcapacity.toString();
          superDeluxe_room_price.text =
              state.response.superdeluxeprice.toString();
          superDeluxe_room_description.text =
              state.response.superdeluxedescription!;
        }
      },
      child: WillPopScope(
        onWillPop: () {
          context.read<HotelCubit>().getHotels();
          return popToPrevious();
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MakeMyTripColors.color30gray),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          StringConstants.addHotelTitle,
                          style: AppTextStyles.unselectedLabelStyle,
                        )),
                        20.verticalSpace,
                        Text(StringConstants.hotelInfo,
                            style: AppTextStyles.unselectedLabelStyle),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFieldView(
                              validator: (hotelname) {
                                if (hotelname.toString().isEmpty)
                                  return 'Enter the hotelName';
                                else if (hotelname!
                                    .contains(RegExp(r'[0-9]'))) {
                                  return 'Enter only text';
                                }
                              },
                              hintTextvar: StringConstants.hotelName,
                              textFieldViewController: hotelName,
                            )),
                        LongTextTextField(
                            hintTextvar: StringConstants.hotelAddress,
                            textFieldViewController: hotelAddress),
                        Row(
                          children: [
                            Expanded(
                                child: TextFieldView(
                              validator: (citid) {
                                if (citid.toString().isEmpty)
                                  return 'Enter the cityId';
                                else if (!regExp.hasMatch(citid!)) {
                                  return 'Enter only number';
                                }
                              },
                              hintTextvar: StringConstants.hotelCityId,
                              textFieldViewController: cityId,
                            )),
                            Expanded(
                                child: TextFieldView(
                              validator: (pincode) {
                                if (pincode.toString().isEmpty)
                                  return "Enter pincode";
                                else if (pincode.toString().length != 6 &&
                                    !(pincode.toString().isNumericOnly()))
                                  return 'Enter only 6 digit';
                              },
                              hintTextvar: StringConstants.hotelPincode,
                              textFieldViewController: pincode,
                            ))
                          ],
                        ),
                        20.verticalSpace,
                        Text(StringConstants.hotelDetails,
                            style: AppTextStyles.unselectedLabelStyle),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFieldView(
                                validator: (rating) {
                                  if (rating.toString().isEmpty)
                                    return 'Enter the rating';
                                  else if (!regExp.hasMatch(rating!)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar: StringConstants.hotelRating,
                                textFieldViewController: hotelRating,
                              )),
                              Expanded(
                                  child: TextFieldView(
                                validator: (price) {
                                  if (price.toString().isEmpty)
                                    return 'Enter the price';
                                  else if (!regExp.hasMatch(price!)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar: StringConstants.hotelPrice,
                                textFieldViewController: price,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFieldView(
                                validator: (phoneNumber) {
                                  if (phoneNumber.toString().isEmpty)
                                    return 'Enter the phoneNumber';
                                  else if (!regExp.hasMatch(phoneNumber!)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar: StringConstants.hotelPhoneNumber,
                                textFieldViewController: phone_number,
                              )),
                              Expanded(
                                  child: TextFieldView(
                                validator: (rooms) {
                                  if (rooms.toString().isEmpty)
                                    return 'Enter the no of rooms';
                                  else if (!regExp.hasMatch(rooms!)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar: StringConstants.hotelno_of_rooms,
                                textFieldViewController: no_of_rooms,
                              ))
                            ],
                          ),
                        ),
                        LongTextTextField(
                            hintTextvar: StringConstants.hotelDescription,
                            textFieldViewController: hotel_Description),
                        20.verticalSpace,
                        Text(StringConstants.hotelFeature,
                            style: AppTextStyles.unselectedLabelStyle),
                        Row(
                          children: [
                            CheckboxWidget(
                              value: parking,
                              title: StringConstants.parking,
                              data: hotelFeatures,
                            ),
                            CheckboxWidget(
                              value: healthy_breakfast,
                              title: StringConstants.healthyBreakfast,
                              data: hotelFeatures,
                            ),
                            CheckboxWidget(
                              value: transportation,
                              title: StringConstants.transportation,
                              data: hotelFeatures,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CheckboxWidget(
                              value: laundry,
                              title: StringConstants.laundry,
                              data: hotelFeatures,
                            ),
                            CheckboxWidget(
                              value: entertainment,
                              title: StringConstants.entertainment,
                              data: hotelFeatures,
                            ),
                            CheckboxWidget(
                              value: extra,
                              title: StringConstants.extra,
                              data: hotelFeatures,
                            ),
                          ],
                        ),
                        20.verticalSpace,
                        Text("Deluxe Room Details",
                            style: AppTextStyles.unselectedLabelStyle),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFieldView(
                                validator: (deluxeroom) {
                                  if (deluxeroom.toString().isEmpty)
                                    return 'Enter the no of deluxeroom';
                                  else if (!regExp.hasMatch(deluxeroom!)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar: "Number of Deluxe Room",
                                textFieldViewController: no_of_deluxeRoom,
                              )),
                              Expanded(
                                  child: TextFieldView(
                                validator: (deluxeroomsize) {
                                  if (deluxeroomsize.toString().isEmpty)
                                    return 'Enter the deluxeroomsize in string';
                                },
                                hintTextvar: "Deluxe Room Size (square feet)",
                                textFieldViewController: deluxe_roomSize,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFieldView(
                                validator: (deluxeroombeddetails) {
                                  if (deluxeroombeddetails.toString().isEmpty)
                                    return 'Enter the deluxeroom bed details in string';
                                },
                                hintTextvar: "Deluxe Rome bed Details",
                                textFieldViewController:
                                    deluxe_room_bed_details,
                              )),
                              Expanded(
                                  child: TextFieldView(
                                validator: (deluxeroomcapicity) {
                                  if (deluxeroomcapicity.toString().isEmpty)
                                    return 'Enter the no of deluxeroomcapicity';
                                  else if (!regExp
                                      .hasMatch(deluxeroomcapicity!)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar: "Deluxe Room Maximum Capacity",
                                textFieldViewController:
                                    deluxe_room_max_capacity,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFieldView(
                                validator: (deluxeroomprice) {
                                  if (deluxeroomprice.toString().isEmpty)
                                    return 'Enter the no of deluxeroomcapicity';
                                  else if (!regExp.hasMatch(deluxeroomprice!)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar: "Deluxe Rome Price",
                                textFieldViewController: deluxe_room_price,
                              )),
                            ],
                          ),
                        ),
                        20.verticalSpace,
                        Text("Deluxe Room Features",
                            style: AppTextStyles.unselectedLabelStyle),
                        Row(
                          children: [
                            CheckboxWidget(
                                value: internate,
                                title: "Free internet",
                                data: deluxeRoomFeatures),
                            CheckboxWidget(
                                value: coffee,
                                title: "Coffee / Tea maker",
                                data: deluxeRoomFeatures),
                            CheckboxWidget(
                                value: soundproofWall,
                                title: "Soundproof walls",
                                data: deluxeRoomFeatures),
                          ],
                        ),
                        Row(
                          children: [
                            CheckboxWidget(
                                value: smartTv,
                                title: "Smart TV with satellite",
                                data: deluxeRoomFeatures),
                            CheckboxWidget(
                                value: airCondition,
                                title: "Individually air conditioning",
                                data: deluxeRoomFeatures),
                          ],
                        ),
                        LongTextTextField(
                            hintTextvar: "Deluxe Room Description",
                            textFieldViewController: deluxe_room_description),
                        20.verticalSpace,
                        Text("Semi Deluxe Room Details",
                            style: AppTextStyles.unselectedLabelStyle),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFieldView(
                                validator: (semideluxeroom) {
                                  if (semideluxeroom.toString().isEmpty)
                                    return 'Enter the no of semideluxeroom';
                                  else if (!regExp.hasMatch(semideluxeroom!)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar: "Number of Semi Deluxe Room",
                                textFieldViewController: no_of_semiDeluxeRoom,
                              )),
                              Expanded(
                                  child: TextFieldView(
                                validator: (semideluxeroombedsize) {
                                  if (semideluxeroombedsize.toString().isEmpty)
                                    return 'Enter the deluxeroom bed size in string';
                                },
                                hintTextvar:
                                    "Semi Deluxe Room Size (square feet)",
                                textFieldViewController: semiDeluxe_roomSize,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFieldView(
                                    validator: (semideluxeroombeddetails) {
                                      if (semideluxeroombeddetails.toString().isEmpty)
                                        return 'Enter the semi deluxeroom bed details in string';
                                    },
                                hintTextvar: "Semi Deluxe Rome bed Details",
                                textFieldViewController:
                                    semiDeluxe_room_bed_details,
                              )),
                              Expanded(
                                  child: TextFieldView(
                                validator: (semideluxeroomcapacity) {
                                  if (semideluxeroomcapacity.toString().isEmpty)
                                    return 'no of semideluxeroom capacity';
                                  else if (!regExp
                                      .hasMatch(semideluxeroomcapacity!)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar:
                                    "Semi Deluxe Room Maximum Capacity",
                                textFieldViewController:
                                    semiDeluxe_room_max_capacity,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFieldView(
                                validator: (semideluxeroomprice) {
                                  if (semideluxeroomprice.toString().isEmpty)
                                    return 'no of semideluxeroom price';
                                  else if (!regExp
                                      .hasMatch(semideluxeroomprice!)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar: "Semi Deluxe Rome Price",
                                textFieldViewController: semiDeluxe_room_price,
                              )),
                            ],
                          ),
                        ),
                        20.verticalSpace,
                        Text("Semi Delux Room Features",
                            style: AppTextStyles.unselectedLabelStyle),
                        Row(
                          children: [
                            CheckboxWidget(
                                value: internate,
                                title: "Free internet",
                                data: semiDeluxeRoomFeatures),
                            CheckboxWidget(
                                value: coffee,
                                title: "Coffee / Tea maker",
                                data: semiDeluxeRoomFeatures),
                            CheckboxWidget(
                                value: soundproofWall,
                                title: "Soundproof walls",
                                data: semiDeluxeRoomFeatures),
                          ],
                        ),
                        Row(
                          children: [
                            CheckboxWidget(
                                value: smartTv,
                                title: "Smart TV with satellite",
                                data: semiDeluxeRoomFeatures),
                            CheckboxWidget(
                                value: airCondition,
                                title: "Individually air conditioning",
                                data: semiDeluxeRoomFeatures),
                          ],
                        ),
                        LongTextTextField(
                            hintTextvar: "Semi Deluxe Room Description",
                            textFieldViewController:
                                semiDeluxe_room_description),
                        20.verticalSpace,
                        Text("Super Deluxe Room Details",
                            style: AppTextStyles.unselectedLabelStyle),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFieldView(
                                validator: (superdeluxeroom) {
                                  if (superdeluxeroom.toString().isEmpty)
                                    return 'no of superdeluxeroom';
                                  else if (!regExp.hasMatch(superdeluxeroom!)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar: "Number of Super Deluxe Room",
                                textFieldViewController: no_of_superDeluxeRoom,
                              )),
                              Expanded(
                                  child: TextFieldView(
                                    validator: (superdeluxeroombedsize) {
                                      if (superdeluxeroombedsize.toString().isEmpty)
                                        return 'Enter the super deluxeroom size in string';
                                    },
                                hintTextvar:
                                    "Super Deluxe Room Size (square feet)",
                                textFieldViewController: superDeluxe_roomSize,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFieldView(
                                    validator: (superdeluxeroombeddetails) {
                                      if (superdeluxeroombeddetails.toString().isEmpty)
                                        return 'Enter the super deluxeroom bed details in string';
                                    },
                                hintTextvar: "Super Deluxe Rome bed Details",
                                textFieldViewController:
                                    superDeluxe_room_bed_details,
                              )),
                              Expanded(
                                  child: TextFieldView(
                                validator: (superdeluxeroomcapacity) {
                                  if (superdeluxeroomcapacity
                                      .toString()
                                      .isEmpty)
                                    return 'no of superdeluxeroom capicity';
                                  else if (!regExp
                                      .hasMatch(superdeluxeroomcapacity!)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar:
                                    "Super Deluxe Room Maximum Capacity",
                                textFieldViewController:
                                    superDeluxe_room_max_capacity,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFieldView(
                                validator: (superdeluxeroomprice) {
                                  if (superdeluxeroomprice.toString().isEmpty)
                                    return 'no of superdeluxeroom price';
                                  else if (!regExp
                                      .hasMatch(superdeluxeroomprice!)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar: "Super Deluxe Rome Price",
                                textFieldViewController: superDeluxe_room_price,
                              )),
                            ],
                          ),
                        ),
                        20.verticalSpace,
                        Text("Super Deluxe Room Features",
                            style: AppTextStyles.unselectedLabelStyle),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: [
                              CheckboxWidget(
                                  value: internate,
                                  title: "Free internet",
                                  data: superDeluxeRoomFeatures),
                              CheckboxWidget(
                                  value: coffee,
                                  title: "Coffee / Tea maker",
                                  data: superDeluxeRoomFeatures),
                              CheckboxWidget(
                                  value: soundproofWall,
                                  title: "Soundproof walls",
                                  data: superDeluxeRoomFeatures),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            CheckboxWidget(
                                value: smartTv,
                                title: "Smart TV with satellite",
                                data: superDeluxeRoomFeatures),
                            CheckboxWidget(
                                value: airCondition,
                                title: "Individually air conditioning",
                                data: superDeluxeRoomFeatures),
                          ],
                        ),
                        LongTextTextField(
                            hintTextvar: "Super Deluxe Room Description",
                            textFieldViewController:
                                superDeluxe_room_description),

                        // Text('Image path'),
                        // CommonPrimaryButton(
                        //     text: "Upload Image",
                        //     onTap: (){},
                        //     backColor: MakeMyTripColors.color30gray,
                        //     disable: false,
                        // ),
                        Center(
                            child: BlocConsumer<HotelCubit, BaseState>(
                                listener: (context, state) {
                          print(state);

                          if (state is StateOnSuccess) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GetHotelUi()),
                                (route) => false);
                          }
                        }, builder: (context, state) {
                          if (state is StateOnResponseSuccess<HotelPutModel>) {
                            return CommonPrimaryButton(
                              text: "Update hotel",
                              onTap: () {
                                print("object");
                                BlocProvider.of<HotelCubit>(context)
                                    .updateHotels(
                                  state.response.id!.toInt(),
                                  hotelName.text,
                                  int.parse(pincode.text),
                                  int.parse(cityId.text),
                                  hotelAddress.text,
                                  double.parse(hotelRating.text),
                                  int.parse(price.text),
                                  int.parse(phone_number.text),
                                  int.parse(no_of_rooms.text),
                                  hotel_Description.text,
                                  deluxe_room_bed_details.text,
                                  deluxe_room_description.text,
                                  deluxeRoomFeatures,
                                  int.parse(deluxe_room_max_capacity.text),
                                  int.parse(deluxe_room_price.text),
                                  deluxe_roomSize.text,
                                  hotelFeatures,
                                  int.parse(no_of_rooms.text),
                                  int.parse(no_of_superDeluxeRoom.text),
                                  int.parse(no_of_deluxeRoom.text),
                                  int.parse(no_of_semiDeluxeRoom.text),
                                  semiDeluxe_room_bed_details.text,
                                  semiDeluxe_room_description.text,
                                  semiDeluxeRoomFeatures,
                                  int.parse(semiDeluxe_room_max_capacity.text),
                                  int.parse(semiDeluxe_room_price.text),
                                  semiDeluxe_roomSize.text,
                                  superDeluxe_roomSize.text,
                                  superDeluxe_room_description.text,
                                  superDeluxeRoomFeatures,
                                  int.parse(superDeluxe_room_max_capacity.text),
                                  int.parse(superDeluxe_room_price.text),
                                  superDeluxe_room_bed_details.text,
                                  state.response.address!.location!.latitude,
                                  state.response.address!.location!.longitude,
                                );
                              },
                              backColor: Colors.blue,
                              disable: false,
                            );
                          } else {
                            return CommonPrimaryButton(
                              text: "Add hotel",
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<HotelCubit>(context)
                                      .addHotels(
                                          22.25,
                                          35.25,
                                          hotelName.text,
                                          int.parse(pincode.text),
                                          int.parse(cityId.text),
                                          hotelAddress.text,
                                          int.parse(hotelRating.text),
                                          int.parse(price.text),
                                          int.parse(phone_number.text),
                                          int.parse(no_of_rooms.text),
                                          hotel_Description.text,
                                          deluxe_room_bed_details.text,
                                          deluxe_room_description.text,
                                          deluxeRoomFeatures,
                                          int.parse(
                                              deluxe_room_max_capacity.text),
                                          int.parse(deluxe_room_price.text),
                                          deluxe_roomSize.text,
                                          hotelFeatures,
                                          int.parse(no_of_rooms.text),
                                          int.parse(no_of_superDeluxeRoom.text),
                                          int.parse(no_of_deluxeRoom.text),
                                          int.parse(no_of_semiDeluxeRoom.text),
                                          semiDeluxe_room_bed_details.text,
                                          semiDeluxe_room_description.text,
                                          semiDeluxeRoomFeatures,
                                          int.parse(
                                              semiDeluxe_room_max_capacity
                                                  .text),
                                          int.parse(semiDeluxe_room_price.text),
                                          semiDeluxe_roomSize.text,
                                          superDeluxe_roomSize.text,
                                          superDeluxe_room_description.text,
                                          superDeluxeRoomFeatures,
                                          int.parse(
                                              superDeluxe_room_max_capacity
                                                  .text),
                                          int.parse(
                                              superDeluxe_room_price.text),
                                          superDeluxe_room_bed_details.text);
                                }
                              },
                              backColor: Colors.blue,
                              disable: false,
                            );
                          }
                        }))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  popToPrevious() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => GetHotelUi()),
        (route) => false);
  }
}

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
  // List<String> hotelConstantFeatures = [
  //   "Laundry",
  //   "Transportation",
  //   "Entertainment",
  //   "Parking",
  //   "Healthy Breakfast"
  // ];

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    const pattern = r'^[0-9]+$';
    const pincodePattern = r'^[1-9]{1}[0-9]{2}[0-9]{3}';
    final regExp = RegExp(pattern);
    final regex = RegExp(pincodePattern);
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

          hotelFeatures.addAll(state.response.features!);
          deluxeRoomFeatures.addAll(state.response.deluxefeatures!);

          semiDeluxeRoomFeatures.addAll(state.response.semideluxefeatures!);
          //print(state.response.semideluxefeatures);
          superDeluxeRoomFeatures.addAll(state.response.superdeluxefeatures!);
          //print(state.response.superdeluxefeatures);

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
                                const hotelPattern = r'^[a-zA-Z0-9_.-]*$';
                                final regExp = RegExp(hotelPattern);
                                if (hotelname.toString().isEmpty ||
                                    hotelname.toString().trim().isEmpty)
                                  return 'Enter the hotelName';
                                else if (!regExp.hasMatch(hotelname!)){
                                  return 'not use others letter';
                                }
                              },
                              hintTextvar: StringConstants.hotelName,
                              textFieldViewController: hotelName,
                            )),
                        LongTextTextField(
                            validator: (hoteladdress) {
                              if (hoteladdress.toString().isEmpty ||
                                  hoteladdress.toString().trim().isEmpty)
                                return 'Enter the hotel address';
                              else if (hoteladdress.toString().length > 200) {
                                return 'No more than 200 letter';
                              }
                            },
                            hintTextvar: StringConstants.hotelAddress,
                            textFieldViewController: hotelAddress),
                        Row(
                          children: [
                            Expanded(
                                child: TextFieldView(
                              inputType: TextInputType.number,
                              validator: (citid) {
                                if (citid.toString().isEmpty ||
                                    citid.toString().trim().isEmpty)
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
                              inputType: TextInputType.number,
                              validator: (pincode) {
                                if (pincode.toString().isEmpty ||
                                    pincode.toString().trim().isEmpty)
                                  return "Enter pincode";
                                else if (pincode.toString().length > 6)
                                  return 'enter only 6 digit pincode number';
                                else if (!regex.hasMatch(pincode!))
                                  return 'Enter 6 digit pincode number';
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
                                  if (rating.toString().isEmpty ||
                                      rating.toString().trim().isEmpty)
                                    return 'Enter the rating';
                                  else if (double.parse(rating!.toString()) > 5)
                                    return 'add maximum rating 5';
                                  else if (!regExp.hasMatch(rating)) {
                                    return 'Enter only number';
                                  }
                                },
                                hintTextvar: StringConstants.hotelRating,
                                textFieldViewController: hotelRating,
                              )),
                              Expanded(
                                  child: TextFieldView(
                                validator: (price) {
                                  if (price.toString().isEmpty ||
                                      price.toString().trim().isEmpty)
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
                                inputType: TextInputType.number,
                                validator: (phoneNumber) {
                                  if (phoneNumber.toString().isEmpty ||
                                      phoneNumber.toString().trim().isEmpty)
                                    return 'Enter the phoneNumber';
                                  else if (phoneNumber.toString().length > 10 ||
                                      phoneNumber.toString().length < 10)
                                    return "Enter 10 digit phone number";
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
                                  if (rooms.toString().isEmpty ||
                                      rooms.toString().trim().isEmpty)
                                    return 'Enter the no of rooms';
                                  else if (int.parse(rooms.toString()) > 100)
                                    return 'add maximum 100 rooms';
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
                            validator: (hoteldescription) {
                              if (hoteldescription.toString().isEmpty ||
                                  hoteldescription.toString().trim().isEmpty)
                                return 'Enter the hotel Description';
                              else if (hoteldescription.toString().length >
                                  200) {
                                return 'No more than 200 letter';
                              }
                            },
                            hintTextvar: StringConstants.hotelDescription,
                            textFieldViewController: hotel_Description),
                        20.verticalSpace,
                        Text(StringConstants.hotelFeature,
                            style: AppTextStyles.unselectedLabelStyle),

                        BlocBuilder<HotelCubit, BaseState>(
                            builder: (context, state) {
                          return Wrap(
                            children: List.generate(
                              StringConstants.hotelConstantFeatures.length,
                              (index) => CheckboxWidget(
                                value:(state is StateOnResponseSuccess<HotelPutModel>)? hotelFeatures
                                    .contains(StringConstants.hotelConstantFeatures[index]):false,
                                title: StringConstants.hotelConstantFeatures[index],
                                data: hotelFeatures,
                              ),
                            ),
                          );
                        }),

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
                                  if (deluxeroom.toString().isEmpty ||
                                      deluxeroom.toString().trim().isEmpty)
                                    return 'Enter the no of deluxeroom';
                                  else if (int.parse(deluxeroom.toString()) >
                                      100)
                                    return 'add maximum 100 rooms';
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
                                  if (deluxeroomsize.toString().isEmpty ||
                                      deluxeroomsize.toString().trim().isEmpty)
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
                                  if (deluxeroombeddetails.toString().isEmpty ||
                                      deluxeroombeddetails
                                          .toString()
                                          .trim()
                                          .isEmpty)
                                    return 'Enter the deluxeroom bed details in string';
                                },
                                hintTextvar: "Deluxe Rome bed Details",
                                textFieldViewController:
                                    deluxe_room_bed_details,
                              )),
                              Expanded(
                                  child: TextFieldView(
                                validator: (deluxeroomcapicity) {
                                  if (deluxeroomcapicity.toString().isEmpty ||
                                      deluxeroomcapicity
                                          .toString()
                                          .trim()
                                          .isEmpty)
                                    return 'Enter the no of deluxeroomcapicity';
                                  else if (int.parse(
                                          deluxeroomcapicity.toString()) >
                                      4)
                                    return 'maximum capacity only 4';
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
                                  if (deluxeroomprice.toString().isEmpty ||
                                      deluxeroomprice.toString().trim().isEmpty)
                                    return 'Enter the deluxe room price';
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

                        BlocBuilder<HotelCubit, BaseState>(
                            builder: (context, state) {
                              return Wrap(
                                children: List.generate(
                                  StringConstants.deluxehotelConstantFeatures.length,
                                      (index) => CheckboxWidget(
                                    value:(state is StateOnResponseSuccess<HotelPutModel>)? deluxeRoomFeatures
                                        .contains(StringConstants.deluxehotelConstantFeatures[index]):false,
                                    title: StringConstants.deluxehotelConstantFeatures[index],
                                    data: deluxeRoomFeatures,
                                  ),
                                ),
                              );
                            }),

                        LongTextTextField(
                            validator: (deluxehoteldescription) {
                              if (deluxehoteldescription.toString().isEmpty ||
                                  deluxehoteldescription
                                      .toString()
                                      .trim()
                                      .isEmpty)
                                return 'Enter the hotel Description';
                              else if (deluxehoteldescription
                                      .toString()
                                      .length >
                                  200) {
                                return 'No more than 200 letter';
                              }
                            },
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
                                  if (semideluxeroom.toString().isEmpty ||
                                      semideluxeroom.toString().trim().isEmpty)
                                    return 'Enter the no of semideluxeroom';
                                  else if (int.parse(
                                          semideluxeroom.toString()) >
                                      100)
                                    return 'maximum capacity only 100';
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
                                  if (semideluxeroombedsize
                                          .toString()
                                          .isEmpty ||
                                      semideluxeroombedsize
                                          .toString()
                                          .trim()
                                          .isEmpty)
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
                                  if (semideluxeroombeddetails
                                          .toString()
                                          .isEmpty ||
                                      semideluxeroombeddetails
                                          .toString()
                                          .trim()
                                          .isEmpty)
                                    return 'Enter the semi deluxeroom bed details';
                                },
                                hintTextvar: "Semi Deluxe Rome bed Details",
                                textFieldViewController:
                                    semiDeluxe_room_bed_details,
                              )),
                              Expanded(
                                  child: TextFieldView(
                                validator: (semideluxeroomcapacity) {
                                  if (semideluxeroomcapacity
                                          .toString()
                                          .isEmpty ||
                                      semideluxeroomcapacity
                                          .toString()
                                          .trim()
                                          .isEmpty)
                                    return 'no of semideluxeroom capacity';
                                  else if (int.parse(
                                          semideluxeroomcapacity.toString()) >
                                      4)
                                    return 'maximum capacity only 4';
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
                                  if (semideluxeroomprice.toString().isEmpty ||
                                      semideluxeroomprice
                                          .toString()
                                          .trim()
                                          .isEmpty)
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

                        BlocBuilder<HotelCubit, BaseState>(
                            builder: (context, state) {
                              return Wrap(
                                children: List.generate(
                                  StringConstants.semideluxehotelConstantFeatures.length,
                                      (index) => CheckboxWidget(
                                    value:(state is StateOnResponseSuccess<HotelPutModel>)? semiDeluxeRoomFeatures
                                        .contains(StringConstants.semideluxehotelConstantFeatures[index]):false,
                                    title: StringConstants.semideluxehotelConstantFeatures[index],
                                    data: semiDeluxeRoomFeatures,
                                  ),
                                ),
                              );
                            }),

                        LongTextTextField(
                            validator: (semideluxehoteldescription) {
                              if (semideluxehoteldescription
                                      .toString()
                                      .isEmpty ||
                                  semideluxehoteldescription
                                      .toString()
                                      .trim()
                                      .isEmpty)
                                return 'Enter the hotel Description';
                              else if (semideluxehoteldescription
                                      .toString()
                                      .length >
                                  200) {
                                return 'No more than 200 letter';
                              }
                            },
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
                                  if (superdeluxeroom.toString().isEmpty ||
                                      superdeluxeroom.toString().trim().isEmpty)
                                    return 'no of superdeluxeroom';
                                  else if (int.parse(
                                          superdeluxeroom.toString()) >
                                      100)
                                    return 'maximum capacity only 100';
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
                                  if (superdeluxeroombedsize
                                          .toString()
                                          .isEmpty ||
                                      superdeluxeroombedsize
                                          .toString()
                                          .trim()
                                          .isEmpty)
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
                                  if (superdeluxeroombeddetails
                                          .toString()
                                          .isEmpty ||
                                      superdeluxeroombeddetails
                                          .toString()
                                          .trim()
                                          .isEmpty)
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
                                          .isEmpty ||
                                      superdeluxeroomcapacity
                                          .toString()
                                          .trim()
                                          .isEmpty)
                                    return 'no of superdeluxeroom capicity';
                                  else if (int.parse(
                                          superdeluxeroomcapacity.toString()) >
                                      4)
                                    return 'maximum capacity only 4';
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
                                  if (superdeluxeroomprice.toString().isEmpty ||
                                      superdeluxeroomprice
                                          .toString()
                                          .trim()
                                          .isEmpty)
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

                        BlocBuilder<HotelCubit, BaseState>(
                            builder: (context, state) {
                              return Wrap(
                                children: List.generate(
                                  StringConstants.superdeluxehotelConstantFeatures.length,
                                      (index) => CheckboxWidget(
                                    value:(state is StateOnResponseSuccess<HotelPutModel>)? superDeluxeRoomFeatures
                                        .contains(StringConstants.superdeluxehotelConstantFeatures[index]):false,
                                    title: StringConstants.superdeluxehotelConstantFeatures[index],
                                    data: superDeluxeRoomFeatures,
                                  ),
                                ),
                              );
                            }),

                        LongTextTextField(
                            validator: (superdeluxehoteldescription) {
                              if (superdeluxehoteldescription
                                      .toString()
                                      .isEmpty ||
                                  superdeluxehoteldescription
                                      .toString()
                                      .trim()
                                      .isEmpty)
                                return 'Enter the hotel Description';
                              else if (superdeluxehoteldescription
                                      .toString()
                                      .length >
                                  200) {
                                return 'No more than 200 letter';
                              }
                            },
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
                                if (_formKey.currentState!.validate() &&
                                    hotelFeatures.isNotEmpty &&
                                    deluxeRoomFeatures.isNotEmpty &&
                                    semiDeluxeRoomFeatures.isNotEmpty &&
                                    superDeluxeRoomFeatures.isNotEmpty) {
                                  BlocProvider.of<HotelCubit>(context)
                                      .addHotels(
                                          22.25,
                                          35.25,
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
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "add all the data!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          MakeMyTripColors.colorRed,
                                      textColor: MakeMyTripColors.colorWhite,
                                      fontSize: 16.0);
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

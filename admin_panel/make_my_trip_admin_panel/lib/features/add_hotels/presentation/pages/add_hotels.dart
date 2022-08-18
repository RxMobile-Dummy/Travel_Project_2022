import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/cubit/hotel_cubit.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/checkBoxWidget.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/lognText_textField.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/textFieldWidget.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';
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
    return BlocListener<HotelCubit, BaseState>(
      listener: (context, state) {
        if(state is StateOnSuccess){
          Fluttertoast.showToast(
              msg: "This is Center Short Toast",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MakeMyTripColors.color30gray),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                        'Add Hotels',
                        style: AppTextStyles.unselectedLabelStyle,
                      )),
                  20.verticalSpace,
                  Text("Hotel Info", style: AppTextStyles.unselectedLabelStyle),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFieldView(
                        hintTextvar: "Hotel Name",
                        textFieldViewController: hotelName,
                      )),
                  LongTextTextField(
                      hintTextvar: "Hotel Address",
                      textFieldViewController: hotelAddress),
                  Row(
                    children: [
                      Expanded(
                          child: TextFieldView(
                            hintTextvar: "City Id",
                            textFieldViewController: cityId,
                          )),
                      Expanded(
                          child: TextFieldView(
                            hintTextvar: "Pincode",
                            textFieldViewController: pincode,
                          ))
                    ],
                  ),
                  20.verticalSpace,
                  Text("Hotel Details",
                      style: AppTextStyles.unselectedLabelStyle),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFieldView(
                              hintTextvar: "Rating",
                              textFieldViewController: hotelRating,
                            )),
                        Expanded(
                            child: TextFieldView(
                              hintTextvar: "Price",
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
                              hintTextvar: "Phone Number",
                              textFieldViewController: phone_number,
                            )),
                        Expanded(
                            child: TextFieldView(
                              hintTextvar: "Number of Rooms",
                              textFieldViewController: no_of_rooms,
                            ))
                      ],
                    ),
                  ),
                  LongTextTextField(
                      hintTextvar: "Hotel Description",
                      textFieldViewController: hotel_Description),
                  20.verticalSpace,
                  Text("Features", style: AppTextStyles.unselectedLabelStyle),
                  Row(
                    children: [
                      CheckboxWidget(
                        value: parking,
                        title: "Parking",
                        data: hotelFeatures,
                      ),
                      CheckboxWidget(
                        value: healthy_breakfast,
                        title: "Healthy Breakfast",
                        data: hotelFeatures,
                      ),
                      CheckboxWidget(
                        value: transportation,
                        title: "Transportation",
                        data: hotelFeatures,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CheckboxWidget(
                        value: laundry,
                        title: "Laundry",
                        data: hotelFeatures,
                      ),
                      CheckboxWidget(
                        value: entertainment,
                        title: "Entertainment",
                        data: hotelFeatures,
                      ),
                      CheckboxWidget(
                        value: extra,
                        title: "Extra",
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
                              hintTextvar: "Number of Deluxe Room",
                              textFieldViewController: no_of_deluxeRoom,
                            )),
                        Expanded(
                            child: TextFieldView(
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
                              hintTextvar: "Deluxe Rome bed Details",
                              textFieldViewController: deluxe_room_bed_details,
                            )),
                        Expanded(
                            child: TextFieldView(
                              hintTextvar: "Deluxe Room Maximum Capacity",
                              textFieldViewController: deluxe_room_max_capacity,
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
                              hintTextvar: "Number of Semi Deluxe Room",
                              textFieldViewController: no_of_semiDeluxeRoom,
                            )),
                        Expanded(
                            child: TextFieldView(
                              hintTextvar: "Semi Deluxe Room Size (square feet)",
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
                              hintTextvar: "Semi Deluxe Rome bed Details",
                              textFieldViewController: semiDeluxe_room_bed_details,
                            )),
                        Expanded(
                            child: TextFieldView(
                              hintTextvar: "Semi Deluxe Room Maximum Capacity",
                              textFieldViewController: semiDeluxe_room_max_capacity,
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
                      textFieldViewController: semiDeluxe_room_description),
                  20.verticalSpace,
                  Text("Super Deluxe Room Details",
                      style: AppTextStyles.unselectedLabelStyle),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFieldView(
                              hintTextvar: "Number of Super Deluxe Room",
                              textFieldViewController: no_of_superDeluxeRoom,
                            )),
                        Expanded(
                            child: TextFieldView(
                              hintTextvar: "Super Deluxe Room Size (square feet)",
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
                              hintTextvar: "Super Deluxe Rome bed Details",
                              textFieldViewController: superDeluxe_room_bed_details,
                            )),
                        Expanded(
                            child: TextFieldView(
                              hintTextvar: "Super Deluxe Room Maximum Capacity",
                              textFieldViewController: superDeluxe_room_max_capacity,
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
                      textFieldViewController: superDeluxe_room_description),
                  Center(
                    child: CommonPrimaryButton(
                      text: "Add hotel",
                      onTap: () {
                        BlocProvider.of<HotelCubit>(context).addHotels
                          (
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
                            superDeluxe_room_bed_details.text);
                        // BlocProvider.of<HotelCubit>(context).demo(hotelName.text, int.parse(price.text), hotelAddress.text,semiDeluxeRoomFeatures); },
                      },
                      backColor: Colors.blue,
                      disable: false,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

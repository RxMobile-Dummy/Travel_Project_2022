import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/checkBoxWidget.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/lognText_textField.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/textFieldWidget.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';

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
  bool airCondition=false;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    CheckboxWidget(value: parking, title: "Parking"),
                    CheckboxWidget(
                        value: healthy_breakfast, title: "Healthy Breakfast"),
                    CheckboxWidget(
                        value: transportation, title: "Transportation"),
                  ],
                ),
                Row(
                  children: [
                    CheckboxWidget(value: laundry, title: "Laundry"),
                    CheckboxWidget(
                        value: entertainment, title: "Entertainment"),
                    CheckboxWidget(value: extra, title: "Extra"),
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
                Text("Deluxe Room Features", style: AppTextStyles.unselectedLabelStyle),
                Row(
                  children: [
                    CheckboxWidget(value: internate, title: "Free internet"),
                    CheckboxWidget(
                        value:coffee, title: "Coffee / Tea maker"),
                    CheckboxWidget(
                        value:soundproofWall, title: "Soundproof walls"),
                  ],
                ),
                Row(
                  children: [
                    CheckboxWidget(value: smartTv, title: "Smart TV with satellite"),
                    CheckboxWidget(
                        value: airCondition, title: "Individually air conditioning"),
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
                Text("Semi Delux Room Features", style: AppTextStyles.unselectedLabelStyle),
                Row(
                  children: [
                    CheckboxWidget(value: internate, title: "Free internet"),
                    CheckboxWidget(
                        value:coffee, title: "Coffee / Tea maker"),
                    CheckboxWidget(
                        value:soundproofWall, title: "Soundproof walls"),
                  ],
                ),
                Row(
                  children: [
                    CheckboxWidget(value: smartTv, title: "Smart TV with satellite"),
                    CheckboxWidget(
                        value: airCondition, title: "Individually air conditioning"),
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
                Text("Super Deluxe Room Features", style: AppTextStyles.unselectedLabelStyle),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: Row(
                    children: [
                      CheckboxWidget(value: internate, title: "Free internet"),
                      CheckboxWidget(
                          value:coffee, title: "Coffee / Tea maker"),
                      CheckboxWidget(
                          value:soundproofWall, title: "Soundproof walls"),
                    ],
                  ),
                ),
                Row(
                  children: [
                    CheckboxWidget(value: smartTv, title: "Smart TV with satellite"),
                    CheckboxWidget(
                        value: airCondition, title: "Individually air conditioning"),
                  ],
                ),
                LongTextTextField(
                    hintTextvar: "Super Deluxe Room Description",
                    textFieldViewController: superDeluxe_room_description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

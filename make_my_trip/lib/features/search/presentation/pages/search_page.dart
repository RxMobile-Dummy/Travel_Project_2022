import 'package:flutter/material.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

class SearchHotelPage extends StatelessWidget {
  const SearchHotelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants.searchPageTitle,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: StringConstants.searchPageTitle,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  )),
            ),
            20.verticalSpace,
            FractionallySizedBox(
                widthFactor: .4,
                child: CommonPrimaryButton(
                    text: "Search",
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RoutesName.hotelList, (route) => true);
                    }))
          ],
        ),
      ),
    );
  }
}

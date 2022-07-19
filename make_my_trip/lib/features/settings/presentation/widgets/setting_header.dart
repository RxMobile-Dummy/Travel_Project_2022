import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomSheet bottomSheet = BottomSheet(
        onClosing: () {},
        builder: (context2) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Upload Picture"),
                onTap: () {},
              ),
            ],
          );
        });

    return Container(
        padding: const EdgeInsets.all(18),
        width: double.infinity,
        color: MakeMyTripColors.colorBlack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 66,
                    child: CircleAvatar(
                      backgroundColor: MakeMyTripColors.color90gray,
                      radius: 64,
                      child: Icon(
                        Icons.person,
                        size: 100,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: MakeMyTripColors.color90gray),
                            shape: BoxShape.circle,
                            color: MakeMyTripColors.colorWhite),
                        child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return bottomSheet;
                                  });
                            },
                            child: const Icon(
                              Icons.edit,
                              color: MakeMyTripColors.colorBlack,
                              size: 22,
                            )),
                      ))
                ],
              ),
            )
          ],
        ));
  }
}

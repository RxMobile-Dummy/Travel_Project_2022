import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog(
      {required this.strMessage, required this.callBackOfDeleteBtn, Key? key})
      : super(key: key);
  final String strMessage;
  final Function() callBackOfDeleteBtn;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        width: 310,
        margin: const EdgeInsets.only(
            left: 10.0, top: 20.0, bottom: 20.0, right: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(strMessage,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(double.infinity, 40),
                        fixedSize: const Size(double.infinity, 40),
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        callBackOfDeleteBtn();
                      },
                      child: const Text(
                        'Delete?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    )),
                const SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: MakeMyTripColors.color10gray,
                        onPrimary: MakeMyTripColors.color30gray,
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(double.infinity, 40),
                        fixedSize: const Size(double.infinity, 40),
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

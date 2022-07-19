import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';

class ShowAlertDialog {
  static Future<bool?> show(BuildContext context, String errorMessage,
      {String positiveButtonText = "OK",
      String? negativeButtonText,
      TextStyle? errorMessageStyle}) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          content: Wrap(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: errorMessageStyle ??
                        Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      negativeButtonText != null &&
                              negativeButtonText.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                              child: MaterialButton(
                                minWidth: 100,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                padding: EdgeInsets.zero,
                                color: const Color(0Xffe54d60),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    negativeButtonText,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: MaterialButton(
                          minWidth: 100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          padding: EdgeInsets.zero,
                          color: MakeMyTripColors.accentColor,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Text(
                              positiveButtonText,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

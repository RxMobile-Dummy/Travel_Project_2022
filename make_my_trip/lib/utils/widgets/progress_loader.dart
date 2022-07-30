import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'dart:io' show Platform;

import 'card_view.dart';

class ProgressDialog {
  static GlobalKey<State> keyLoader = GlobalKey<State>();
  static bool isDialogVisible = false;

  static Future<void> showLoadingDialog(BuildContext context,
      {String message = "Please wait..."}) async {
    isDialogVisible = true;
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              key: keyLoader,
              onWillPop: () async => false,
              child: Theme(
                data: Theme.of(context).copyWith(
                  cupertinoOverrideTheme:
                      const CupertinoThemeData(brightness: Brightness.light),
                ),
                child: Material(
                    color: Colors.transparent,
                    child: Center(
                        child: Container(
                      constraints: const BoxConstraints(minWidth: 220),
                      child: CardView(
                          backgroudColor: Platform.isIOS
                              ? const Color(0xffe4e6e9)
                              : Colors.white,
                          margin: const EdgeInsets.all(20),
                          child: Platform.isIOS
                              ? Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    alignment: WrapAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const CupertinoActivityIndicator(
                                            animating: true,
                                            radius: 20,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            message,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          )
                                        ],
                                      ),
                                    ],
                                  ))
                              : Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: MakeMyTripColors.color90gray,
                                            strokeWidth: 2,
                                          )),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            message,
                                            style: AppTextStyles
                                                .labelDescriptionStyle,
                                          ),
                                        ),
                                      )
                                    ],
                                  ))),
                    ))),
              ));
        });
  }

  static hideLoadingDialog(BuildContext context) {
    if (isDialogVisible) {
      Navigator.of(context, rootNavigator: false).pop();
    }
    isDialogVisible = false;
  }
}

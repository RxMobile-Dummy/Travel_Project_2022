import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key, required this.title, required this.viewAll})
      : super(key: key);
  final String title;
  final String viewAll;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.unselectedLabelStyle),
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  FirebaseAuth.instance.signInAnonymously();
                });
              },
              child: Text(viewAll, style: AppTextStyles.unselectedLabelStyle)),
        ],
      ),
    );
  }
}

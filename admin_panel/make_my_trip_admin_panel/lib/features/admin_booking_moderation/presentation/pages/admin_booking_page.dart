import 'package:flutter/material.dart';

class AdminBookingPage extends StatelessWidget {
  const AdminBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(flex: 2, child: Text("hello")),
          Expanded(
              flex: 8,
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: Column(
                            children: [

                            ],
                          ),

                        );
                      }),
                ],
              )),
        ],
      ),
    );
  }
}

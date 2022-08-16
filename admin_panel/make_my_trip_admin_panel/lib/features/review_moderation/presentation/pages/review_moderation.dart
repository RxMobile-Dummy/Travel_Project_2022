import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/utils/constants/image_path.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip_admin_panel/utils/widgets/common_primary_button.dart';

class ReviewModeration extends StatelessWidget {
  const ReviewModeration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: MakeMyTripColors.accentColor.withOpacity(.2),
              )),
          Expanded(
            flex: 8,
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: DataTable(columns: [
                  DataColumn(
                    label: Text('ID'),
                  ),
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('Code'),
                  ),
                  DataColumn(
                    label: Text('Quantity'),
                  ),
                  DataColumn(
                    label: Text('Amount'),
                  ),
                ], rows: [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('Arshik')),
                    DataCell(Text('5644645')),
                    DataCell(Text('3')),
                    DataCell(Text('265\$')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('Arshik')),
                    DataCell(Text('5644645')),
                    DataCell(Text('3')),
                    DataCell(Text('265\$')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('Arshik')),
                    DataCell(Text('5644645')),
                    DataCell(Text('3')),
                    DataCell(Text('265\$')),
                  ])
                ])

                // child: ListView.builder(
                //     itemCount: 2,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         decoration: BoxDecoration(
                //             border:
                //                 Border.all(color: MakeMyTripColors.color10gray),
                //             borderRadius: BorderRadius.circular(12)),
                //         child: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.only(
                //                   left: 12, right: 12, top: 12, bottom: 4),
                //               child: Row(
                //                 children: [
                //                   Expanded(
                //                     flex: 3,
                //                     child: Row(
                //                       children: [
                //                         Image.asset(
                //                           ImagePath.userDefaultImg,
                //                           width: 32,
                //                         ),
                //                         12.horizontalSpace,
                //                         Text(
                //                           "Lorem Ipsum",
                //                           style: AppTextStyles.infoContentStyle4
                //                               .copyWith(
                //                                   color: MakeMyTripColors
                //                                       .colorBlack),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   Expanded(
                //                     flex: 1,
                //                     child: Row(
                //                       children: [
                //                         Expanded(
                //                           child: CommonPrimaryButton(
                //                             text: "Approve",
                //                             onTap: () {},
                //                             backColor: Colors.green,
                //                           ),
                //                         ),
                //                         12.horizontalSpace,
                //                         Expanded(
                //                           child: CommonPrimaryButton(
                //                             text: "Reject",
                //                             onTap: () {},
                //                             backColor:
                //                                 MakeMyTripColors.colorRed,
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             const Divider(),
                //             Padding(
                //               padding: const EdgeInsets.only(
                //                   left: 12, right: 12, top: 8, bottom: 12),
                //               child: Column(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: [
                //                   Container(
                //                     padding: const EdgeInsets.all(10),
                //                     decoration: BoxDecoration(
                //                         border: Border.all(
                //                             color:
                //                                 MakeMyTripColors.color10gray),
                //                         borderRadius:
                //                             BorderRadius.circular(12)),
                //                     child: Text(
                //                       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                //                       style: AppTextStyles.labelDescriptionStyle
                //                           .copyWith(
                //                               fontSize: 14,
                //                               color:
                //                                   MakeMyTripColors.colorBlack),
                //                     ),
                //                   ),
                //                   // 12.verticalSpace,
                //                   // Container(
                //                   //     width: double.infinity,
                //                   //     padding: const EdgeInsets.all(10),
                //                   //     decoration: BoxDecoration(
                //                   //         border: Border.all(
                //                   //             color:
                //                   //                 MakeMyTripColors.color10gray),
                //                   //         borderRadius:
                //                   //             BorderRadius.circular(12)),
                //                   //     child: Wrap(
                //                   //       spacing: 10,
                //                   //       runSpacing: 10,
                //                   //       children: List.generate(
                //                   //           4,
                //                   //           (index) => ClipRRect(
                //                   //                 borderRadius:
                //                   //                     BorderRadius.circular(8),
                //                   //                 child: Image.asset(
                //                   //                   ImagePath.roomImg,
                //                   //                   width: 50,
                //                   //                   height: 50,
                //                   //                   fit: BoxFit.cover,
                //                   //                 ),
                //                   //               )),
                //                   //     )),
                //                 ],
                //               ),
                //             )
                //           ],
                //         ),
                //       );
                //     })
                ),
          ),
        ],
      ),
    );
  }
}

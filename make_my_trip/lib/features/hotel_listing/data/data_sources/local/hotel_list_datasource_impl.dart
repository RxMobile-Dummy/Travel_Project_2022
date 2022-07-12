import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:make_my_trip/features/hotel_listing/data/data_sources/local/hotel_list_datasource.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/hotel_list_model.dart';

class Hotel_List_DataSource_Impl extends Hotel_List_DataSource {
  Future<List<HotelListModel>> get_hotel_list(String s) async {
    final response =
        await http.get(Uri.parse('http://192.168.101.164:4000/hotel/${s}'));
    var data = jsonDecode(response.body.toString());
    List<HotelListModel> postlist = [];
    {
      for (Map i in data) {
        postlist.add(HotelListModel.fromJson(i));
      }

      return postlist;
    }
  }
}

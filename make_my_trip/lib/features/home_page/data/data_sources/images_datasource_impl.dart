import 'dart:convert';

import 'package:make_my_trip/features/home_page/data/data_sources/images_datasource.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';
import 'package:http/http.dart' as http;

class Imagesdatasource_impl extends Imagesdatasource {
  Stream<List<ImageModel>> getlist() async* {
    yield* Stream.periodic(Duration(seconds: 0), (_) async {
      final response = await http
          .get(Uri.parse('http://192.168.101.164:4000/hotel/image/5'));
      var data = jsonDecode(response.body.toString());
      List<ImageModel> postlist = [];
      {
        for (Map i in data) {
          postlist.add(ImageModel.fromJson(i));
        }
      }
      return postlist;
    }).asyncMap((event) async => await event);
  }
}


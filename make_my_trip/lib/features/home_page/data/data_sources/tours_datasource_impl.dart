import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:make_my_trip/features/home_page/data/data_sources/tours_datasource.dart';
import '../../../../core/failures/failures.dart';
import '../models/ToursModel.dart';

class Tours_DataSource_impl extends ToursDataSource {

  Future<Either<Failures,List<ToursModel>>> get_tours() async{
     try {
       final response =
       await http.get(Uri.parse('http://192.168.101.164:4000/tour/10'));
       var data = jsonDecode(response.body.toString());
       List<ToursModel> postlist = [];
       {
         for (Map i in data) {
           postlist.add(ToursModel.fromJson(i));
         }
       }
       return Right(postlist);
     }
     catch(e){
       return Left(ServerFailure(failureMsg: e.toString()));
     }
  }
}

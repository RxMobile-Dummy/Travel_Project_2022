import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/local/hotel_list_datasource.dart';

import '../../../../core/failures/failures.dart';
import '../../domain/repositories/hotel_list_repository.dart';
import '../models/hotel_list_model.dart';

class Hotel_List_Repository_Impl extends Hotel_List_Repository {
  Hotel_List_DataSource hotel_list_dataSource;

  Hotel_List_Repository_Impl({required this.hotel_list_dataSource});

  @override
  Future<Either<Failures,List<HotelListModel>>> get_hotel_list(String s) async{
    var reponse =await hotel_list_dataSource.get_hotel_list(s);

    return reponse;
  }
}

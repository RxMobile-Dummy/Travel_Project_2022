import 'package:make_my_trip/features/home_page/domain/repositories/images_repository.dart';

class images_usecase {
  final Imagesrepository imagesrepository;

  images_usecase({required this.imagesrepository});

  call(Map map) async{
    return await imagesrepository.getimages();
  }
}

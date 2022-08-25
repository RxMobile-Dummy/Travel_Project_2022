import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelModels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelPutModel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/add_hotel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/add_image.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/delete_hotel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/get_hotel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/get_hotelUpdate.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/get_hotel_images.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/update_hotel.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

class HotelCubit extends Cubit<BaseState> {
  PostHotel postHotel;
  GetAllHotel getHotel;
  DeleteHotel deleteHotel;
  GetHotelPut getHotelPut;
  UpdateHotel updateHotel;
  AddHotelImage addImage;
  GetHotelIamges getHotelImage;

  HotelCubit(
      {required this.postHotel,
      required this.getHotel,
      required this.deleteHotel,
      required this.getHotelPut,
      required this.updateHotel,
      required this.addImage,
      required this.getHotelImage
      })
      : super(StateInitial()) {
    getHotels();
  }

  List<HotelModels> hotelList = [];
  List<HotelModels> filterList = [];

  List<PlatformFile> hotelImages=[];
  List<PlatformFile> deluxeImages=[];
  List<PlatformFile> semiDeluxeImages=[];
  List<PlatformFile> superDeluxeImages=[];
  int page = -1;
  addHotels(
      double? latitude,
      double? logitude,
      String hotelname,
      int pincode,
      int city_id,
      String address_line,
      double rating,
      int price,
      int phonenumber,
      int no_rooms,
      String description,
      String deluxebadsize,

      String deluxedescription,
      List<String> deluxefeatures,
      int deluxemaxcapacity,
      int deluxeprice,
      String deluxesize,
      List<String> hotelFeatures,
      int no_of_room,
      int noodsuperdeluxe,
      int noofdeluxe,
      int noofsemideluxe,
      String semideluxebadsize,
      String semideluxedescription,
      List<String> semideluxefeatures,
      int semideluxemaxcapacity,
      int semideluxeprice,
      String semideluxesize,
      String superdeluxebadsize,
      String superdeluxedescription,
      List<String> superdeluxefeatures,
      int superdeluxemaxcapacity,
      int superdeluxeprice,
      String superdeluxesize) async {
    var res = await postHotel.call(Hotel(
        address: Address(
            address_line: address_line,
            pincode: pincode,
            city_id: city_id,
            location: Location(latitude: latitude!, longitude: logitude!)),
        deluxebadsize: deluxebadsize,
        deluxedescription: deluxedescription,
        deluxefeatures: deluxefeatures,
        deluxemaxcapacity: deluxemaxcapacity,
        deluxeprice: deluxeprice,
        deluxesize: deluxesize,
        features: hotelFeatures,
        hotel_name: hotelname,
        no_of_room: no_of_room,
        noodsuperdeluxe: noodsuperdeluxe,
        noofdeluxe: noofdeluxe,
        noofsemideluxe: noofsemideluxe,
        phone_number: phonenumber,
        price: price,
        rating: rating,
        semideluxebadsize: semideluxebadsize,
        semideluxedescription: semideluxedescription,
        semideluxefeatures: semideluxefeatures,
        semideluxemaxcapacity: semideluxemaxcapacity,
        semideluxeprice: semideluxeprice,
        semideluxesize: semideluxesize,
        superdeluxebadsize: superdeluxebadsize,
        superdeluxedescription: superdeluxedescription,
        superdeluxefeatures: superdeluxefeatures,
        superdeluxemaxcapacity: superdeluxemaxcapacity,
        superdeluxeprice: superdeluxeprice,
        superdeluxesize: superdeluxesize,
        description: description));
    res.fold(
      (failure) {
        print("failure");
        emit(StateNoData());
      },
      (success) {
        print("success");
        getHotels();
      },
    );
  }

  updateHotels(
      int id,
      String hotelname,
      int pincode,
      int city_id,
      String address_line,
      double rating,
      int price,
      int phonenumber,
      int no_rooms,
      String description,
      String deluxebadsize,
      String deluxedescription,
      List<String> deluxefeatures,
      int deluxemaxcapacity,
      int deluxeprice,
      String deluxesize,
      List<String> hotelFeatures,
      int no_of_room,
      int noodsuperdeluxe,
      int noofdeluxe,
      int noofsemideluxe,
      String semideluxebadsize,
      String semideluxedescription,
      List<String> semideluxefeatures,
      int semideluxemaxcapacity,
      int semideluxeprice,
      String semideluxesize,
      String superdeluxebadsize,
      String superdeluxedescription,
      List<String> superdeluxefeatures,
      int superdeluxemaxcapacity,
      int superdeluxeprice,
      String superdeluxesize,
      latitude,
      logitude) async {
    var res = await updateHotel.call(HotelPutModel(
        id: id,
        address: Addresss(
            pincode: pincode,
            cityId: city_id,
            addressLine: address_line,
            location: Locationn(longitude: logitude, latitude: latitude)),
        deluxebadsize: deluxebadsize,
        deluxedescription: deluxedescription,
        deluxefeatures: deluxefeatures,
        deluxemaxcapacity: deluxemaxcapacity,
        deluxeprice: deluxeprice,
        deluxesize: deluxesize,
        features: hotelFeatures,
        hotelName: hotelname,
        noOfRoom: no_of_room,
        noodsuperdeluxe: noodsuperdeluxe,
        noofdeluxe: noofdeluxe,
        noofsemideluxe: noofsemideluxe,
        phoneNumber: phonenumber,
        price: price,
        rating: rating,
        semideluxebadsize: semideluxebadsize,
        semideluxedescription: semideluxedescription,
        semideluxefeatures: semideluxefeatures,
        semideluxemaxcapacity: semideluxemaxcapacity,
        semideluxeprice: semideluxeprice,
        semideluxesize: semideluxesize,
        superdeluxebadsize: superdeluxebadsize,
        superdeluxedescription: superdeluxedescription,
        superdeluxefeatures: superdeluxefeatures,
        superdeluxemaxcapacity: superdeluxemaxcapacity,
        superdeluxeprice: superdeluxeprice,
        superdeluxesize: superdeluxesize,
        description: description));
    res.fold(
      (failure) {
        print("failure");
        emit(StateNoData());
      },
      (success) {
        print("success");
        emit(StateLoading());
        getHotels();
      },
    );
  }

  demo(String hotelname, int price, String address,
      List<String> semiDeluxeRoomFeatures) async {

  }

  getHotels() async {
    try {
      if (state is! StateOnSuccess) {
        emit(StateLoading());
      } else {
        emit(StateOnSuccess<List<HotelModels>>(hotelList, isMoreLoading: true));
      }
      page++;
      var res = await getHotel.call(page);
      res.fold((l) {
        print("failure");
        emit(StateErrorGeneral("errorMessage"));
      }, (r) {
        print("success");
        for (var item in r) {
          hotelList.add(item);
        }
        emit(StateOnSuccess<List<HotelModels>>(hotelList,isMoreLoading: false));
      });
    } catch (er) {
    }
  }
  void setUpScrollController(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          getHotels();
        }
      }
    });
  }

  getPutHotel(String id) async {
    emit(StateLoading());
    var res = await getHotelPut.call(id);
    res.fold((l) {
      print("failure");
      emit(StateErrorGeneral("errorMessage"));
    }, (r) {
      print("success");
      emit(StateOnResponseSuccess<HotelPutModel>(r));
    });
  }

  deleteHotels(String id) async {
    var res = await deleteHotel.call(id);
    res.fold(
      (failure) {
        emit(StateErrorGeneral("Failure"));
      },
      (success) {
        getHotels();
        // emit(StateOnSuccess(success));
      },
    );
  }

  void searchList(String searchKeyWord) {
    emit(StateLoading());
    filterList = [];
    for (var item in hotelList) {
      if (item.hotelName!.toLowerCase().contains(searchKeyWord.toLowerCase()) ||
          item.address!.addressLine!
              .toString()
              .toLowerCase()
              .contains(searchKeyWord.toLowerCase())) {
        filterList.add(item);
      }
    }
    if (filterList.isEmpty) {
      emit(StateNoData());  
    } else {
      emit(StateOnSuccess(filterList));
    }
  }

  addHotelImages(String path) async{
    var res = await addImage.call(ImagesParams(path));
    res.fold((l) => emit(StateErrorGeneral("errorMessage")), (r) => print("Success"));
  }
  
  getHotelImagess(String type) async{
    emit(StateLoading());
    var res = await getHotelImage.call(ImagesParamss(type));
    res.fold((l) =>
        emit(StateDialogErrorGeneral("errorMessage")),
            (r) {
      if(type == StringConstants.selectHotelImage) {
        hotelImages.addAll(r);
      } else if(type == StringConstants.selectDeluxeImage) {
        deluxeImages.addAll(r);
      } else if(type == StringConstants.selectSemiDeluxeImage) {
        semiDeluxeImages.addAll(r);
      } else{
        superDeluxeImages.addAll(r);
      }
      emit(StateOnKnownToSuccess(""));
    });
  }

  // getFromGallery() async {
  //   XFile? pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     emit(StateOnSuccess<String>(response : pickedFile.path));
  //   } else {
  //     emit(StateErrorGeneral("Error GetFromGallery"));
  //   }
  // }

  selectImages() async {
    List<XFile>? imageFileList=[];
    final ImagePicker imagePicker = ImagePicker();
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      emit(StateReorderSuccess(imageFileList));
    }
  }
}

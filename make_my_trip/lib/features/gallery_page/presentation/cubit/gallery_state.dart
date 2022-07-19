part of 'gallery_cubit.dart';

@immutable
var galleryPage = GalleryPage();

abstract class GalleryState {}

class GalleryInitial extends GalleryState {}

class GalleryChangedPage extends GalleryState {
  final int index;

  GalleryChangedPage(this.index);
}

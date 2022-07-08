import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_bar_state.dart';

class TabBarCubit extends Cubit<TabBarState> {
  TabBarCubit() : super(TabBarInitial()){
    OnItemTap(0);
  }
  OnItemTap(index){

   emit(OnItemTapState(index));
   return index;
  }
}

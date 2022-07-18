import 'package:bloc/bloc.dart';
import 'package:make_my_trip/features/home_page/presentation/manager/cubit/tab_bar_state.dart';

class TabBarCubit extends Cubit<TabBarState> {
  TabBarCubit() : super(TabBarInitial()) {
    onItemTap(0);
  }
  onItemTap(index) {
    emit(OnItemTapState(index));
    return index;
  }
}

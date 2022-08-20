import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/domain/use_cases/admin_login_use_cases.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/domain/use_cases/logout_use_cases.dart';
import 'package:make_my_trip_admin_panel/features/admin_login/domain/use_cases/validate_admin_use_cases.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'package:make_my_trip_admin_panel/utils/validations/user_info/user_information_validations.dart';

class AdminLoginCubit extends Cubit<BaseState> {
  AdminLoginCubit(this.adminLoginUseCases, this.adminValidationUseCases,
      this.logOutUseCases)
      : super(StateInitial());

  final AdminLoginUseCases adminLoginUseCases;
  final AdminValidationUseCases adminValidationUseCases;
  final LogOutUseCases logOutUseCases;

  void changeObSecureEvent(bool obSecureValue) {
    emit(StateOnSuccess(!obSecureValue));
  }

  signInWithEmail(String loginEmail, String loginPassword) async {
    emit(StateLoading());
    final emailValidation =
        UserInfoValidation.emailAddressValidation(loginEmail);
    if (emailValidation != null) {
      emit(StateErrorGeneral(StringConstants.emailValidationErrorMessage));
    } else {
      final passwordValidation =
          UserInfoValidation.passwordValidation(loginPassword);
      if (passwordValidation != null) {
        emit(StateErrorGeneral(StringConstants.passwordValidationErrorMessage));
      } else {
        final res = await adminLoginUseCases
            .call(LoginParams(email: loginEmail, password: loginPassword));

        res.fold((failure) {
          if (failure is AuthFailure) {
            emit(StateErrorGeneral(failure.failureMsg!));
          }
        }, (success) async {
          final result = await adminValidationUseCases.call(NoParams());
          result.fold((l) {
            if (l is AuthFailure) {
              emit(StateErrorGeneral(l.failureMsg!));
            } else {
              emit(StateErrorGeneral(l.toString()));
            }
          },
              (r) => emit(
                  StateOnKnownToSuccess(StringConstants.loginSuccessMessage)));
        });
      }
    }
  }

  logOutEvent() async {
    emit(StateLoading());
    final res = await logOutUseCases.call(NoParams());
    res.fold((failure) {
      emit(StateErrorGeneral("Logout Error"));
    }, (success) {
      emit(StateOnSuccess("logout success"));
    });
  }

  void changeViewEvent(String viewName) {
    emit(StateOnResponseSuccess(viewName));
  }
}

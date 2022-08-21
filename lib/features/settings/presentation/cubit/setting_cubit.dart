import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/models/medicine_model.dart';
import 'package:eksouvan/core/models/medicine_type_mode.dart';
import 'package:eksouvan/core/models/user_model.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/field_keys.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/features/diagnose/domain/useases/add_new_medicine_usecase.dart';
import 'package:eksouvan/features/diagnose/domain/useases/get_all_medicines_usecase.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/medicine_type.dart';
import '../../../home/domain/usecases/get_logout_usecase.dart';
import '../../domain/usecases/add_medicine_type_usecase.dart';
import '../../domain/usecases/create_user_usecase.dart';
import '../../domain/usecases/delete_medicine_type_usecase.dart';
import '../../domain/usecases/get_all_user_usecase.dart';
import '../../domain/usecases/get_lang_usecase.dart';
import '../../domain/usecases/get_medicine_type_usecase.dart';
import '../../domain/usecases/save_user_usecase.dart';
import '../../domain/usecases/set_lang_usecase.dart';

@injectable
class SettingCubit extends Cubit<SettingState> {
  final GetLogoutUsecase getLogoutUsecase;
  final GetLanguageUsecase getLanguageUsecase;
  final SetLanguageUsecase setLanguageUsecase;
  final GetAllUserUsecase getAllUserUsecase;
  final CreateuserUsecase createuserUsecase;
  final SaveUserUsecase saveUserUsecase;
  final GetAllMedicineUsecase getAllMedicineUsecase;
  final GetMedicineTypeUsecase getMedicineTypeUsecase;
  final AddMedicineTypeUsecase addMedicineTypeUsecase;
  final DeleteMedicineTypeUsecase deleteMedicineTypeUsecase;
  final AddNewMedicineUsecase addNewMedicineUsecase;
  SettingCubit(
      this.getLogoutUsecase,
      this.getLanguageUsecase,
      this.setLanguageUsecase,
      this.getAllUserUsecase,
      this.createuserUsecase,
      this.saveUserUsecase,
      this.getAllMedicineUsecase,
      this.getMedicineTypeUsecase,
      this.addMedicineTypeUsecase,
      this.deleteMedicineTypeUsecase,
      this.addNewMedicineUsecase)
      : super(const SettingState());
  bool lang = false;
  final formAddUserKey = GlobalKey<FormBuilderState>();
  final medicineKey = GlobalKey<FormBuilderState>();
  final medicineTypeKey = GlobalKey<FormBuilderState>();
  String? userUuid;
  Map<String, dynamic> formValue = {};
  String? pickedMedicine;
  List<MedicineType>? listMedicineType;

  Future<void> getLogout() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getLogoutUsecase(NoParams());
    result.fold(
        (l) =>
            emit(state.copyWith(dataStatus: DataStatus.failure, error: l.msg)),
        (r) {
      emit(state.copyWith(dataStatus: DataStatus.success));
      AppNavigator.pushAndRemoveUntil(AppRoute.loginRoute);
    });
  }

  Future<void> getLang() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getLanguageUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (la) {
      if (la == Languages.loCode || la == "") {
        lang = false;
      } else {
        lang = true;
      }
      emit(state.copyWith(dataStatus: DataStatus.success));
    });
  }

  Future<void> setLang({required String langCode}) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result =
        await setLanguageUsecase(SetLanguageParams(langCode: langCode));
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) {
      print(success);
      emit(state.copyWith(dataStatus: DataStatus.success));
    });
  }

  Future<void> onChangedLang(
      {required isCheck, required BuildContext context}) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    lang = isCheck;
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (lang == false) {
        context.setLocale(const Locale(Languages.loCode));
        await setLang(langCode: Languages.loCode);
      } else {
        context.setLocale(const Locale(Languages.enCode));
        await setLang(langCode: Languages.enCode);
      }
    });
    emit(state.copyWith(dataStatus: DataStatus.success));
  }

  Future<void> getAllUser() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getAllUserUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) {
      print(success);
      emit(state.copyWith(dataStatus: DataStatus.success, listUser: success));
    });
  }

  Future<void> createNewUser() async {
    if (formAddUserKey.currentState!.saveAndValidate()) {
      emit(state.copyWith(dataStatus: DataStatus.loading));
      formValue.addAll({...formAddUserKey.currentState?.value ?? {}});
      final result = await createuserUsecase(CreateuserUsecaseParams(
          email: formValue[FieldKeys.kEmail],
          password: formValue[FieldKeys.kPassword]));
      result.fold(
          (error) => emit(
              state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
          (uid) async {
        formValue.addAll({FieldKeys.kDocId: uid});
        UserModel data = UserModel.fromJson(formValue);
        final res = await saveUserUsecase(SaveUserUsecaseParams(data: data));
        res.fold(
            (error) => emit(state.copyWith(
                dataStatus: DataStatus.failure, error: error.msg)), (r) {
          emit(state.copyWith(dataStatus: DataStatus.success));
          AppNavigator.goBackWithData();
        });
      });
    }
  }

  Future<void> getMedicineType() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getMedicineTypeUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (medicineType) {
      listMedicineType = medicineType;
      emit(state.copyWith(
        dataStatus: DataStatus.success,
        listMedicineType: medicineType,
      ));
    });
  }

  String getMedicineTypeName({String? id}) {
    if (id != null || id != "") {
      var data = listMedicineType?.where((el) => el.id == id).first;
      return data?.medicineType ?? '';
    } else {
      return "";
    }
  }

  Future<void> getAllMedicine() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getAllMedicineUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (r) {
      emit(state.copyWith(dataStatus: DataStatus.success, listMedicine: r));
    });
  }

  Future<void> onSaveMedicine() async {
    if (medicineKey.currentState!.saveAndValidate()) {
      emit(state.copyWith(dataStatus: DataStatus.loading));
      Map<String, dynamic> formData = medicineKey.currentState?.value ?? {};
      MedicineModel data = MedicineModel.fromJson(formData);
      final result = await addNewMedicineUsecase(AddNewMedicineParams(data));
      result.fold(
          (error) => emit(
              state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
          (success) async {
        emit(state.copyWith(dataStatus: DataStatus.success));
        AppNavigator.goBack();
        await getAllMedicine();
      });
    }
  }

  Future<void> onSaveMedicineType() async {
    if (medicineTypeKey.currentState!.saveAndValidate()) {
      emit(state.copyWith(dataStatus: DataStatus.loading));
      Map<String, dynamic> formData = medicineTypeKey.currentState?.value ?? {};
      MedicineTypeMedel data = MedicineTypeMedel.fromJson(formData);
      final result = await addMedicineTypeUsecase(
          AddMedicineTypeUsecaseParams(data: data));
      result.fold(
          (error) => emit(
              state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
          (success) async {
        emit(state.copyWith(dataStatus: DataStatus.success));
        AppNavigator.goBack();
        await getMedicineType();
      });
    }
  }

  Future<void> deleteMedicineType({required String id}) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result =
        await deleteMedicineTypeUsecase(DeleteMedicineTypeParams(id: id));
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) async {
      emit(state.copyWith(dataStatus: DataStatus.success));
      await getMedicineType();
    });
  }
}

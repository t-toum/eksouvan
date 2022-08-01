import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/entities/medicine.dart';
import 'package:eksouvan/core/models/medicine_model.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/enum.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/features/diagnose/data/model/deases_model.dart';
import 'package:eksouvan/features/diagnose/domain/entity/deases.dart';
import 'package:eksouvan/features/diagnose/domain/useases/add_deases_usecase.dart';
import 'package:eksouvan/features/diagnose/domain/useases/get_all_deases_usecase.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/dropdown_item.dart';
import '../../../histories/domain/usecases/get_all_patient_usecase.dart';
import '../../../histories/domain/usecases/get_patient_usecase.dart';
import '../../../home/domain/usecases/get_current_user_usecase.dart';
import '../../domain/useases/add_diagnose_usecase.dart';
import '../../domain/useases/add_new_medicine_usecase.dart';
import '../../domain/useases/get_all_medicines_usecase.dart';
import 'diagnose_state.dart';

@injectable
class DiagnoseCubit extends Cubit<DiagnoseState> {
  final GetAllPatientUsecase getAllPatientUsecase;
  final AddDiagnoseUsecase addDiagnoseUsecase;
  final GetCUrrentUserUsecase getCUrrentUserUsecase;
  final GetPatientUsecase getPatientUsecase;
  final GetAllDeaseUsecase getAllDeaseUsecase;
  final AddDeasesUsecase addDeasesUsecase;
  final GetAllMedicineUsecase getAllMedicineUsecase;
  final AddNewMedicineUsecase addNewMedicineUsecase;
  final Uuid uuid;
  DiagnoseCubit(
      this.getAllPatientUsecase,
      this.addDiagnoseUsecase,
      this.getCUrrentUserUsecase,
      this.getPatientUsecase,
      this.uuid,
      this.getAllDeaseUsecase,
      this.addDeasesUsecase,
      this.getAllMedicineUsecase,
      this.addNewMedicineUsecase)
      : super(const DiagnoseState());
  TextEditingController searchController = TextEditingController();
  final patientKey = GlobalKey<FormBuilderState>();
  final desaesKey = GlobalKey<FormBuilderState>();
  final medicineKey = GlobalKey<FormBuilderState>();
  final DateTime currentDate = DateTime.now();

  //Deases
  List<Deases?> listDeases = [];
  List<Medicine?> listMedicine = [];

  String? currentUserId;
  List<DropdwonItems> genderList = [
    DropdwonItems(id: 1, name: LocaleKeys.kMale.tr()),
    DropdwonItems(id: 2, name: LocaleKeys.kFemale.tr())
  ];

  //FormValue

  Future<void> getAllPatient() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final results = await getAllPatientUsecase(NoParams());
    results.fold((error) {
      emit(state.copyWith(dataStatus: DataStatus.failure, error: error.msg));
    }, (data) {
      emit(state.copyWith(dataStatus: DataStatus.success, listPatient: data));
    });
  }

  Future<void> getCurrentUser() async {
    final result = await getCUrrentUserUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (data) {
      currentUserId = data;
    });
  }

  Future<void> getPatientById({required String id}) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getPatientUsecase(GetPatientParams(patientId: id));
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (patient) {
      emit(state.copyWith(dataStatus: DataStatus.success, patient: patient));
    });
  }

  Future<void> getAllDease() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final results = await getAllDeaseUsecase(NoParams());
    results.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (deases) {
      emit(state.copyWith(dataStatus: DataStatus.success, listDeases: deases));
    });
  }

  Future<void> addPatientDiagnose() async {
    // if (formKey.currentState!.saveAndValidate()) {
    //   emit(state.copyWith(dataStatus: DataStatus.loading));
    //   Map<String, dynamic> formValue = {};
    //   final String diagnoseId = uuid.v4();
    //   Map<String, dynamic> formData = {};
    //   formData.addAll({
    //     FieldKeys.kDiagnoseDate: currentDate,
    //     FieldKeys.kUserId: currentUserId,
    //     FieldKeys.kPatientId: patient?.patientId,
    //     FieldKeys.kDiagnoseId: diagnoseId,
    //     ...formKey.currentState?.value ?? {}
    //   });
    //   var fromConvert = ConvertDatas.convertMapData(mapData: formData);
    //   DiagnoseModel diagnose = DiagnoseModel.fromJson(fromConvert);
    //   formValue.addAll({
    //     FieldKeys.kLastUpdate: currentDate.toString(),
    //     FieldKeys.kDiagnoses: FieldValue.arrayUnion([diagnose.toJson()]),
    //   });
    //   final result = await addDiagnoseUsecase(AddDiagnoseParams(
    //       patientId: patient?.patientId ?? '', data: formValue));
    //   result.fold((error) {
    //     emit(state.copyWith(dataStatus: DataStatus.failure, error: error.msg));
    //   }, (success) {
    //     emit(state.copyWith(dataStatus: DataStatus.success));
    //     AppNavigator.navigateTo(AppRoute.successRoute,
    //         params: SuccessParams(
    //             title: LocaleKeys.kRegisterToDiagnose.tr(),
    //             buttonTitle: LocaleKeys.kNextToDiagnose.tr(),
    //             onPressed: () {
    //               AppNavigator.navigateTo(
    //                   AppRoute.dailyDiagnosePatientPageRoute,
    //                   params: success);
    //             }));
    //   });
    // } else {
    //   print("validate form");
    // }
  }

  Future<void> saveDeases() async {
    if (desaesKey.currentState!.saveAndValidate()) {
      emit(state.copyWith(dataStatus: DataStatus.loading));
      Map<String, dynamic> formValue =
          desaesKey.currentState?.value as Map<String, dynamic>;
      DeasesModel deasesModel = DeasesModel.fromJson(formValue);
      final result =
          await addDeasesUsecase(AddDeaseParams(deasesModel: deasesModel));
      result.fold(
          (l) => emit(
              state.copyWith(dataStatus: DataStatus.failure, error: l.msg)),
          (r) {
        emit(state.copyWith(dataStatus: DataStatus.success));
        AppNavigator.goBack();
      });
    } else {
      print('Not validate');
    }
  }

  Future<void> getAllMedicine() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final results = await getAllMedicineUsecase(NoParams());
    results.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (listData) {
      emit(state.copyWith(
          dataStatus: DataStatus.success, listMedicine: listData));
    });
  }

  Future<void> addNewMedicine() async {
    if (medicineKey.currentState!.saveAndValidate()) {
      emit(state.copyWith(dataStatus: DataStatus.loading));
      Map<String, dynamic> formValue =
          medicineKey.currentState?.value as Map<String, dynamic>;
      MedicineModel data = MedicineModel.fromJson(formValue);
      final result = await addNewMedicineUsecase(AddNewMedicineParams(data));
      result.fold(
          (l) => emit(
              state.copyWith(dataStatus: DataStatus.failure, error: l.msg)),
          (r) {
        emit(state.copyWith(dataStatus: DataStatus.success));
        AppNavigator.goBack();
      });
    }
  }

  void nextPage({required DiagnosePage currenPage}) {
    switch (currenPage) {
      case DiagnosePage.patient:
        if (patientKey.currentState!.saveAndValidate()) {
          AppNavigator.navigateTo(AppRoute.symptomRoute);
        } else {
          print('Patient validate invalid');
        }
        break;
      case DiagnosePage.deases:
        if (listDeases.isNotEmpty) {
          emit(state.copyWith(
            dataStatus: DataStatus.success,
            error: null,
          ));
          AppNavigator.navigateTo(AppRoute.medicineRoute);
        } else {
          emit(state.copyWith(
            dataStatus: DataStatus.failure,
            error: LocaleKeys.kWarnningSelectDeases.tr(),
          ));
        }
        break;
      case DiagnosePage.medicine:
        if (listMedicine.isNotEmpty) {
          emit(state.copyWith(
            dataStatus: DataStatus.success,
            error: null,
          ));
          AppNavigator.navigateTo(AppRoute.summaryRoute);
        } else {
          emit(state.copyWith(
            dataStatus: DataStatus.failure,
            error: LocaleKeys.kWarnningSelectMedicine.tr(),
          ));
        }
        break;

      default:
        print("Page not found");
    }
  }
}

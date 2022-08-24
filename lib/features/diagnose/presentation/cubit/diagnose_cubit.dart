import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/entities/medicine.dart';
import 'package:eksouvan/core/entities/medicine_type.dart';
import 'package:eksouvan/core/models/medicine_model.dart';
import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/convert_datas.dart';
import 'package:eksouvan/core/utils/enum.dart';
import 'package:eksouvan/core/utils/field_keys.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/features/diagnose/data/model/deases_model.dart';
import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';
import 'package:eksouvan/features/diagnose/domain/entity/deases.dart';
import 'package:eksouvan/features/diagnose/domain/useases/add_deases_usecase.dart';
import 'package:eksouvan/features/diagnose/domain/useases/get_all_deases_usecase.dart';
import 'package:eksouvan/features/register/data/model/patient_model.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/usecases/next_page_params.dart';
import '../../../../core/utils/dropdown_item.dart';
import '../../../histories/domain/usecases/get_all_patient_usecase.dart';
import '../../../histories/domain/usecases/get_patient_usecase.dart';
import '../../../home/domain/usecases/get_current_user_usecase.dart';
import '../../../settings/domain/usecases/get_medicine_type_usecase.dart';
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
  final GetMedicineTypeUsecase getMedicineTypeUsecase;
  DiagnoseCubit(
      this.getAllPatientUsecase,
      this.addDiagnoseUsecase,
      this.getCUrrentUserUsecase,
      this.getPatientUsecase,
      this.uuid,
      this.getAllDeaseUsecase,
      this.addDeasesUsecase,
      this.getAllMedicineUsecase,
      this.addNewMedicineUsecase,
      this.getMedicineTypeUsecase)
      : super(const DiagnoseState());
  TextEditingController searchController = TextEditingController();
  final patientKey = GlobalKey<FormBuilderState>();
  final desaesKey = GlobalKey<FormBuilderState>();
  final medicineKey = GlobalKey<FormBuilderState>();
  final DateTime currentDate = DateTime.now();

  //Deases
  List<Deases?> listDeases = [];
  List<Medicine?> listMedicine = [];
  List<MedicineType>? listMedicineType;

  String? currentUserId;
  List<DropdwonItems> genderList = [
    DropdwonItems(id: 1, name: LocaleKeys.kMale.tr()),
    DropdwonItems(id: 2, name: LocaleKeys.kFemale.tr())
  ];

  //FormValue
  Map<String, dynamic> formValue = {};

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
      formValue.addAll({...(patient as PatientModel).toJson()});
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
    emit(state.copyWith(dataStatus: DataStatus.loading));
    formValue[FieldKeys.kDiagnoseDate] = DateTime.now().toString();
    var formData = ConvertDatas.convertMapData(mapData: formValue);
    formData[FieldKeys.kDeases] =
        listDeases.map((e) => (e as DeasesModel).toJson()).toList();
    formData[FieldKeys.kMedicine] =
        listMedicine.map((e) => (e as MedicineModel).toJson()).toList();
    DiagnoseModel data = DiagnoseModel.fromJson(formData);
    final result = await addDiagnoseUsecase(AddDiagnoseParams(data: data));
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (cuccess) {
      emit(state.copyWith(dataStatus: DataStatus.success));
      AppNavigator.pushAndRemoveUntil(AppRoute.addDiagnoseSuccessRoute,
          params: data.patientId);
    });
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
        emit(state.copyWith(dataStatus: DataStatus.saveDeaseSuccess));
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
      ));
    });
  }

  String getMedicineTypeName({String? id}) {
    String? name;
    if (id != null || id != "") {
      listMedicineType?.forEach((el) {
        if (el.id == id) {
          name = el.medicineType;
        }
      });
      return name ?? '';
    } else {
      return name ?? '';
    }
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
        emit(state.copyWith(dataStatus: DataStatus.saveMedicineSucess));
      });
    }
  }

  void nextPage({required NextPageParams nextPageParams}) {
    switch (nextPageParams.diagnosePage) {
      case DiagnosePage.patient:
        if (patientKey.currentState!.saveAndValidate()) {
          formValue.addAll({
            ...patientKey.currentState?.value as Map<String, dynamic>,
          });
          AppNavigator.navigateTo(AppRoute.symptomRoute,
              params: nextPageParams.cubit);
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
          formValue[FieldKeys.kDeases] = listDeases;
          AppNavigator.navigateTo(AppRoute.medicineRoute,
              params: nextPageParams.cubit);
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
          formValue[FieldKeys.kMedicine] = listMedicine;
          AppNavigator.navigateTo(AppRoute.summaryRoute,
              params: nextPageParams.cubit);
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

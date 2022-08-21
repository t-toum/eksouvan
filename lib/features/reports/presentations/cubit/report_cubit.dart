import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/convert_datas.dart';
import 'package:eksouvan/features/histories/domain/usecases/get_all_patient_usecase.dart';
import 'package:eksouvan/features/reports/presentations/cubit/report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../register/domain/entity/patient.dart';

@injectable
class ReportCubit extends Cubit<ReportState> {
  final GetAllPatientUsecase getAllPatientUsecase;
  ReportCubit(this.getAllPatientUsecase) : super(const ReportState());
  DateTime? startDate;

  DateTime? enddate = DateTime.now();
  List<Patient>? listPatient;

  Future<void> getAppatient() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getAllPatientUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) {
      listPatient = success;
      emit(
          state.copyWith(dataStatus: DataStatus.success, listPatient: success));
    });
  }

  void onChangeDate() {
    if (startDate != null || enddate != null) {
      emit(state.copyWith(dataStatus: DataStatus.loading));
      var newList = listPatient
          ?.where((el) =>
              ConvertDatas.converDateFormat(el.createDate)
                      .compareTo(ConvertDatas.converDateFormat(startDate)) >=
                  0 &&
              ConvertDatas.converDateFormat(el.createDate)
                      .compareTo(ConvertDatas.converDateFormat(enddate)) <=
                  0)
          .toList();
      emit(
          state.copyWith(dataStatus: DataStatus.success, listPatient: newList));
    }
  }
}

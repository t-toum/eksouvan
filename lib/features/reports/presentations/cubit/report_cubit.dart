import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/features/histories/domain/usecases/get_all_patient_usecase.dart';
import 'package:eksouvan/features/reports/presentations/cubit/report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReportCubit extends Cubit<ReportState> {
  final GetAllPatientUsecase getAllPatientUsecase;
  ReportCubit(this.getAllPatientUsecase) : super(const ReportState());

  Future<void> getAppatient() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getAllPatientUsecase(NoParams());
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) => emit(state.copyWith(
            dataStatus: DataStatus.success, listPatient: success)));
  }
}
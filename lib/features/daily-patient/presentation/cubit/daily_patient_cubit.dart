import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/features/histories/domain/usecases/get_all_patient_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'daily_patient_state.dart';

@injectable
class DailyPatientCubit extends Cubit<DailyPatientState> {
  final GetAllPatientUsecase getAllPatientUsecase;
  DailyPatientCubit(this.getAllPatientUsecase)
      : super(const DailyPatientState());

  Future<void> getDailyPatient() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final results = await getAllPatientUsecase(NoParams());
    results.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (res) {
      // res.forEach((value) {
      //   value.diagnoses.where((element) => element)
      // });
      emit(state.copyWith(dataStatus: DataStatus.success, listPatient: res));
    });
  }
}

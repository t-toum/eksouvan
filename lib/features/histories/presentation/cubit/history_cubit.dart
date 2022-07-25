import 'package:eksouvan/core/usecases/no_params.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/features/histories/domain/usecases/get_all_patient_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../register/domain/entity/patient.dart';
import '../../domain/usecases/get_patient_usecase.dart';
import 'history_state..dart';

@injectable
class HistoryCubit extends Cubit<HistoryState> {
  final GetAllPatientUsecase getAllPatientUsecase;
  final GetPatientUsecase getPatientUsecase;
  HistoryCubit(this.getAllPatientUsecase, this.getPatientUsecase)
      : super(const HistoryState());
  TextEditingController searchController = TextEditingController();
  Future<void> getAllPatient() async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result = await getAllPatientUsecase(NoParams());
    result.fold(
      (error) => emit(
          state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
      (success) {
        searchController.addListener(() {
          if (searchController.text.isNotEmpty) {
            List<Patient> newList = success
                .where(
                  (patient) =>
                      patient.firstname!
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase()) ||
                      patient.lastname!.toLowerCase().contains(
                            searchController.text.toLowerCase(),
                          ),
                )
                .toList();
            emit(state.copyWith(
                dataStatus: DataStatus.success, listPatient: newList));
          } else {
            emit(state.copyWith(
                dataStatus: DataStatus.success, listPatient: success));
          }
        });
        emit(state.copyWith(
            dataStatus: DataStatus.success, listPatient: success));
      },
    );
  }

  Future<void> getPatient({required String patientId}) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));
    final result =
        await getPatientUsecase(GetPatientParams(patientId: patientId));
    result.fold(
        (error) => emit(
            state.copyWith(dataStatus: DataStatus.failure, error: error.msg)),
        (success) {
      emit(state.copyWith(dataStatus: DataStatus.success, patient: success));
    });
  }
}

import 'package:eksouvan/core/utils/enum.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class NextPageParams extends Equatable {
  final DiagnosePage? diagnosePage;
  dynamic cubit;

  NextPageParams({this.diagnosePage, this.cubit});

  @override
  List<Object?> get props => [diagnosePage, cubit];
}

import 'package:equatable/equatable.dart';

class Deases extends Equatable {
  final String? deasesId;
  final String? deasesName;
  const Deases({this.deasesId, this.deasesName});

  @override
  List<Object?> get props => [deasesId, deasesName];
}

import 'package:eksouvan/core/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel(
    String? name,
    String? username,
    String? password,
    String? docId,
    String? role,
  ) : super(
          name: name,
          username: username,
          password: password,
          docId: docId,
          role: role,
        );
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ErrorModel {
  int? status;
  @JsonKey(name: "message")
  String? message;
  // @JsonKey(name: "message")
  // String? errorMessage;
  // String? errorCode;

  ErrorModel({
    this.status,
    this.message,
    // this.errorCode,
    // this.errorMessage
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'nodo_model.freezed.dart';
part 'nodo_model.g.dart';

@freezed
class NodoModel with _$NodoModel {
  const factory NodoModel({
    required String id,
    required String name,
    required bool isCompleted,
    Map<String, dynamic>? data,
  }) = _NodoModel;

  factory NodoModel.fromJson(Map<String, dynamic> json) =>
      _$NodoModelFromJson(json);
}
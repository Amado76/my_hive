// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ModuleAuthEntity extends Equatable {
  final int? id;
  final String? name;
  final String? appRoute;
  final String? iconLib;
  final String? iconName;
  final bool? isAuthorized;
  final int? order;

  const ModuleAuthEntity({
    required this.id,
    required this.name,
    required this.appRoute,
    required this.iconLib,
    required this.iconName,
    required this.isAuthorized,
    required this.order,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        appRoute,
        iconLib,
        iconName,
        isAuthorized,
        order,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:grace_church/core/extention/app_extention.dart';

 class Failure extends Equatable {
  const Failure({this.code, this.message});

  final String? message;
  final String? code;

  @override
  List<Object> get props => [code.getOrEmpty(), message.getOrEmpty()];
}
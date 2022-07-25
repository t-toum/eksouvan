import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SuccessParams extends Equatable {
  final String? title;
  final String? buttonTitle;
  final VoidCallback? onPressed;
  const SuccessParams({this.title, this.buttonTitle, this.onPressed});
  @override
  List<Object?> get props => [title, buttonTitle, onPressed];
}

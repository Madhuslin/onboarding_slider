import 'package:flutter/material.dart';

class OnboardingSliderModel {
  String title;
  String description;
  Color titleColor;
  Color descripColor;
  String imagePath;
  String svgPath;

  OnboardingSliderModel({
    @required this.title,
    @required this.description,
    this.imagePath = "",
    this.svgPath = "",
    @required this.titleColor,
    @required this.descripColor,
  });
}

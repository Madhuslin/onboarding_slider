import 'package:flutter/material.dart';

class OnboardingSliderModel {
  String title;
  String description;
  Color titleColor;
  Color descripColor;
  String imagePath;

  OnboardingSliderModel({
    @required this.title,
    @required this.description,
    @required this.imagePath,
    @required this.titleColor,
    @required this.descripColor,
  });
}

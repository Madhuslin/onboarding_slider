# onboarding slider
This is a package that extends the sk_onboarding_screen with a few extra options.  

A library that walks a user through multiple on-boarding screens in a simple and easy way
  
 [![Flutter](https://img.shields.io/badge/Platform-Flutter-blue.svg)](https://flutter.dev/)

## 💻 Installation

You just need to add `onboarding_slider` as a [dependency in your pubspec.yaml file.](https://flutter.dev/docs/development/packages-and-plugins/using-packages)

```yaml
dependencies:
onboarding_slider: ^1.0.0
```

## Usage

### Import this class

```dart
import 'package:onboarding_slider/flutter_onboarding.dart';
import 'package:onboarding_slider/onboarding_slider_model.dart';
```

## OnboardingSliderModel

```dart
  final pages = [
    OnboardingSliderModel(
        title: 'Choose your item',
        description:
            'Easily find your grocery items and you will get delivery in wide range',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/onboarding1.png'),
    OnboardingSliderModel(
        title: 'Pick Up or Delivery',
        description:
            'We make ordering fast, simple and free-no matter if you order online or cash',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/onboarding2.png'),
    OnboardingSliderModel(
        title: 'Pay quick and easy',
        description: 'Pay for order using credit or debit card',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/onboarding3.png'),
  ];
```
### Pass it into OnboardingSliderScreen Widget

```dart
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: OnboardingSliderScreen(
        bgColor: Colors.white,
        loopPages: true,
        showSkip: true,
        showgetStarted : true,
        loopDuration :const Duration(seconds:1),
        themeColor: const Color(0xFFf74269),
        pages: pages,
        skipClicked: (value) {
          print("Skip");
        },
        getStartedClicked: (value) {
          print("Get Started");
        },
      ),
    );
  }
```

## 📃License

    Copyright 2020

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

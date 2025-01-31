import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
export 'package:flutter_app/core/app_export.dart';

// ignore: must_be_immutable
class DisciplinesListItemWidget extends StatelessWidget {
  late String disciplina;
  final VoidCallback? onTapImgImage;
  DisciplinesListItemWidget({
    super.key,
    this.onTapImgImage,
    required this.disciplina,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height *
          0.12, // Convertido de 98.h para 98.0
      child: GestureDetector(
        onTap: () {
          if (onTapImgImage != null) {
            onTapImgImage!();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 0.4,
                child: CustomImageView(
                  imagePath: ImageConstant.imgRectangle15,
                  height: MediaQuery.of(context).size.height *
                      0.13, // Convertido de 98.h para 98.0
                  width: double.maxFinite,
                  radius: BorderRadius.circular(
                      24.0), // Convertido de 24.h para 24.0
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 50.0, // Convertido de 50.h para 50.0
                    bottom: 22.0, // Convertido de 22.h para 22.0
                  ),
                  child:
                      Text(disciplina, style: CustomTextStyle.fontDiscipline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomImageView extends StatelessWidget {
  const CustomImageView({
    super.key,
    required this.imagePath,
    required this.height,
    required this.width,
    required this.radius,
  });

  final String imagePath;
  final double height;
  final double width;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ImageConstant {
  static const String imgRectangle15 = 'assets/images/rectangle_16.png';
}

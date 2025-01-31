import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';

class ContainerTurmas extends StatelessWidget {
  late String turma;
  late int quantidade;
  final VoidCallback ontapImage;
  ContainerTurmas(
      {super.key,
      required this.turma,
      required this.ontapImage,
      required this.quantidade});

  @override
  Widget build(BuildContext context) {
    // debugPrint('rebuild ContainerTurmas');
    return SizedBox(
      height: MediaQuery.of(context).size.height *
          0.12, // Convertido de 98.h para 98.0
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(blurRadius: 3, offset: Offset(0, 3), color: Colors.grey)
          ],
          border: Border.all(width: 3, color: Colors.white),
          borderRadius: BorderRadius.circular(24),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
                opacity: 0.2,
                child: CustomImageView(
                  height: MediaQuery.of(context).size.height * 0.12,
                  onTap: () {},
                  width: double.maxFinite,
                  radius: BorderRadius.circular(25),
                  imagePath: ImageConstant.imgRectangle15,
                )),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50.0, // Convertido de 50.h para 50.0
                  bottom: 22.0, // Convertido de 22.h para 22.0
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/lecture_1.png',
                      width: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(turma, style: CustomTextStyle.fontTurma),
                        Text('${quantidade.toString()} alunos',
                            style: CustomTextStyle.fontButtom)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
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
    required this.onTap,
  });

  final String imagePath;
  final double height;
  final double width;
  final BorderRadius radius;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: radius,
        child: Image.asset(
          imagePath,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ImageConstant {
  static const String imgRectangle15 = 'assets/images/rectangle_20.jpeg';
}

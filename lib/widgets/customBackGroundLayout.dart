import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBackgroundLayout extends StatelessWidget {
  late Widget child1;
  late Widget child2;
  late Widget child3;
  late double heightContainer;

  CustomBackgroundLayout(
      {super.key,
      required this.child1,
      required this.child2,
      required this.child3,
      required this.heightContainer});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            // height: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: child1,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
              height: MediaQuery.of(context).size.height * heightContainer,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: child2,
            ),
          ),
          Align(alignment: const Alignment(1, -0.35), child: child3),
        ],
      ),
    );
  }
}

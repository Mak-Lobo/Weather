import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double height;

  const CustomContainer({super.key, required this.child, this.height = 300});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.inversePrimary,
            Theme.of(context).colorScheme.secondary,
          ],
          center: Alignment.center,
          radius: 1.5,
          stops: [0.3, 0.7, 0.9],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context).colorScheme.inverseSurface.withAlpha(50),
        ),
      ),
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 1.5),
        child: child,
      ),
    );
  }
}

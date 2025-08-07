import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Color bgColor, shadow;
  final Widget child;
  final bool isBorderShown;

  const CustomCard({
    required this.bgColor,
    required this.child,
    this.isBorderShown = true,
    this.shadow = Colors.transparent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      elevation: 20,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          strokeAlign: BorderSide.strokeAlignOutside,
          width: 0.75,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: shadow.withValues(alpha: 20, blue: 15),
      borderOnForeground: isBorderShown,
      child: child,
    );
  }
}

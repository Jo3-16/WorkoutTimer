import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.label,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.disableColor = Colors.grey,
    this.elevation,
    this.side = BorderSide.none,
    this.onTap,
    super.key,
  });

  final Icon icon;
  final Widget label;
  final Color? color;
  final Color? backgroundColor;
  final Color? disableColor;
  final double? elevation;
  final BorderSide side;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: color,
        shape: const StadiumBorder().copyWith(side: side),
        disabledBackgroundColor: disableColor ?? Colors.grey,
        backgroundColor: backgroundColor,
        elevation: elevation,
        padding: const EdgeInsets.symmetric( vertical: 12, horizontal: 20)
      ),
      onPressed: onTap,
      label: label,
      icon: icon,
    );
  }
}

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    required this.icon,
     this.backgroundColor,
    this.disableColor = Colors.grey,
    this.elevation,
    this.side = BorderSide.none,
    this.onTap,
    super.key,
  });

  final Icon icon;

  final Color? backgroundColor;
  final Color? disableColor;
  final double? elevation;
  final BorderSide side;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ElevatedButton.styleFrom(
          disabledBackgroundColor: disableColor ?? Colors.grey,
          backgroundColor: backgroundColor,
          elevation: elevation,
          padding: const EdgeInsets.symmetric( vertical: 12, horizontal: 20)
      ),
      onPressed: onTap,
      icon: icon,
    );
  }
}
import 'package:flutter/material.dart';

/// Configuration class for the [GlassOneNavBar].
class GlassOneStyle {
  /// Height of the navigation bar. Defaults to 72.0.
  final double height;

  /// Corner radius of the glass container. Defaults to 28.0.
  final double borderRadius;

  /// The intensity of the blur effect (BackdropFilter). Defaults to 10.0.
  final double blurSigma;

  /// Whether to trigger a light haptic feedback on tap.
  final bool enableHaptics;

  /// Custom fixed width. If null, uses adaptive logic (max 450px).
  final double? customWidth;

  /// Background color of the glass. Defaults to theme surface with opacity.
  final Color? backgroundColor;

  /// Color of the active icon/label and pill. Defaults to theme primary.
  final Color? activeColor;

  /// Color of the inactive items. Defaults to theme onSurfaceVariant.
  final Color? inactiveColor;

  /// Margin for the selection pill.
  /// Controls how much space is between the pill edges and the navbar border.
  final EdgeInsets itemPadding;

  /// Width of the external border. Defaults to 0.4.
  final double borderWidth;

  /// Custom color for the border. If null, uses adaptive theme colors.
  final Color? borderColor;

  /// Size of the icons. Defaults to 24.0.
  final double iconSize;

  /// Whether to show the text labels under the icons. Defaults to true.
  final bool showLabels;

  /// Custom text style for the labels.
  final TextStyle? labelStyle;

  const GlassOneStyle({
    this.height = 72.0,
    this.borderRadius = 28.0,
    this.blurSigma = 10.0,
    this.itemPadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    this.enableHaptics = true,
    this.customWidth,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.borderWidth = 0.4,
    this.borderColor,
    this.iconSize = 24.0,
    this.showLabels = true,
    this.labelStyle,
  });
}

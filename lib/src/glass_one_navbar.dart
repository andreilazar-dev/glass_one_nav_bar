import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/glass_one_nav_item.dart';
import 'theme/glass_one_style.dart';

class GlassOneNavBar extends StatelessWidget {
  final List<GlassOneNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final GlassOneStyle style;

  const GlassOneNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.style = const GlassOneStyle(),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final isDark = theme.brightness == Brightness.dark;

    // Adaptive width calculation
    final double adaptiveWidth = size.width > 600 ? 450.0 : size.width - 32;
    final double finalWidth = style.customWidth ?? adaptiveWidth;

    final Color effectiveBg = style.backgroundColor ??
        (isDark
            ? const Color(0xFF181818).withValues(alpha: 0.75)
            : theme.colorScheme.surface.withValues(alpha: 0.85));

    // Resolve border color based on style or theme defaults
    final Color effectiveBorderColor = style.borderColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.12)
            : Colors.black.withValues(alpha: 0.05));

    return ClipRRect(
      borderRadius: BorderRadius.circular(style.borderRadius),
      child: BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: style.blurSigma, sigmaY: style.blurSigma),
        child: Container(
          width: finalWidth,
          height: style.height,
          decoration: BoxDecoration(
            color: effectiveBg,
            borderRadius: BorderRadius.circular(style.borderRadius),
            border: Border.all(
              width: style.borderWidth,
              color: effectiveBorderColor,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(items.length, (index) {
              return _NavBarItemTile(
                item: items[index],
                isSelected: index == currentIndex,
                style: style,
                onTap: () {
                  if (style.enableHaptics) HapticFeedback.lightImpact();
                  onTap(index);
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavBarItemTile extends StatefulWidget {
  final GlassOneNavItem item;
  final bool isSelected;
  final GlassOneStyle style;
  final VoidCallback onTap;

  const _NavBarItemTile({
    required this.item,
    required this.isSelected,
    required this.style,
    required this.onTap,
  });

  @override
  State<_NavBarItemTile> createState() => _NavBarItemTileState();
}

class _NavBarItemTileState extends State<_NavBarItemTile>
    with SingleTickerProviderStateMixin {
  /// Controller for the momentary scale-down effect when clicked.
  late AnimationController _touchController;
  late Animation<double> _touchScale;

  @override
  void initState() {
    super.initState();
    _touchController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _touchScale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _touchController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(_NavBarItemTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Play the touch feedback animation only when transitioning to selected state.
    if (widget.isSelected && !oldWidget.isSelected) {
      _touchController.forward().then((_) => _touchController.reverse());
    }
  }

  @override
  void dispose() {
    _touchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = widget.style.activeColor ?? theme.colorScheme.primary;
    final inactiveColor =
        widget.style.inactiveColor ?? theme.colorScheme.onSurfaceVariant;

    // Main animation duration for the liquid transitions.
    const duration = Duration(milliseconds: 500);

    return Expanded(
      child: Semantics(
        // Accessibility: Defines the label and state for screen readers
        label: widget.item.label,
        selected: widget.isSelected,
        button: true,
        child: Tooltip(
          // Accessibility: Shows a tooltip on long press, especially useful if showLabels is false
          message: widget.item.label,
          child: GestureDetector(
            onTap: widget.onTap,
            behavior: HitTestBehavior.opaque,
            child: ScaleTransition(
              scale: _touchScale,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // --- SELECTION PILL (LIQUID GROWTH EFFECT) ---
                  AnimatedScale(
                    scale: widget.isSelected ? 1.0 : 0.0,
                    duration: duration,
                    curve:
                        widget.isSelected ? Curves.elasticOut : Curves.easeIn,
                    child: Container(
                      margin: widget.style.itemPadding,
                      decoration: BoxDecoration(
                        color: activeColor.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(
                            widget.style.borderRadius - 8),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      left: widget.style.itemPadding.left + 1,
                      right: widget.style.itemPadding.right + 1,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // ICON BOUNCE: Independent elastic scale with dynamic size.
                        AnimatedScale(
                          scale: widget.isSelected ? 1.15 : 1.0,
                          duration: duration,
                          curve: widget.isSelected
                              ? Curves.elasticOut
                              : Curves.easeInOut,
                          child: Icon(
                            widget.isSelected
                                ? widget.item.activeIcon
                                : widget.item.icon,
                            color:
                                widget.isSelected ? activeColor : inactiveColor,
                            size: widget.style.iconSize,
                          ),
                        ),

                        // LABEL: Rendered only if showLabels is true.
                        if (widget.style.showLabels) ...[
                          const SizedBox(height: 2),
                          TweenAnimationBuilder<Color?>(
                            duration: const Duration(milliseconds: 200),
                            tween: ColorTween(
                                begin: inactiveColor,
                                end: widget.isSelected
                                    ? activeColor
                                    : inactiveColor),
                            builder: (context, color, child) {
                              return ExcludeSemantics(
                                child: Text(
                                  widget.item.label,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: (widget.style.labelStyle ??
                                          const TextStyle(fontSize: 10))
                                      .copyWith(
                                    fontWeight: widget.isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: color,
                                    height:
                                        1.1, // Slight adjustment for 2 lines spacing
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

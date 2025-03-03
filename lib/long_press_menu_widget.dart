library;

import 'package:flutter/material.dart';

class LongPressMenuWidget<T> extends StatefulWidget {
  final Widget? child;
  final List<PopupMenuItem<T>> items;
  final void Function(T) onSelected;
  final void Function()? onCanceled;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;
  final void Function(TapDownDetails)? onTapDown;
  final void Function(TapUpDetails)? onTapUp;
  final void Function()? onTapCancel;
  final void Function()? onSecondaryTap;
  final void Function(TapUpDetails)? onSecondaryTapUp;
  final void Function(TapDownDetails)? onSecondaryTapDown;
  final void Function()? onSecondaryTapCancel;
  final void Function(bool)? onHighlightChanged;
  final void Function(bool)? onHover;
  final MouseCursor? mouseCursor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final double? radius;
  final BorderRadius? borderRadius;
  final ShapeBorder? customBorder;
  final bool? enableFeedback;
  final bool excludeFromSemantics;
  final FocusNode? focusNode;
  final bool canRequestFocus;
  final void Function(bool)? onFocusChange;
  final bool autofocus;
  final MaterialStatesController? statesController;
  const LongPressMenuWidget({
    super.key,
    this.child,
    required this.items,
    required this.onSelected,
    this.onCanceled,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTap,
    this.onSecondaryTapUp,
    this.onSecondaryTapDown,
    this.onSecondaryTapCancel,
    this.onHighlightChanged,
    this.onHover,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.overlayColor,
    this.splashColor,
    this.splashFactory,
    this.radius,
    this.borderRadius,
    this.customBorder,
    this.enableFeedback = true,
    this.excludeFromSemantics = false,
    this.focusNode,
    this.canRequestFocus = true,
    this.onFocusChange,
    this.autofocus = false,
    this.statesController,
  });

  @override
  State<LongPressMenuWidget<T>> createState() => _LongPressMenuWidgetState<T>();
}

class _LongPressMenuWidgetState<T> extends State<LongPressMenuWidget<T>> {
  Offset _tapPosition = Offset.zero;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: _onLongPress,
      onTapDown: _getTapPosition,
      onTap: widget.onTap,
      onDoubleTap: widget.onDoubleTap,
      onTapUp: widget.onTapUp,
      onTapCancel: widget.onTapCancel,
      onSecondaryTap: widget.onSecondaryTap,
      onSecondaryTapUp: widget.onSecondaryTapUp,
      onSecondaryTapDown: widget.onSecondaryTapDown,
      onSecondaryTapCancel: widget.onSecondaryTapCancel,
      onHighlightChanged: widget.onHighlightChanged,
      onHover: widget.onHover,
      mouseCursor: widget.mouseCursor,
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      highlightColor: widget.highlightColor,
      overlayColor: widget.overlayColor,
      splashColor: widget.splashColor,
      splashFactory: widget.splashFactory,
      radius: widget.radius,
      borderRadius: widget.borderRadius,
      customBorder: widget.customBorder,
      enableFeedback: widget.enableFeedback ?? true,
      excludeFromSemantics: widget.excludeFromSemantics,
      focusNode: widget.focusNode,
      canRequestFocus: widget.canRequestFocus,
      onFocusChange: widget.onFocusChange,
      autofocus: widget.autofocus,
      statesController: widget.statesController,
      child: widget.child,
    );
  }

  void _getTapPosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
    widget.onTapDown?.call(details);
  }

  void _onLongPress() {
    RenderObject? renderObject = context.findRenderObject();
    if (renderObject is RenderObject) {
      final RenderBox overlay =
          Overlay.of(context).context.findRenderObject() as RenderBox;
      showMenu(
        context: context,
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay.paintBounds.size.width,
                overlay.paintBounds.size.height)),
        items: widget.items,
        elevation: 8.0,
      ).then<T?>((T? newValue) {
        if (!mounted) return null;
        if (newValue == null) {
          widget.onCanceled?.call();
          return null;
        }
        widget.onSelected(newValue);
        return null;
      });
    }

    widget.onLongPress?.call();
  }
}

import 'package:flutter/material.dart';
import 'package:lawmax/global/global.dart';


class MainButton extends StatelessWidget {
  const MainButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.text,
      this.contentColor,
      this.color = primary,
      this.width,
      this.padding = const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
      this.height = 56.0,
      this.borderRadius = 18.0,
      this.disabled = false,
      this.shadow = true,
      this.view = true,
      this.loading = false,
      this.borderWidth = 0.0,
      this.borderColor = Colors.black,
      this.disabledColor = secondary})
      : super(key: key);
  final Widget child;
  final String? text;
  final Color color;
  final double? width;
  final Color? contentColor;
  final void Function() onPressed;
  final double height;
  final EdgeInsets padding;
  final double borderRadius;
  final bool disabled;
  final bool shadow;
  final Color borderColor;
  final double borderWidth;
  final Color disabledColor;
  final bool view;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    Color color =
        loading || disabled ? this.color.withOpacity(0.6) : this.color;

    Color contentColor = this.contentColor ?? Colors.white;

    Widget body = AnimatedContainer(
      height: height,
      width: width,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(width: borderWidth, color: borderColor)),
      padding: padding,
      child: Align(
        widthFactor: 1.0,
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: contentColor,
            fontWeight: FontWeight.w500,
          ),
          child: IconTheme(
            data: Theme.of(context).iconTheme.copyWith(color: contentColor),
            child: loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : text != null
                    ? Text(
                        text!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : child,
          ),
        ),
      ),
    );

    if (!disabled && !loading) {
      body = TouchableScale(onPressed: onPressed, child: body);
    }

    return Material(
      color: Colors.transparent,
      child: view ? body : const SizedBox(),
    );
  }
}

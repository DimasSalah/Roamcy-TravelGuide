// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../constant/constant.dart';


enum TextFieldShape { box, line }

enum TextFieldState { focus, error, disabled, none }

class InputPrimary extends StatefulWidget {
  const InputPrimary({
    super.key,
    this.label = '',
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
    this.color,
    this.textColor = GColors.black,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.contentPadding,
    this.enable = true,
    this.controller,
    this.validation,
    this.inputFormatters,
    this.hint = '',
    this.textStyle,
    this.hintStyle,
    this.errorTextStyle,
    this.keyboardType = TextInputType.text,
    this.maxLength = 30,
    this.onChanged,
    this.textCapitalization = TextCapitalization.sentences,
    this.obsecureText = false,
    this.inputShape = TextFieldShape.box,
    this.cursorColor = GColors.primary,
    this.textAlign = TextAlign.start,
    this.isRequired = false,
    this.requiredText = 'Required',
    this.showRequiredText = false,
    this.requiredTextStyle,
    this.isOptional = false,
    this.optitonalText = 'Optional',
    this.optionalTextStyle,
    this.labelTextStyle,
    this.outlineColor,
    this.borderRadius = 10,
    this.hintColor = GColors.darkGrey,
    this.maxLines = 1,
    this.action = TextInputAction.done,
    this.readOnly = false,
    this.onTap,
    this.errorMessage,
    this.focusNode,
    this.autoFocus = false,
  });

  final String label;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? color;
  final Color textColor;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final EdgeInsets? contentPadding;
  final bool enable;
  final TextEditingController? controller;
  final String? Function(String? value)? validation;
  final List<TextInputFormatter>? inputFormatters;
  final String hint;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorTextStyle;
  final TextInputType keyboardType;
  final int maxLength;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;
  final bool obsecureText;
  final TextFieldShape inputShape;
  final Color cursorColor;
  final TextAlign textAlign;
  final bool isRequired;
  final String requiredText;
  final TextStyle? requiredTextStyle;
  final bool showRequiredText;
  final bool isOptional;
  final String optitonalText;
  final TextStyle? optionalTextStyle;
  final TextStyle? labelTextStyle;
  final Color? outlineColor;
  final double borderRadius;
  final Color hintColor;
  final int maxLines;
  final TextInputAction action;
  final bool readOnly;
  final Function()? onTap;
  final String? errorMessage;
  final FocusNode? focusNode;
  final bool autoFocus;

  @override
  _InputPrimary createState() => _InputPrimary();
}

class _InputPrimary extends State<InputPrimary> {
  late FocusNode _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _internalFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label.isNotEmpty ||
              widget.isRequired ||
              widget.isOptional) ...[
            Row(
              children: [
                if (widget.label.isNotEmpty)
                  Text(
                    widget.label,
                    style: widget.labelTextStyle ?? Poppins.regular.copyWith(color: GColors.black, fontSize: 16),
                  ),
                if (widget.isRequired)
                  Text(
                    '*',
                    style: Poppins.regular.copyWith(color: Colors.red, fontSize: 16),
                  ),
                const Spacer(),
                if (widget.showRequiredText)
                  Text(
                    widget.requiredText,
                    style: widget.requiredTextStyle,
                  ),
                if (widget.isOptional)
                  Text(
                    widget.optitonalText,
                    style: widget.optionalTextStyle,
                  ),
              ],
            ),
            Gap(4)
          ],
          TextFormField(
            initialValue: widget.initialValue,
            focusNode: _internalFocusNode,
            scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: widget.inputShape == TextFieldShape.box
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius)),
                      borderSide: BorderSide(
                          color: widget.outlineColor ?? Colors.transparent),
                    )
                  : null,
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              enabled: widget.enable,
              fillColor: widget.color ?? GColors.backgroundField,
              filled: true,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              hoverColor: widget.outlineColor,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.outlineColor ?? Colors.transparent),
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
              ),
              enabledBorder: widget.inputShape == TextFieldShape.box
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.outlineColor ?? Colors.transparent),
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius)),
                    )
                  : null,
              hintText: widget.hint,
              hintStyle: widget.hintStyle ??
                  Poppins.regular.copyWith(color: widget.hintColor, fontSize: 16),
              errorMaxLines: 2,
              errorStyle: widget.errorTextStyle,
              errorText: widget.errorMessage,
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 42, maxWidth: 56),
            ),
            onChanged: widget.onChanged,
            controller: widget.controller,
            enabled: widget.enable,
            cursorColor: widget.cursorColor,
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxLength),
              if (widget.inputFormatters != null) ...widget.inputFormatters!,
            ],
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            obscureText: widget.obsecureText,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            readOnly: widget.readOnly,
            style: widget.textStyle ?? Poppins.medium.copyWith(color: GColors.black, fontSize: 16),
            textAlign: widget.textAlign,
            textInputAction: widget.action,
            validator: widget.validation,
            textCapitalization: widget.textCapitalization,
            onTap: widget.onTap,
          ),
        ],
      ),
    );
  }
}

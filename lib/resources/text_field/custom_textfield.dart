import 'dart:ui';
import 'package:flutter/material.dart';
import '../color/custom_color.dart';

class TextFromFieldWithPrefixSuffix extends StatefulWidget {
  const TextFromFieldWithPrefixSuffix({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.obscureText = false,
    this.applyPrefix = true,
    this.applySuffixIcon = false,
    this.suffixIcon,
    this.fillColor,
    this.borderRadius = 8.0,
    this.borderColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.autoFocus = false,
    this.readOnly = false,
    this.minLine = 1,
    this.maxLines = 1,
    this.onChange,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.glassEffect = false,
    this.blurAmount = 5.0,
    this.glassOpacity = 0.2,
    this.hintTextColor,

  });

  final bool glassEffect;
  final double blurAmount;
  final double glassOpacity;
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final bool applyPrefix;
  final Widget? prefixIcon;
  final bool applySuffixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final double borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final String? Function(String?) validator;
  final bool autoFocus;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final int minLine;
  final int maxLines;
  final Function(String?)? onChange;
  final Function(String?)? onChanged;
  final Function()? onTap;
  final FocusNode? focusNode;
  final Color? hintTextColor;

  @override
  _TextFromFieldWithPrefixSuffixState createState() =>
      _TextFromFieldWithPrefixSuffixState();
}

class _TextFromFieldWithPrefixSuffixState
    extends State<TextFromFieldWithPrefixSuffix> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.glassEffect
          ? BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
            color: CustomColor.inputGlassBaseWhite(context).withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: widget.blurAmount,
          ),
        ],
      )
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: widget.glassEffect
              ? ImageFilter.blur(
            sigmaX: widget.blurAmount,
            sigmaY: widget.blurAmount,
          )
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            controller: widget.controller,
            obscureText: widget.obscureText,
            validator: widget.validator,
            autofocus: widget.autoFocus,
            readOnly: widget.readOnly,
            minLines: widget.minLine,
            maxLines: widget.maxLines,
            focusNode: _focusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                color: widget.hintTextColor ?? CustomColor.inputHintDefault(context),
              ),
              filled: true,
              fillColor: widget.glassEffect
                  ? CustomColor.inputGlassBaseWhite(context).withValues(alpha: widget.glassOpacity)
                  : widget.fillColor ?? CustomColor.inputBg(context),
              focusColor: CustomColor.inputFocusBg(context),
              labelText: widget.labelText,
              hintText: widget.hintText,
              prefixIcon: widget.applyPrefix ? widget.prefixIcon : null,
              suffixIcon: widget.applySuffixIcon ? widget.suffixIcon : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: widget.glassEffect
                    ? BorderSide.none
                    : BorderSide(
                  color: widget.borderColor ?? CustomColor.inputBorderDefault(context),
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: widget.glassEffect
                    ? BorderSide.none
                    : BorderSide(
                  color: widget.enabledBorderColor ?? widget.borderColor ?? CustomColor.inputBorderDefault(context),
                  width: 1.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? CustomColor.inputBorderError(context),
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? CustomColor.inputBorderError(context),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: widget.glassEffect
                    ? BorderSide(color: CustomColor.inputGlassBaseWhite(context).withValues(alpha: 0.3), width: 1.5)
                    : BorderSide(
                  color: widget.focusedBorderColor ?? widget.borderColor ?? CustomColor.inputBorderDefault(context),
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Multi-line text field with a trailing mic button for the
/// "Incident Details (Optional)" section.
class VoiceTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback onMicTap;

  const VoiceTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onMicTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: CustomColor.inputBg(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: CustomColor.inputBorderDefault(context)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              minLines: 2,
              maxLines: 3,
              style: TextStyle(
                fontSize: 13,
                color: CustomColor.textPrimary(context),
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: CustomColor.inputHintDefault(context),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 6),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onMicTap,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: CustomColor.voiceButtonBg(context),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.mic_none_outlined,
                    size: 16, color: CustomColor.voiceButtonIcon(context)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
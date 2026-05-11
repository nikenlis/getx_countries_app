import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app/theme/app_color.dart';

class FormItems extends StatefulWidget {
  final String? title;
  final bool obsecureText;
  final TextEditingController? controller;
  final bool isShowTitle;
  final bool iconVisibility;
  final Function(String)? onFieldSubmitted;
  final bool isShowHint;
  final String? hintTitle;
  final String? errorText;
  final bool readOnly;
  final IconData? iconPrefix;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const FormItems({
    super.key,
    this.title,
    this.obsecureText = false,
    this.controller,
    this.isShowTitle = true,
    this.iconVisibility = false,
    this.onFieldSubmitted,
    this.errorText,
    this.readOnly = false,
    this.isShowHint = false,
    this.hintTitle,
    this.iconPrefix,
    required this.textInputAction,
    required this.textInputType,
    this.focusNode,
    this.onChanged,
    this.validator,
  });

  @override
  State<FormItems> createState() => _FormItemsState();
}

class _FormItemsState extends State<FormItems> {
  late bool _obsecureText;

  @override
  void initState() {
    super.initState();
    _obsecureText = widget.obsecureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowTitle)
          Text(
            widget.title!,
            style: TextStyle(
              color: base,
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
        if (widget.isShowTitle) const SizedBox(height: 6),
        TextFormField(
          obscureText: _obsecureText,
          controller: widget.controller,
          readOnly: widget.readOnly,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          cursorColor: base,
          style: TextStyle(
            color: base,
            fontSize: 14,
            fontWeight: light,
          ),
          decoration: InputDecoration(
            hintText: widget.isShowHint ? widget.hintTitle : null,
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: light,
              color: textSecondary,
            ),
            prefixIcon: Icon(
                      widget.iconPrefix,
                      color: textSecondary,
                      size: kIconSizeSmall,
                    ),  
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: border,
                      width: 1.0,
                    ),
                  ),
            focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: primary,
                      width: 1.0,
                    ),
                  ),
            focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: danger, width: 1.0),
                  ),
            errorText: widget.errorText,
            errorStyle: TextStyle(
              fontSize: 10,
              fontWeight: light,
              color: danger,
            ),
            errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: danger, width: 1),
                  ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            isDense: true,
            filled: true,
            fillColor: Color(0xFF111827),
            suffixIcon: widget.iconVisibility
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obsecureText = !_obsecureText;
                      });
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      _obsecureText ? LucideIcons.eyeOff : LucideIcons.eye,
                      color: textSecondary,
                      size: kIconSizeSmall,
                    ),
                  )
                : null,
          ),
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,
          validator: widget.validator,
        ),
      ],
    );
  }
}

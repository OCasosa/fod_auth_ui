import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_common_classes/helpers/hide_keyboard.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

/// Field to input a password.
///
/// The passsword view can be toggled between visible and hidden.
class FormBuilderPasswordField extends StatefulWidget {
  /// Field to input a password.
  const FormBuilderPasswordField({
    required this.name,
    this.label,
    this.onSubmitted,
    this.onChanged,
    this.textInputAction,
    this.formatters,
    this.focusNode,
    this.autoFocus = false,
    this.keyboardType,
    this.hintText,
    super.key,
  });

  /// Callback when the user submits the password.
  final ValueChanged<String?>? onSubmitted;

  /// Name of the field in the form.
  final String name;

  /// Label of the field.
  final String? label;

  /// CallBack when the field is changed.
  final ValueChanged<String?>? onChanged;

  /// Text Input Action
  final TextInputAction? textInputAction;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text formatters
  final List<TextInputFormatter>? formatters;

  /// True if the field is auto focused
  final bool autoFocus;

  /// Focus node to be used
  final FocusNode? focusNode;

  /// Hint text to be displayed in the field (and desappears when the field is with data)
  final String? hintText;

  @override
  State<FormBuilderPasswordField> createState() =>
      _FormBuilderPasswordFieldState();
}

class _FormBuilderPasswordFieldState extends State<FormBuilderPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) => FormBuilderTextField(
        name: widget.name,
        obscureText: _obscureText,
        autofocus: widget.autoFocus,
        focusNode: widget.focusNode,
        onTapOutside: (event) => hideKeyboard(),
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.formatters,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.label,
          prefixIcon: const Icon(
            FontAwesomeIcons.lock,
          ),
          suffixIcon: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FaIcon(
                _obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
              ),
            ),
            onPressed: () => setState(() => _obscureText = !_obscureText),
          ),
        ),
        onSubmitted: widget.onSubmitted,
        textInputAction: widget.textInputAction,
      );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pathplanner/services/log.dart';

class SettingsTextField extends StatefulWidget {
  final String label;
  final ValueChanged<String>? onSubmitted;
  final TextInputFormatter? formatter;
  final String? defaultValue;

  const SettingsTextField(
      {required this.label,
      this.onSubmitted,
      this.formatter,
      this.defaultValue,
      super.key});

  @override
  State<StatefulWidget> createState() => _SettingsTextFieldState();
}

class _SettingsTextFieldState extends State<SettingsTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.defaultValue);
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) return;
      if (_controller.text.isEmpty) return;

      widget.onSubmitted?.call(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 40,
        width: 165,
        child: TextField(
          focusNode: _focusNode,
          controller: _controller,
          inputFormatters: [
            if (widget.formatter != null) widget.formatter!,
          ],
          style: TextStyle(fontSize: 14, color: colorScheme.onSurface),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            labelText: widget.label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ),
    );
  }
}

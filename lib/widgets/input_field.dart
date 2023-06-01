import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputField extends StatefulWidget {
  final TextEditingController inputController;
  final String textLabel;
  final Widget suffixWidget;
  final MaskTextInputFormatter? formatter;
  final bool isRequired;
  final bool showDatePicker;

  const InputField({
    Key? key,
    required this.inputController,
    required this.textLabel,
    required this.suffixWidget,
    this.formatter,
    this.isRequired = false,
    this.showDatePicker = false,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String? validateRequired(String? value) {
    if (widget.isRequired && (value == null || value.isEmpty)) {
      return '';
    }
    return null;
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1950, 1, 1),
      maxTime: DateTime.now(),
      onConfirm: (date) {
        setState(() {
          widget.inputController.text =
              DateFormat('dd/MM/yyyy').format(date);
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.pt,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.inputController,
      onTap: widget.showDatePicker ? _showDatePicker : null,
      inputFormatters:
          widget.formatter != null ? [widget.formatter!] : [],
      keyboardType: widget.formatter != null ? TextInputType.number : null,
      validator: validateRequired,
      decoration: InputDecoration(
        labelText: widget.textLabel,
        suffixIcon: widget.suffixWidget,
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red)),
        errorStyle: const TextStyle(height: 0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
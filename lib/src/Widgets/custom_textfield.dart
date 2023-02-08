import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.label,
      required this.icon,
      required this.hintText,
      required this.onChange,
      required this.numberType,
      required this.obscureText,
      this.initialValue,
      this.inputFormatters,
      this.validator,
      this.counterText,
      this.maxLines,
      this.iconColor})
      : super(key: key);

  final String label;
  final String? counterText;
  final IconData icon;
  final String hintText;
  final int? maxLines;
  final Function(String) onChange;
  final String? Function(String?)? validator;
  final bool numberType;
  final bool obscureText;
  final String? initialValue;
  final Color? iconColor;
  final List<TextInputFormatter>? inputFormatters;

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  FocusNode? _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLines: widget.maxLines,
        initialValue: widget.initialValue,
        obscureText: widget.obscureText,
        inputFormatters: widget.inputFormatters,
        onTap: _requestFocus,
        focusNode: _focusNode,
        onChanged: widget.onChange,
        keyboardType:
            widget.numberType ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            icon: Icon(widget.icon, color: widget.iconColor ?? Colors.white),
            labelText: widget.label,
            labelStyle: TextStyle(
                color: _focusNode!.hasFocus ? Colors.black : Colors.black,
                backgroundColor: Colors.white),
            focusColor: Colors.white,
            hintText: widget.hintText,
            enabledBorder: _borderStyle(),
            focusedBorder: _borderStyle(),
            counterText: widget.counterText),
        validator: widget.validator);
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  OutlineInputBorder _borderStyle() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.black, width: 1.0));
  }
}

import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final Color errorTextColor;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextInputType keyboardType;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;
  final TextStyle? errorTextStyle;
  final Color textColor;
  final Color labelTextColor;
  final Color hintTextColor;

  CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.errorBorderColor = Colors.red,
    this.focusedErrorBorderColor = const Color.fromARGB(255, 221, 200, 15),
    this.errorTextStyle,
    this.labelTextColor = Colors.grey,
    this.textColor = Colors.white,
    this.hintTextColor = Colors.grey,
    this.errorTextColor = Colors.red,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      style: TextStyle(color: widget.textColor),
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: Icon(widget.icon, color: Colors.grey[400]),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[400],
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        errorStyle: TextStyle(color: widget.errorTextColor),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.hintTextColor),
        labelStyle: TextStyle(color: widget.labelTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:  Colors.yellow.shade400),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow.shade400),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.errorBorderColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.focusedErrorBorderColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: widget.validator,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../conts/Themes.dart';
import '../conts/consts.dart';

class CustomTextFormField3 extends StatefulWidget {
  final String text;
  const CustomTextFormField3({Key? key, required this.text}) : super(key: key);

  @override
  _CustomTextFormField3State createState() => _CustomTextFormField3State();
}

class _CustomTextFormField3State extends State<CustomTextFormField3> {
  bool _obscureText = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      child: TextFormField(
        controller: _controller,
        autofocus: false,
        autofillHints: [AutofillHints.email],
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.text,
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          labelStyle: Themes.fieldText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFE0E3E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: M.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: M.errorColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: M.errorColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(16),
        ),
        style: Themes.bodyMed
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
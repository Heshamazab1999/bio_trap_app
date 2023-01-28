import 'package:bio_trap/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:show_up_animation/show_up_animation.dart';

class FixedTextField extends StatelessWidget {
  const FixedTextField(
      {Key? key,
      this.label,
      this.function,
      this.inputType,
      this.errorLabel,
      this.controller,
      this.onSubmit,
      this.nextFocus,
      this.prefixIcon,
      this.suffixIcon,
      this.obSecure = false,
      this.focusNode})
      : super(key: key);
  final String? label;
  final Function(String)? function;
  final TextInputType? inputType;
  final String? errorLabel;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final FocusNode? nextFocus;
  final Function? onSubmit;
  final IconButton? suffixIcon;
  final Icon? prefixIcon;
  final bool? obSecure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.0),
      child: Column(
        children: [
          TextFormField(
            obscureText: obSecure!,
            decoration: InputDecoration(
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                label: Text(
                  label!,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.fontSizeLarge),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2
                    ))),
            controller: controller,
            focusNode: focusNode,
            keyboardType: inputType,
            inputFormatters: inputType == TextInputType.phone
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
                  ]
                : null,
            onChanged: function,
            showCursor: true,
            cursorColor: Theme.of(context).primaryColor,
            onFieldSubmitted: (text) => nextFocus != null
                ? FocusScope.of(context).requestFocus(nextFocus)
                : onSubmit != null
                    ? onSubmit!(text)
                    : null,
          ),
          if (errorLabel != null && errorLabel!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: ShowUpAnimation(
                child: Text(
                  '$errorLabel',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.redAccent[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

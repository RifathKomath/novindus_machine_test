import 'package:flutter/material.dart';
import 'package:novindus_machine_test/shared/widgets/app_svg.dart';
import '../../core/style/app_text_style.dart';
import '../../core/style/colors.dart';

class AppSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;

  final double height;

  const AppSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    this.validator,
    this.textInputType,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: TextFormField(
         autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        keyboardType: textInputType,
        onChanged: onChanged,
        validator: validator,
        style: AppTextStyles.textStyle_400_14.copyWith(
          decoration: TextDecoration.none,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:  BorderSide(color: blackText.withOpacity(0.5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:  BorderSide(color: blackText.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),prefixIcon: Padding(
            padding:  EdgeInsets.all(10.0),
            child: AppSvg(assetName: "search_icon"),
          ),
        
          hintStyle: AppTextStyles.textStyle_400_14.copyWith(fontSize:12,color: blackText.withOpacity(0.5) ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/margin_extension.dart';
import '../../core/style/app_text_style.dart';
import '../../core/style/colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoaderBtn;
  final double height;
  final IconData? icon;
  final bool isPrefixIconEnabled;
  final bool isExtend;
  final Color? buttonclr;

  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoaderBtn = false,
    this.buttonclr,
    this.height = 44,
    this.icon,
    this.isPrefixIconEnabled = false,
    this.isExtend = false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoaderBtn ? null : onTap,
      child: Container(
        height: height,
        width: isExtend ? null : double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:buttonclr ?? primaryColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: isLoaderBtn
            ? const CupertinoActivityIndicator(color: whiteClr)
            : Row(
                mainAxisSize:
                    isExtend ? MainAxisSize.min : MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isPrefixIconEnabled && icon != null)
                    Icon(icon, color: whiteClr, size: 20),
                  if (isPrefixIconEnabled && icon != null) 8.wBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 34.w),
                    child: Text(
                      label,
                      style: AppTextStyles.textStyle_500_14.copyWith(
                        color: whiteClr,fontSize: 12
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

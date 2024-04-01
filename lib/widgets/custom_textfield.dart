import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_app/utils/base_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    // this.fieldValidator,
    required this.label,
    this.capitalization,
    this.inputAction,
    this.isNumeric = false,
    required this.focus,
    this.formatters,
    this.inputType,
    this.isMandatory = true,
    this.autoValidateMode,
    this.onSubmit,
    required this.error,
  }) : super(key: key);

  final TextEditingController controller;
  // final FormFieldValidator<String>? fieldValidator;
  final ValueChanged<String>? onSubmit;
  final String label;
  final TextCapitalization? capitalization;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final bool isNumeric;
  final FocusNode focus;
  final List<TextInputFormatter>? formatters;
  final bool isMandatory;
  final AutovalidateMode? autoValidateMode;
  final Rx<String?> error;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderSide: const BorderSide(color: BaseColors.white),
      borderRadius: BorderRadius.circular(5.r),
    );
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 5.h,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: BaseColors.white),
              borderRadius: BorderRadius.circular(10.r),
            ),
            shadowColor: BaseColors.black.withOpacity(0.3),
            child: TextFormField(
              autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
              focusNode: focus,
              onFieldSubmitted: onSubmit,
              controller: controller,
              decoration: InputDecoration(
                // errorText: error.value,
                border: border,
                focusedBorder: border,
                enabledBorder: border,
                errorBorder: border,
                focusedErrorBorder: border,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: RichText(
                  text: TextSpan(
                    text: label,
                    style: TextStyle(
                      color: BaseColors.hintColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    children: isMandatory
                        ? const [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: BaseColors.pink,
                              ),
                            )
                          ]
                        : [],
                  ),
                ),
                counterText: '',
              ),
              textCapitalization:
                  capitalization ?? TextCapitalization.sentences,
              textInputAction: inputAction ?? TextInputAction.done,
              keyboardType: inputType ?? TextInputType.text,
              maxLength: isNumeric ? 4 : null,
              inputFormatters: formatters,
            ),
          ),
          if (error.value != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                error.value!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: BaseColors.red),
              ),
            ),
        ],
      );
    });
  }
}

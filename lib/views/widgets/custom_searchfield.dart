import 'package:anmol_marketing/core/core.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';




class CustomSearchField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;

  const CustomSearchField({
    Key? key,
    this.hintText = "Search",
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      style: context.bodyMediumStyle!.copyWith(color: AppColors.greyColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: context.bodyMediumStyle!.copyWith(color: AppColors.greyColor),
        prefixIcon: Icon(Iconsax.search_normal, color: AppColors.greyColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.darkGreyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.darkGreyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.greyColor),
        ),
      ),
    );
  }
}

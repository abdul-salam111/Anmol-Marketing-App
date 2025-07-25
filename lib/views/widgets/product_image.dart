import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:anmol_marketing/core/core.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final String? cacheKey;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.padding,
    this.border,
    this.cacheKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? defaultPadding,
      decoration: BoxDecoration(
        border: border ?? Border.all(color: AppColors.mostLightGreyColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        cacheKey: cacheKey,
        height: height ?? context.screenHeight * 0.1,
        width: width ?? context.screenWidth * 0.25,
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(),
        errorWidget: (context, url, error) =>
            const Icon(Icons.broken_image, size: 40),
        useOldImageOnUrlChange: true,
        maxWidthDiskCache: 200,
        maxHeightDiskCache: 200,
      ),
    );
  }
}

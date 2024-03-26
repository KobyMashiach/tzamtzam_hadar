import 'package:flutter/material.dart';

FadeInImage networkLoadingImages(String url, {double? size = 50}) {
  return FadeInImage.assetNetwork(
      placeholder: 'assets/icons/loading.png',
      image: url,
      width: size,
      height: size,
      fit: BoxFit.cover,
      imageErrorBuilder: (context, error, stackTrace) => Image.asset(
          "assets/icons/placeholder.png",
          height: size,
          width: size));
}

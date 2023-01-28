import 'package:cached_network_image/cached_network_image.dart';
import 'package:bio_trap/util/images.dart';
import 'package:flutter/material.dart';



class CustomImage extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? placeholder;
  const CustomImage({super.key,  this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder = Images.placeholder});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: CachedNetworkImage(
        imageUrl: image!, height: height, width: width, fit: fit,
        placeholder: (context, url) => Image.asset(Images.placeholder, height: height, width: width, fit: fit),
        errorWidget: (context, url, error) => Image.asset(placeholder!, height: height, width: width, fit: fit),
      ),
    );
  }
}

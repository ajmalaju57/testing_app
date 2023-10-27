// ignore_for_file: unnecessary_import, depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_eco/data/services/urls.dart';

class CachedImage extends StatelessWidget {
  const CachedImage(
      {super.key,
      this.radius = 6.0,
      required this.imageUrl,
      this.height,
      this.width});

  final double radius;
  final String? imageUrl;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        color: Colors.grey.withOpacity(0.25),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          height: height,
          width: width,
          imageUrl: "$imageBaseUrl${imageUrl ?? ""}",
          // placeholder: (context, url) =>
          //     const Center(child: CupertinoActivityIndicator()),
          errorWidget: (context, url, error) => const SizedBox(),
          progressIndicatorBuilder: (context, url, progress) =>
              Shimmer.fromColors(
                  highlightColor: Colors.white,
                  baseColor: Colors.grey.shade300,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withBlue(3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: AspectRatio(
                          aspectRatio: 0.1 / 0.1,
                          child: Container(
                            color: Colors.grey,
                          ),
                        ),
                      ))),
        ),
      ),
    );
  }
}

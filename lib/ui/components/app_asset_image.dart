import 'package:flutter/material.dart';
import 'package:test_eco/utils/strings.dart';

class AppAssetImg extends StatelessWidget {
  const AppAssetImg({Key? key, required this.imageName, this.fit, this.width, this.height}) : super(key: key);

  final String imageName;
  final BoxFit? fit;
  final double? width, height;

  @override
  Widget build(BuildContext context) => Image.asset('$imagePath/$imageName', fit: fit, width: width, height: height);
}

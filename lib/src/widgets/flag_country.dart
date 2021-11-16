import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class FlagCountry extends StatelessWidget {
  final String countryName;
  final CountryFlagSize flagSize;
  final double height;
  final double width;

  FlagCountry({
    required this.countryName,
    this.flagSize = CountryFlagSize.w40,
    this.width = 24,
    this.height = 24,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          "https://flagcdn.com/${flagSize.value}/${countryName.toLowerCase()}.jpg",
      height: height,
      width: width,
    );
  }
}

import 'package:flutter/material.dart';

class FlagCountry extends StatelessWidget {
  final String flagURL;
  final int flagSize;
  final double height;
  final double width;

  FlagCountry({
    required this.flagURL,
    this.flagSize = 32,
    this.width = 24,
    this.height = 24,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://www.countryflags.io/$flagURL/flat/$flagSize.png",
      height: height,
      width: width,
    );
  }
}

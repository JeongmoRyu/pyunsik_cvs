import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  static const String defaultFilename = 'assets/images/wip.jpg';

  final String filename;
  const ProductImage({super.key, required this.filename});

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
        placeholder: const AssetImage(defaultFilename),
        image: NetworkImage(filename),
        imageErrorBuilder:(context, error, stackTrace) {
          return Image.asset(defaultFilename,
              fit: BoxFit.cover
          );
        },
        fit: BoxFit.cover
    );
  }
}

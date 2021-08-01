import 'package:tasq/utils/constants/images.dart';
import 'package:flutter/material.dart';

class TopStaticDesign extends StatelessWidget {
  const TopStaticDesign({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 180,
          child: Image(
            image: AssetImage(Images.flameAsset),
          ),
        ),
      ],
    );
  }
}

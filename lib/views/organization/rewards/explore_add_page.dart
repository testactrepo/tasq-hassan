import 'package:tasq/utils/constants/images.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:flutter/material.dart';

class ExploreAndAddPage extends StatelessWidget {
  const ExploreAndAddPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              //space
              SizedBox(height: 25.0),
              //image
              Container(
                // width: 180,
                child: Image(
                  image: AssetImage(Images.cyborgAsset),
                ),
              ),
              //space
              SizedBox(height: 15.0),
              //text
              Text(
                Strings.explorePageSilentMsg,
                style: MyTextStyle.heading18BoldBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:tasq/core/model/reward.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:jiffy/jiffy.dart';

class RewardItemView extends StatelessWidget {
  final Reward reward;
  const RewardItemView({@required this.reward, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(
                    Octicons.north_star,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),
              ),
              title: Text(
                '${reward.title}',
                style: MyTextStyle.heading18BoldBlack,
              ),
              subtitle: Text(
                  'valid tile ${Jiffy(reward.validTill, "dd, MMM yyyy").yMMMMd}'),
            ),
            SizedBox(height: 12),
            // Group: Group 1343
            Container(
              decoration: BoxDecoration(
                color: MyColors.rewardsVoucherCodeColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'voicher code',
                      style: MyTextStyle.heading15BoldWhite,
                    ),
                    Text(
                      '${reward.vouchercode}',
                      style: MyTextStyle.heading18BoldWhite,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/reward.dart';
import 'package:tasq/core/viewmodel/myrewards_model.dart';
import 'package:tasq/views/baseview.dart';
import 'package:tasq/views/widgets/rewarditemview.dart';
import 'package:flutter/material.dart';

class MyRewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BaseView<MyRewardsModel>(
        onModelReady: (model) => model.fetchRewards(),
        builder: (_, model, __) => RefreshIndicator(
          onRefresh: () => model.fetchRewards(),
          child: Stack(
            children: [
              ListView(shrinkWrap: true), //for refereshindicator
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: model.state == ViewState.Busy
                    ? Center(child: CircularProgressIndicator())
                    : model.rewardList.length > 0
                        ? Column(
                            children: List.generate(
                            model.rewardList?.length ?? 0,
                            (index) {
                              return RewardItemView(
                                  reward: model.rewardList[index]);
                            },
                          ))
                        : Center(child: Text('No reward added')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

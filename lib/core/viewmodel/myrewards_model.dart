import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/reward.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/core/viewmodel/base_model.dart';

class MyRewardsModel extends BaseModel {
  List<Reward> rewardList = [];
  List<Reward> collectedRewardList = [];

  adToRewardList(Reward reward) {
    rewardList.add(reward);
    notifyListeners();
  }

  fetchRewards() async {
    setState(ViewState.Busy);
    FirestoreService fs = FirebaseFirestoreService();
    rewardList = await fs.fetchRewardsList();
    setState(ViewState.Idle);
  }

  fetchMyCollectedRewards() async {
    setState(ViewState.Busy);
    FirestoreService fs = FirebaseFirestoreService();
    rewardList = await fs.fetchMyCollectedRewardsList();
    setState(ViewState.Idle);
  }
}

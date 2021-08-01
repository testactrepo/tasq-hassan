import 'package:tasq/core/model/reward.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/core/services/formvalidation_service.dart';
import 'package:tasq/core/viewmodel/myrewards_model.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/organization/home/newactivity/local_widgets/my_text_field.dart';
import 'package:tasq/views/widgets/appbar.dart';
import 'package:tasq/views/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class AddNewRewardView extends StatefulWidget {
  AddNewRewardView({Key key}) : super(key: key);

  @override
  _AddNewRewardViewState createState() => _AddNewRewardViewState();
}

class _AddNewRewardViewState extends State<AddNewRewardView> {
  TextEditingController rewardController = TextEditingController();
  TextEditingController vouchercode = TextEditingController();
  DateTime selectedDate;
  //form key
  final formKey = GlobalKey<FormState>();
  final scafoldKey = GlobalKey<ScaffoldState>();
  //progree indicator
  bool inProgress = false;

  @override
  void dispose() {
    rewardController?.dispose();
    vouchercode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      appBar: MyAppBar(title: 'add new reward'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              MyTextField(
                title: "reward name",
                controller: rewardController,
                validator: FormValidationService.checkEmpty,
              ),
              MyTextField(
                title: "voucher code",
                controller: vouchercode,
                validator: FormValidationService.checkEmpty,
              ),
              validTillDatePickerWidget(),
              //space
              SizedBox(height: 30.0),
              addToRewardsButton(),
              SizedBox(height: 30.0),
              Visibility(
                  visible: inProgress, child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  validTillDatePickerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            "valid till",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        GestureDetector(
          onTap: () => pickDate(),
          child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.primaryColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate == null
                        ? 'select date'
                        : Jiffy(selectedDate, "dd, MMM yyyy").yMMMMd,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Icon(Icons.date_range),
                ],
              )),
        ),
      ],
    );
  }

  pickDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate != null ? selectedDate : DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    selectedDate = picked;
    setState(() {});
  }

  addToRewardsButton() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: CustomButton(
        color: Colors.blue,
        disableBorder: true,
        width: 250.0,
        height: 60.0,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        text: 'ADD TO REWARDS',
        onTap: () async {
          if (formKey.currentState.validate()) {
            if (selectedDate != null) {
              inProgress = true;
              setState(() {});
              //arrange data in model class
              Reward reward = Reward(
                title: rewardController.text.trim(),
                vouchercode: vouchercode.text.trim(),
                validTill: selectedDate,
              );
              //Upload to firestore
              FirestoreService fs = FirebaseFirestoreService();
              await fs.addNewReward(reward);
              //stop progress
              inProgress = false;
              //add reward to rewardlist
              final model = locator<MyRewardsModel>();
              model.adToRewardList(reward);
              Navigator.pop(context);
            } else {
              Utils.showSnackbar(
                  scaffoldKey: scafoldKey, message: 'Please select date');
            }
          }
        },
      ),
    );
  }
}

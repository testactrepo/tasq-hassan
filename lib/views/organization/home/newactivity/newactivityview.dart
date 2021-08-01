import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/reward.dart';
import 'package:tasq/core/model/task.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/services/formvalidation_service.dart';
import 'package:tasq/utils/constants/appdata.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/utils/naviation_services.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:tasq/views/organization/home/postpreview/post_view.dart';
import 'package:tasq/views/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'local_widgets/my_text_field.dart';
import 'local_widgets/mydropdown.dart';

class NewActivityView extends StatefulWidget {
  final List<Reward> rewardList;
  NewActivityView({@required this.rewardList, Key key}) : super(key: key);

  @override
  _NewActivityViewState createState() => _NewActivityViewState();
}

class _NewActivityViewState extends State<NewActivityView> {
  String selectedCategory, dueIn, assignTo;
  Reward selecredReward;
  int assignType;
  MyAppUser assignToUser;
  TextEditingController nameCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();
  // TextEditingController pointsCont = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final scafoldKey = GlobalKey<ScaffoldState>();
  //points offered: can't be edited, follow algorithm for allotment
  int pointsOffered;

  @override
  void initState() {
    pointsOffered = 50; //other tech work
    super.initState();
  }

  @override
  void dispose() {
    nameCont?.dispose();
    descriptionCont?.dispose();
    // pointsCont?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextField(
                  title: "tasQ name",
                  controller: nameCont,
                  validator: FormValidationService.validateName,
                ),
                MyTextField(
                  title: "description",
                  controller: descriptionCont,
                  validator: FormValidationService.validateName,
                ),
                // MyTextField(
                //   title: "points",
                //   controller: pointsCont,
                //   keyboardType: TextInputType.phone,
                //   validator: FormValidationService.checkEmpty,
                //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                // ),
                MyDropDownMenu(
                  title: 'category',
                  hintText: 'select category',
                  list: AppData.activityCategories,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                      pointsOffered = Utils.pointsAlgorithm(selectedCategory);
                    });
                  },
                ),
                MyDropDownMenu(
                  title: "activity due in",
                  hintText: "select due days",
                  list: AppData.activityDueCount,
                  onChanged: (value) {
                    setState(() {
                      dueIn = value;
                    });
                  },
                ),
                MyDropDownMenu(
                  title: "assign to",
                  hintText: "select whom to assign",
                  list: AppData.activityAssignTo,
                  onChanged: (r) async {
                    assignTo = r;
                    assignType = AppData.activityAssignTo.indexOf(r);
                    //if team then open team list page
                    // if (assignTo == 'from team')
                    final user = await locator<NavigationService>()
                        .navigateTo(AssignFromTeamPageRoute);
                    print(user.uid);
                    assignToUser = user;
                    setState(() {});
                  },
                ),
                MyDropDownMenu(
                  title: "rewards offered",
                  hintText: "select reward",
                  list: widget.rewardList,
                  onChanged: (reward) {
                    setState(() {
                      selecredReward = reward;
                    });
                  },
                ),
                //space
                SizedBox(height: 15.0),
                selecredReward == null
                    ? Container(width: 0.0)
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          border: Border.all(
                              width: 1.0, color: const Color(0xFFDC143D)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(selecredReward.title),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                setState(() {
                                  selecredReward = null;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                //space
                SizedBox(height: 15.0),
                //points offered box
                pointsOfferedBox(),
                SizedBox(height: 15.0),

                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: CustomButton(
                    color: Colors.blue,
                    disableBorder: true,
                    // width: 120.0,
                    height: 60.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    text: 'SEE POST PREVIEW',
                    onTap: () => onPreviewTapped(),
                  ),
                ),
                SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pointsOfferedBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            "points offered",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          width: 250.0,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.primaryColor),
          ),
          child: Text(
            pointsOffered.toString(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }

  appBar() {
    return AppBar(
      centerTitle: false,
      leading: BackButton(
        color: Colors.black,
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'new activity',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }

  // class internal functions
  onPreviewTapped() {
    if (formKey.currentState.validate()) {
      if (selectedCategory == null || dueIn == null) {
        Utils.showSnackbar(
          scaffoldKey: scafoldKey,
          message: "Please select required dropdown",
        );
      } else {
        Organization org = locator<Organization>();
        print('orguid: ' + org.uid);
        Task task = Task(
          taskname: nameCont.text,
          description: descriptionCont.text.trim(),
          selectedCategory: selectedCategory,
          duein: expiry(dueIn),
          assignToUserUID: assignToUser?.uid ?? null,
          rewardtitle: selecredReward?.title ?? null,
          rewarduid: selecredReward?.reference?.id ?? null,
          status: assignToUser == null
              ? Strings.yetToBeAllotted
              : Strings.taskAllotted,
          pointsOffered: pointsOffered,
          orgname: org.orgName,
          orguid: org.uid,
          orgProfileUrl: org.profileUrl,
        );
        print('taskorguid: ' + task.orguid);
        Utils.navigateToPage(
          context,
          page: PostPreview(taskData: task),
        );
      }
    }
  }

  DateTime expiry(String duration) {
    int dur = int.parse(duration);
    DateTime time = DateTime.now().add(Duration(days: dur));
    return time;
  }
}

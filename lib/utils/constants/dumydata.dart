import 'package:tasq/core/model/orgmembers.dart';
import 'package:tasq/core/model/reward.dart';
import 'package:tasq/core/model/task.dart';
import 'package:tasq/core/model/taskapplication.dart';
import 'package:tasq/utils/constants/appdata.dart';
import 'package:tasq/utils/constants/strings.dart';

class DumyData {
  static Task task = Task(
    taskname: 'MERN Developer Required',
    description:
        'We need a volunteer with Bootstrap and JavaScript skills to upgrade the YfS website to make it more user friendly on mobile devices. Interested volunteers may apply before the due date.',
    orgname: 'Starbucks Inc.',
    orgProfileUrl: AppData.orgProfileUrl,
    status: Strings.taskAllotted,
    pointsOffered: 230,
    numberofresponses: 45,
    rewardtitle: 'reward title',
    createdAt: DateTime.now(),
  );

  static Reward reward1 = Reward(
    title: '\$10 Bocca Café Credit',
    vouchercode: '1djsjdijd',
    validTill: DateTime.now(),
  );

  static List<OrgMember> orgMembersList = [
    OrgMember(username: 'Alex Reyli', role: 'user'),
    OrgMember(username: 'Neil Reyli', role: 'user'),
  ];

  static List<TaskApplication> taskApplication = [
    TaskApplication(
      tasktitle: 'Web Developer',
      proposal: 'Here is my proposal',
      taskpoints: 234,
      appliedat: DateTime.now(),
    ),
    TaskApplication(
      tasktitle: 'App Developer',
      proposal: 'Here is my proposal',
      taskpoints: 23,
      appliedat: DateTime.now(),
    ),
  ];
}

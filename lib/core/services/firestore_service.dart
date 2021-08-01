import 'package:tasq/core/enum/taskstatus.dart';
import 'package:tasq/core/model/chatroom.dart';
import 'package:tasq/core/model/message.dart';
import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/orgmembers.dart';
import 'package:tasq/core/model/reward.dart';
import 'package:tasq/core/model/task.dart';
import 'package:tasq/core/model/taskapplication.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/utils/constants/firebasepath.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreService {
  Future<MyAppUser> loadMyAppUserData(String uid);
  void updateUserRecord(MyAppUser user);
  void updateOrgRecord(Organization organization);
  Future<List<Organization>> searchOrganization(String query);
  //rewards
  Future<void> addNewReward(Reward reward);
  Future<List<Reward>> fetchRewardsList();
  Future<List<Reward>> fetchMyCollectedRewardsList();
  //tasks
  Future<void> addNewTask(Task task);
  void updateTaskRecord(Task task);
  Future<List<Task>> fetchTasksList(TaskStatus taskstatus);
  Future<List<Task>> fetchMyOrgTasksList(TaskStatus taskstatus);
  Future<List<Task>> fetchUserTasksList(TaskStatus taskstatus);
  //
  Future<List<MyAppUser>> fetchTeamMembers();
  Future<List<OrgMember>> fetchMembers(bool request);
  Future<void> acceptRejectMemberRequest(String orgMemberCuid, bool accept);
  Future<void> removeOrgMember(String orgMemberuid);
  Future<void> changeOrgMemberRole(String uid, String role);
  //
  sendMemberRequestToOrg(OrgMember orgMembers);
  //
  sendProposalToTask(TaskApplication taskApplication);
  //fetch all responses of of task
  Future<List<TaskApplication>> fetchAllResponses(String taskuid);
  Future<List<TaskApplication>> fetchAppliedProposalList();
  Future<void> deleteResponse(String taskuid);
  Future<void> assignTaskToUser(String taskuid, String applicantuid);
  //send message
  Future<String> sendMessage(ChatRoom chatroomData, combineuid, Message msg);
  updateUnreadMsgCount(String chatroomid);
  //fetch my all accounts
  Future<List<OrgMember>> fetchMyAccountsList();
}

class FirebaseFirestoreService extends FirestoreService {
  @override
  Future<MyAppUser> loadMyAppUserData(String uid) async {
    MyAppUser myAppUser = locator<MyAppUser>();

    final snapshot = await FirebasePath.users(uid).get();
    final user = MyAppUser.fromSnapshot(snapshot);
    myAppUser.update(user);
    print('loaded: ' + myAppUser.name);

    if (myAppUser.isAdmin) {
      final snapshot = await FirebasePath.organization(myAppUser.orgId).get();
      Organization organization = locator<Organization>();
      final org = Organization.fromSnapshot(snapshot);
      organization.update(org);
      print('org: ' + organization.orgName);
    }
    return myAppUser;
  }

  @override
  updateUserRecord(MyAppUser user) {
    FirebasePath.users(user.uid).update(user.toMap());
  }

  @override
  updateOrgRecord(Organization organization) {
    FirebasePath.organization(organization.uid).update(organization.toMap());
  }

  @override
  Future<List<Organization>> searchOrganization(String query) async {
    try {
      final querySnapshot = await FirebasePath.organizationCollection()
          .orderBy('orgName')
          .startAt([query.toUpperCase()])
          .endAt([query.toLowerCase()])
          .limit(5)
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      // print('docs: ' + docs.toString());
      final organizationList =
          docs.map((doc) => Organization.fromSnapshot(doc)).toList();
      // print('organizationList: ' + organizationList.toString());
      return organizationList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  @override
  Future<void> addNewReward(Reward reward) async {
    Organization org = locator<Organization>();
    await FirebasePath.rewardsC(org.uid).add(reward.toMap());
    return;
  }

  @override
  Future<List<Reward>> fetchRewardsList() async {
    Organization org = locator<Organization>();
    final querySnapshot = await FirebasePath.rewardsC(org.uid).get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    final rewardsList = docs.map((doc) => Reward.fromSnapshot(doc)).toList();
    return rewardsList;
  }

  @override
  Future<List<Reward>> fetchMyCollectedRewardsList() async {
    List<Reward> rewardsList = [];
    MyAppUser user = locator<MyAppUser>();
    for (var reward in user.rewardsList) {
      final snapshot =
          await FirebasePath.rewards(reward['orguid'], reward['rewarduid'])
              .get();
      rewardsList.add(Reward.fromSnapshot(snapshot));
    }
    return rewardsList;
  }

  @override
  Future<void> addNewTask(Task task) async {
    Organization org = locator<Organization>();
    //increment counter in org
    org.totalcreatedtasks += 1;
    await FirebasePath.organization(org.uid)
        .update({'totalcreatedtasks': FieldValue.increment(1)});
    //if alloted then also increase allassignedtasks counter field
    if (task.assignToUserUID != null) {
      await FirebasePath.users(task.assignToUserUID)
          .update({'allassignedtasks': FieldValue.increment(1)});
    }
    print('before push: ' + task.orguid.toString());
    await FirebasePath.tasksC().add(task.toMap());
    return;
  }

  @override
  void updateTaskRecord(Task task) {
    FirebasePath.tasks(task.reference.id).update(task.toMap());
  }

  @override
  Future<List<Task>> fetchTasksList(taskstatus) async {
    MyAppUser user = locator<MyAppUser>();
    QuerySnapshot querySnapshot;
    if (taskstatus == TaskStatus.COMPLETE) {
      querySnapshot = await FirebasePath.tasksC()
          .where('status', isEqualTo: 'completed')
          .get();
    } else if (taskstatus == TaskStatus.ALLOTED) {
      querySnapshot = await FirebasePath.tasksC()
          .where('assignToUserUID', isEqualTo: user.uid)
          .get();
    } else {
      querySnapshot = await FirebasePath.tasksC()
          .where('assignToUserUID', isNull: true)
          .get();
    }
    return querySnapshot.docs
        .map((snapshot) => Task.fromSnapshot(snapshot))
        .toList();
  }

  @override
  Future<List<Task>> fetchMyOrgTasksList(taskstatus) async {
    print('fetchMyOrgTasksList');
    print(taskstatus.toString());
    Organization org = locator<Organization>();
    print(org.uid);
    QuerySnapshot querySnapshot;
    if (taskstatus == TaskStatus.COMPLETE) {
      querySnapshot = await FirebasePath.tasksC()
          .where('status', isEqualTo: 'completed')
          .where('orguid', isEqualTo: org.uid)
          .get();
    } else {
      querySnapshot = await FirebasePath.tasksC()
          .where('status', isNotEqualTo: 'completed')
          .where('orguid', isEqualTo: org.uid)
          .get();
    }
    return querySnapshot.docs
        .map((snapshot) => Task.fromSnapshot(snapshot))
        .toList();
  }

  @override
  Future<List<MyAppUser>> fetchTeamMembers() async {
    Organization org = locator<Organization>();

    final querySnapshot =
        await FirebasePath.usersC().where('orgId', isEqualTo: org.uid).get();

    return querySnapshot.docs
        .map((snapshot) => MyAppUser.fromSnapshot(snapshot))
        .toList();
  }

  @override
  Future<List<OrgMember>> fetchMembers(bool request) async {
    Organization org = locator<Organization>();

    final querySnapshot = await FirebasePath.orgMembersCollection()
        .where('orgid', isEqualTo: org.uid)
        .where('requeststatus', isEqualTo: request ? 0 : 1)
        .get();

    return querySnapshot.docs
        .map((snapshot) => OrgMember.fromSnapshot(snapshot))
        .toList();
  }

  @override
  sendMemberRequestToOrg(OrgMember orgMembers) {
    FirebasePath.orgMembersCollection().add(orgMembers.toMap());
  }

  @override
  Future<void> acceptRejectMemberRequest(String uid, bool accept) async {
    Organization org = locator<Organization>();
    org.numofpendingrequests -= 1;
    if (accept)
      await FirebasePath.orgMembers(uid).update({'requeststatus': 1});
    else
      FirebasePath.orgMembers(uid).delete();
    //reduce pendingrequest value in org collection
    await FirebasePath.organization(org.uid)
        .update({'pendingrequests': FieldValue.increment(-1)});
    return;
  }

  Future<void> removeOrgMember(String uid) async {
    await FirebasePath.orgMembers(uid).delete();
    return;
  }

  Future<void> changeOrgMemberRole(String uid, String role) async {
    await FirebasePath.orgMembers(uid).update({'role': role});
    return;
  }

  @override
  Future<List<Task>> fetchUserTasksList(TaskStatus taskstatus) async {
    MyAppUser user = locator<MyAppUser>();

    QuerySnapshot querySnapshot;
    if (taskstatus == TaskStatus.COMPLETE) {
      querySnapshot = await FirebasePath.tasksC()
          .where('assignToUserUID', isEqualTo: user.uid)
          .where('status', isEqualTo: Strings.taskcompleted)
          .get();
    } else if (taskstatus == TaskStatus.ALLOTED) {
      querySnapshot = await FirebasePath.tasksC()
          .where('assignToUserUID', isEqualTo: user.uid)
          .where('status', isEqualTo: Strings.taskAllotted)
          .get();
    }
    return querySnapshot.docs
        .map((snapshot) => Task.fromSnapshot(snapshot))
        .toList();
  }

  @override
  sendProposalToTask(TaskApplication taskApplication) {
    FirebasePath.taskApplicationC().add(taskApplication.toMap());
    //update number of task field in task collection'
    FirebasePath.tasks(taskApplication.taskuid)
        .update({'numberofresponses': FieldValue.increment(1)});
  }

  @override
  Future<List<TaskApplication>> fetchAllResponses(String taskuid) async {
    QuerySnapshot querySnapshot;
    querySnapshot = await FirebasePath.taskApplicationC()
        .where('taskuid', isEqualTo: taskuid)
        .get();

    return querySnapshot.docs
        .map((snapshot) => TaskApplication.fromSnapshot(snapshot))
        .toList();
  }

  @override
  Future<void> deleteResponse(String taskuid) async {
    await FirebasePath.taskApplication(taskuid).delete();
    FirebasePath.tasks(taskuid).update({
      'assignToUserUID': null,
      'numberofresponses': FieldValue.increment(-1),
      'status': Strings.yetToBeAllotted,
    });
    return;
  }

  @override
  Future<void> assignTaskToUser(String taskuid, String applicantuid) async {
    await FirebasePath.tasks(taskuid).update(
        {'assignToUserUID': applicantuid, 'status': Strings.taskAllotted});
    return;
  }

  @override
  Future<List<TaskApplication>> fetchAppliedProposalList() async {
    MyAppUser user = locator<MyAppUser>();
    QuerySnapshot querySnapshot;
    querySnapshot = await FirebasePath.taskApplicationC()
        .where('applicantUID', isEqualTo: user.uid)
        .get();

    return querySnapshot.docs
        .map((snapshot) => TaskApplication.fromSnapshot(snapshot))
        .toList();
  }

  @override
  Future<String> sendMessage(
      ChatRoom chatroomData, combineuid, Message msg) async {
    DocumentReference docreference;
    try {
      docreference = FirebasePath.chatroom(combineuid);
      print('updated');
      await docreference.update(chatroomData.toMap());

      DocumentReference msgref =
          await docreference.collection('messages').add(msg.toMap());
      return msgref.id;
    } catch (e) {
      print(e.toString());
      await docreference.set(chatroomData.toMap());

      DocumentReference msgref =
          await docreference.collection('messages').add(msg.toMap());
      return msgref.id;
    }
  }

  @override
  updateUnreadMsgCount(String chatroomid) async {
    await FirebasePath.chatroom(chatroomid).update({'unreadmessagescount': 0});
  }

  @override
  Future<List<OrgMember>> fetchMyAccountsList() async {
    MyAppUser user = locator<MyAppUser>();

    List<OrgMember> orgMemberList = [];
    orgMemberList.add(
      OrgMember(
        orgname: user.name,
        useruid: user.uid,
        profileurl: user.profileUrl,
        role: 'user',
      ),
    );

    final querySnapshot = await FirebasePath.orgMembersCollection()
        .where('useruid', isEqualTo: user.uid)
        .where('requeststatus', isEqualTo: 1)
        .get();

    final list = querySnapshot.docs
        .map((snapshot) => OrgMember.fromSnapshot(snapshot))
        .toList();

    orgMemberList.addAll(list);
    return orgMemberList;
  }
}

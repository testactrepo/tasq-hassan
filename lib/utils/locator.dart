import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/viewmodel/assignfrom_model.dart';
import 'package:tasq/core/viewmodel/members_model.dart';
import 'package:tasq/core/viewmodel/myaccounts_model.dart';
import 'package:tasq/core/viewmodel/response_model.dart';
import 'package:tasq/core/viewmodel/task_model.dart';
import 'package:tasq/core/viewmodel/file_picker_model.dart';
import 'package:tasq/core/viewmodel/myrewards_model.dart';
import 'package:get_it/get_it.dart';
import 'naviation_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => MyAppUser());
  locator.registerLazySingleton(() => Organization());
  locator.registerLazySingleton(() => NavigationService());

  locator.registerFactory(() => FilePickerModel());
  locator.registerFactory(() => MyRewardsModel());
  locator.registerFactory(() => TaskModel());
  locator.registerFactory(() => AssignFromViewModel());
  locator.registerFactory(() => ResponseModel());
  locator.registerFactory(() => MembersModel());
  locator.registerFactory(() => MyAccountsModel());
}

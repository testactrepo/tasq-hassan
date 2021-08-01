import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/viewmodel/response_model.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/baseview.dart';
import 'package:tasq/views/organization/mytask/local_widgets/responseitemview.dart';
import 'package:flutter/material.dart';

class ResponsePageView extends StatefulWidget {
  final String taskuid;
  final scaffoldKey;
  ResponsePageView({@required this.taskuid, this.scaffoldKey, Key key})
      : super(key: key);

  @override
  _ResponsePageViewState createState() => _ResponsePageViewState();
}

class _ResponsePageViewState extends State<ResponsePageView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ResponseModel>(
      onModelReady: (model) => model.fetchAllResponses(widget.taskuid),
      builder: (_, model, __) => model.state == ViewState.Busy
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: model.allResponses.length,
              itemBuilder: (_, index) => ResponseItemView(
                taskApplication: model.allResponses[index],
                deleteResponse: (proposaluid) {
                  model.deleteResponse(model.allResponses[index]);
                  Utils.showSnackbar(
                      scaffoldKey: widget.scaffoldKey,
                      message: 'Proposal rejected successfully');
                },
                allocateTask: (taskuid, applicantuid) {
                  model.assignTaskToUser(taskuid, applicantuid);
                  Utils.showSnackbar(
                      scaffoldKey: widget.scaffoldKey,
                      message: 'Task is assigned successfully');
                },
              ),
            ),
    );
  }
}

import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/model/orgmembers.dart';
import 'package:tasq/core/model/user.dart';
import 'package:tasq/core/services/firestore_service.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:tasq/views/auth/local_widgets/linegradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SelectOrganizationUserView extends StatefulWidget {
  const SelectOrganizationUserView({Key key}) : super(key: key);

  @override
  _SelectOrganizationUserViewState createState() =>
      _SelectOrganizationUserViewState();
}

class _SelectOrganizationUserViewState
    extends State<SelectOrganizationUserView> {
  final automcompleteController = TextEditingController();
  MyAppUser user = locator<MyAppUser>();
  FirestoreService firestoreService = FirebaseFirestoreService();
  Organization selectedOrganization;

  @override
  void dispose() {
    automcompleteController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //space from top
              SizedBox(height: 40.0),
              Text(
                "Ready to go\n${user.name} :)",
                style: Theme.of(context).textTheme.headline2,
              ),
              //space
              SizedBox(height: 40.0),
              Text(
                Strings.searchForYourOrganization,
                style: Theme.of(context).textTheme.headline3,
              ),
              //space
              SizedBox(height: 20.0),
              //text field
              autoCompleteTextField(),
              LineGradient(),
              //space
              SizedBox(height: 40.0),
              //skip button
              Center(
                child: TextButton(
                  onPressed: () {
                    Utils.navigateTo(UserAddProfilePageRoute);
                  },
                  child: Text(
                    'skip',
                    style: TextStyle(fontSize: 19.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  autoCompleteTextField() {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: automcompleteController,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
      suggestionsCallback: (query) {
        return firestoreService.searchOrganization(query);
      },
      itemBuilder: (context, Organization organization) {
        return ListTile(
          title: Text(organization.orgName),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (Organization organization) {
        this.automcompleteController.text = organization.orgName;
        //create orMember Object
        OrgMember orgMembers = OrgMember();
        orgMembers.orgid = organization.uid;
        orgMembers.orgname = organization.orgName;
        orgMembers.useruid = user.uid;
        orgMembers.username = user.name;
        orgMembers.role = 'user';
        orgMembers.requeststatus = 0;
        //send request to organization
        FirestoreService fS = FirebaseFirestoreService();
        fS.sendMemberRequestToOrg(orgMembers);

        // user.orgName = organization.orgName;
        // user.orgId = organization.uid;

        Utils.navigateTo(UserAddProfilePageRoute);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please select a city';
        }
        return null;
      },
      // onSaved: (value) => this._selectedCity = value,
    );
  }
}

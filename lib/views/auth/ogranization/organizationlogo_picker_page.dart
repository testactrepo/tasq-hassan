import 'package:tasq/core/enum/usertype.dart';
import 'package:tasq/core/enum/viewstate.dart';
import 'package:tasq/core/model/organization.dart';
import 'package:tasq/core/viewmodel/auth_model.dart';
import 'package:tasq/core/viewmodel/file_picker_model.dart';
import 'package:tasq/utils/constants/appdata.dart';
import 'package:tasq/utils/constants/firebasepath.dart';
import 'package:tasq/utils/constants/mycolors.dart';
import 'package:tasq/utils/constants/strings.dart';
import 'package:tasq/utils/locator.dart';
import 'package:tasq/utils/utils.dart';
import 'package:tasq/views/baseview.dart';
import 'package:tasq/views/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:tasq/utils/router/routing_names.dart';
import 'package:provider/provider.dart';

class OrganizationLogoPickerPage extends StatefulWidget {
  OrganizationLogoPickerPage({Key key}) : super(key: key);

  @override
  _OrganizationLogoPickerPageState createState() =>
      _OrganizationLogoPickerPageState();
}

class _OrganizationLogoPickerPageState
    extends State<OrganizationLogoPickerPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<FilePickerModel>(
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                //space from top
                SizedBox(height: 60.0),
                Text(
                  Strings.organizationlogo,
                  style: Theme.of(context).textTheme.headline2,
                ),
                //space
                SizedBox(height: 60.0),
                //image picker icon
                Center(
                  child: GestureDetector(
                    onTap: () => model.pickImage(),
                    child: Container(
                      width: 180.0,
                      height: 180.0,
                      decoration: BoxDecoration(
                        image: model.pickedFile != null
                            ? DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: FileImage(model.pickedFile))
                            : null,
                        border: Border.all(color: Colors.grey, width: 5),
                        shape: BoxShape.circle,
                      ),
                      child: model.pickedFile != null
                          ? Container()
                          : Icon(
                              Icons.image_rounded,
                              size: 64,
                              color: MyColors.silver,
                            ),
                    ),
                  ),
                ),
                //space
                SizedBox(height: 120.0),

                //next button
                nextButton(model),
                //space
                SizedBox(height: 20.0),
                //uploading progree indicator
                Consumer<AuthModel>(
                  builder: (_, model, __) {
                    if (model.state == ViewState.Busy)
                      return Center(child: CircularProgressIndicator());
                    else
                      return Container(width: 0, height: 0);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  nextButton(FilePickerModel model) {
    return Center(
      child: CustomButton(
        text: 'next',
        borderRadiusValue: 23.0,
        borderColor: MyColors.primaryColor,
        borderWidth: 3.0,
        textColor: Colors.black,
        fontWeight: FontWeight.bold,
        width: MediaQuery.of(context).size.width / 2.2,
        height: 45,
        fontSize: 19.0,
        onTap: () async {
          Organization organization = locator<Organization>();
          AuthModel authModel = Provider.of<AuthModel>(context, listen: false);
          //upload profile picture to storage
          //update organization data in firestore
          await authModel.updateOrganizationData(
              model.pickedFile,
              StoragePath.organizationProfileRef(organization.uid),
              organization);
          //now update userType
          AppData.userType = UserType.ORGANIZATION;

          Utils.navigateTo(InstructionsPageRoute);
        },
      ),
    );
  }
}

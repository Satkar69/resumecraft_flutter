import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/services/project_api_service.dart';
import 'package:resumecraft/utils/mixins/project/project_mixin.dart';
import 'package:resumecraft/models/profile_section/projects/write/project_request_model.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';

import '../../config.dart';

class Project extends StatefulWidget {
  const Project({super.key});

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> with UserProfileMixin, ProjectMixin {
  final Color primaryColor = HexColor('#283B71');
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApicallProcess = false;
  String? projectTitle;
  String? projectDesc;
  String? projLinks;
  List<String> links = [];

  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final id = args?['ProjectId'] as String?;

    if (id != null) {
      setPersonalDetailId(id);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Details',
            style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _profileDetailUI(context),
    );
  }

  Widget _profileDetailUI(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: globalFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "projectTitle",
              "Project Title",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Project Title cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                projectTitle = onSavedVal;
              },
              initialValue: project?.projectTitle ?? "",
              borderFocusColor: primaryColor,
              borderColor: primaryColor,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              labelFontSize: 16,
              paddingLeft: 0,
              paddingRight: 0,
            ),
            const SizedBox(height: 16),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "projectDesc",
              "Project Description",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Project Description cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                projectDesc = onSavedVal;
              },
              initialValue: project?.projectDesc ?? "",
              borderFocusColor: primaryColor,
              borderColor: primaryColor,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              labelFontSize: 16,
              paddingLeft: 0,
              paddingRight: 0,
            ),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "links",
              "Links",
              "www.this.com, www.that.com, ...",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'At least one project link should be an input';
                }
                return null;
              },
              (onSavedVal) {
                projLinks = onSavedVal;
              },
              initialValue: (project?.links)?.join(',') ?? links.join(','),
              hintColor: Colors.black45,
              borderFocusColor: primaryColor,
              borderColor: primaryColor,
              textColor: Colors.black,
              borderRadius: 10,
              labelFontSize: 16,
              paddingLeft: 0,
              paddingRight: 0,
            ),
            const SizedBox(height: 20),
            Center(
              child: FormHelper.submitButton(
                "Save",
                () async {
                  if (validateAndSave()) {
                    setState(() {
                      isApicallProcess = true;
                    });

                    try {
                      ProjectRequestModel model = ProjectRequestModel(
                        userdetail: personalDetailId,
                        projectTitle: projectTitle!,
                        projectDesc: projectDesc!,
                        links: links,
                      );
                      if (project != null) {
                        final response = await ProjectAPIService.updateProject(
                            model, userToken, personalDetailId);
                        setState(() {
                          isApicallProcess = false;
                        });
                        if (response.statusCode == 200) {
                          FormHelper.showSimpleAlertDialog(
                              context, Config.appName, "Project edited!", "OK",
                              () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, '/profile-section');
                          });
                        } else {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Failed to edit project. Please try again.",
                              "OK",
                              () => Navigator.pop(context));
                        }
                      } else {
                        final response = await ProjectAPIService.createProject(
                            model, userToken);
                        setState(() {
                          isApicallProcess = false;
                        });
                        if (response.statusCode == 201) {
                          FormHelper.showSimpleAlertDialog(
                              context, Config.appName, "Personal Saved!", "OK",
                              () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, '/profiles');
                          });
                        } else {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Failed to save project. Please try again.",
                              "OK",
                              () => Navigator.pop(context));
                        }
                      }
                    } catch (e) {
                      setState(() {
                        isApicallProcess = false;
                      });
                      FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "An error occurred. Please try again.",
                          "OK",
                          () => Navigator.pop(context));
                    }
                  }
                  setState(() {
                    isApicallProcess = false;
                  });
                },
                btnColor: Colors.green,
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      if (projLinks?.isNotEmpty ?? false) {
        links = projLinks!.split(',').map((link) => link.trim()).toList();
      }
      return true;
    } else {
      return false;
    }
  }
}

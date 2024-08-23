import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/services/education_api_service.dart';
import 'package:resumecraft/utils/mixins/education/education_mixin.dart';
import 'package:resumecraft/models/profile_section/education/write/education_request_model.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';

import '../../config.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education>
    with UserProfileMixin, EducationMixin {
  final Color primaryColor = HexColor('#283B71');
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApicallProcess = false;
  String? course;
  String? university;
  String? gpa;

  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final id = args?['personalDetailId'] as String?;

    print('check source id profile in education-------------------->$id');

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
      body: _educationUI(context),
    );
  }

  Widget _educationUI(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: globalFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "course",
              "Course",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'FullName cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                course = onSavedVal;
              },
              initialValue: education?.course ?? "",
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
              "university",
              "University",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Address cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                university = onSavedVal;
              },
              initialValue: education?.university ?? "",
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
              "gpa",
              "Gpa",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Email cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                gpa = onSavedVal;
              },
              initialValue: education?.gpa ?? "",
              borderFocusColor: primaryColor,
              borderColor: primaryColor,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
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
                      EducationRequestModel model = EducationRequestModel(
                        userdetail: personalDetailId,
                        course: course!,
                        university: university!,
                        gpa: gpa!,
                      );
                      if (personalDetailId != null) {
                        final response =
                            await EducationAPIService.writeEducation(
                                model, userToken, personalDetailId);
                        setState(() {
                          isApicallProcess = false;
                        });
                        if (response.statusCode == 200) {
                          FormHelper.showSimpleAlertDialog(context,
                              Config.appName, "education edited!", "OK", () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, '/profile-section');
                          });
                        } else {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Failed to education. Please try again.",
                              "OK",
                              () => Navigator.pop(context));
                        }
                      } else {
                        final response =
                            await EducationAPIService.writeEducation(
                                model, userToken, personalDetailId);
                        setState(() {
                          isApicallProcess = false;
                        });
                        if (response.statusCode == 201) {
                          FormHelper.showSimpleAlertDialog(
                              context, Config.appName, "education Saved!", "OK",
                              () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, '/profile-section');
                          });
                        } else {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Failed to save education. Please try again.",
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

      return true;
    } else {
      return false;
    }
  }
}

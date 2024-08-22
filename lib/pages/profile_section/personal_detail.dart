import 'package:flutter/material.dart';
import 'package:resumecraft/services/personal_detail_api_service.dart';
import 'package:resumecraft/utils/mixins/personal_detail/personal_detail_mixin.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/models/profile_section/personal_detail/personal_detail_request_model.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';

import '../../config.dart';

class PersonalDetail extends StatefulWidget {
  const PersonalDetail({super.key});

  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail>
    with UserProfileMixin, PersonalDetailMixin {
  final Color primaryColor = HexColor('#283B71');
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApicallProcess = false;
  String? fullname;
  String? address;
  String? email;
  String? phone;
  String? image;
  String? socialLinks;
  List<String> socials = [];

  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final id = args?['personalDetailId'] as String?;

    print('check source id profile-------------------->$id');

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
              "fullname",
              "FullName",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'FullName cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                fullname = onSavedVal;
              },
              initialValue: personalDetail?.fullname ?? "",
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
              "address",
              "Address",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Address cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                address = onSavedVal;
              },
              initialValue: personalDetail?.address ?? "",
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
              "email",
              "Email",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Email cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                email = onSavedVal;
              },
              initialValue: personalDetail?.email ?? "",
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
              "phone",
              "Phone",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Phone number cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                phone = onSavedVal;
              },
              initialValue: personalDetail?.contact ?? "",
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
              "socials",
              "Socials",
              "www.this.com, www.that.com, ...",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'At least one social link should be an input';
                }
                return null;
              },
              (onSavedVal) {
                socialLinks = onSavedVal;
              },
              initialValue:
                  (personalDetail?.socials)?.join(',') ?? socials.join(','),
              hintColor: Colors.black45,
              borderFocusColor: primaryColor,
              borderColor: primaryColor,
              textColor: Colors.black,
              borderRadius: 10,
              labelFontSize: 16,
              paddingLeft: 0,
              paddingRight: 0,
            ),
            const SizedBox(height: 16),
            const Text(
              'Photo (Optional)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    size: 50,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle Change Photo
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Change',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Handle Remove Photo
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Remove'),
                    ),
                  ],
                ),
              ],
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

                    PersonalDetailRequestModel model =
                        PersonalDetailRequestModel(
                      user: userId,
                      fullname: fullname!,
                      address: address!,
                      email: email!,
                      contact: phone!,
                      socials: socials,
                    );

                    try {
                      if (personalDetailId != null) {
                        final response =
                            await PersonalDetailAPIService.editPersonalDetail(
                                model, userToken, personalDetailId);
                        setState(() {
                          isApicallProcess = false;
                        });
                        if (response.statusCode == 200) {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Personal detail edited!",
                              "OK", () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, '/profile-section');
                          });
                        } else {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Failed to edit personal detail. Please try again.",
                              "OK",
                              () => Navigator.pop(context));
                        }
                      } else {
                        final response =
                            await PersonalDetailAPIService.createPersonalDetail(
                                model, userToken);
                        setState(() {
                          isApicallProcess = false;
                        });
                        if (response.statusCode == 201) {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Personal detail Saved!",
                              "OK", () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, '/profile-section');
                          });
                        } else {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Failed to save personal detail. Please try again.",
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
      if (socialLinks?.isNotEmpty ?? false) {
        socials = socialLinks!.split(',').map((link) => link.trim()).toList();
      }
      return true;
    } else {
      return false;
    }
  }
}

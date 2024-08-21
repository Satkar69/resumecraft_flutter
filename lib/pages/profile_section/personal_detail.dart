import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class PersonalDetail extends StatefulWidget {
  const PersonalDetail({super.key});

  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
  final Color primaryColor = HexColor('#283B71');
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApicallProcess = false;
  String? fullname;
  String? address;
  String? email;
  String? phone;

  @override
  Widget build(BuildContext context) {
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
            FormHelper.inputFieldWidget(
              context,
              "fullname",
              "FullName",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Name cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                fullname = onSavedVal;
              },
              initialValue: "",
              borderFocusColor: primaryColor,
              borderColor: primaryColor,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
            ),
            const SizedBox(height: 16),
            FormHelper.inputFieldWidget(
              context,
              "address",
              "Address",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Address cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                address = onSavedVal;
              },
              initialValue: "",
              maxLength: 3,
              borderFocusColor: primaryColor,
              borderColor: primaryColor,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
            ),
            const SizedBox(height: 16),
            FormHelper.inputFieldWidget(
              context,
              "email",
              "Email",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Email cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                email = onSavedVal;
              },
              initialValue: "",
              borderFocusColor: primaryColor,
              borderColor: primaryColor,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
            ),
            const SizedBox(height: 16),
            FormHelper.inputFieldWidget(
              context,
              "phone",
              "Phone",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Phone number cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                phone = onSavedVal;
              },
              initialValue: "",
              borderFocusColor: primaryColor,
              borderColor: primaryColor,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
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

                    // Implement save logic here (e.g., API call)

                    setState(() {
                      isApicallProcess = false;
                    });

                    // Example of handling a successful save
                    FormHelper.showSimpleAlertDialog(
                      context,
                      "Success",
                      "Details saved successfully",
                      "OK",
                      () => Navigator.pop(context),
                    );
                  }
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

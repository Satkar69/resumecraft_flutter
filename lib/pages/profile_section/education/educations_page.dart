import 'package:flutter/material.dart';
import 'package:resumecraft/config.dart';
import 'package:resumecraft/models/delete/delete_model.dart';
import 'package:resumecraft/services/education_api_service.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/utils/mixins/education/educations_mixin.dart';

class EducationsPage extends StatefulWidget {
  const EducationsPage({super.key});

  @override
  State<EducationsPage> createState() => EducationsPageState();
}

class EducationsPageState extends State<EducationsPage>
    with UserProfileMixin, EducationsMixin {
  final Color primaryColor = HexColor('#283B71');

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final personalDetailID = args?['personalDetailID'] as String?;

    if (personalDetailID != null) {
      setPersonalDetailID(personalDetailID);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Educations', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // This ensures one page back
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (educations.isNotEmpty)
              ...educations.map((education) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Icon(Icons.account_circle, color: Colors.white),
                      ),
                      title: Text(education.course ?? 'No education course'),
                      subtitle: Text(education.university ?? 'No university'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Handle delete action here
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Confirm Delete"),
                                content: Text(
                                    "Are you sure you want to delete this education?"),
                                actions: [
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Delete"),
                                    onPressed: () async {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      final response = await EducationAPIService
                                          .deleteEducation(
                                              DeleteModel(
                                                  status: 'success',
                                                  statusCode: 200,
                                                  message:
                                                      'education delete success'),
                                              userToken,
                                              education.id);
                                      if (response.statusCode == 200) {
                                        FormHelper.showSimpleAlertDialog(
                                            context,
                                            Config.appName,
                                            response.message!,
                                            "OK", () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        });
                                      } else {
                                        FormHelper.showSimpleAlertDialog(
                                            context,
                                            Config.appName,
                                            "Unable to delete this education",
                                            "OK", () {
                                          Navigator.pop(
                                              context); // Close the dialog
                                        });
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/education',
                          arguments: {
                            'educationID': education.id,
                            'personalDetailID': personalDetailID
                          },
                        );
                      },
                    ),
                  ),
                );
              })
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'No educations available. Please create a new education.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                child: const Text('+ Add New Education'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/education',
                    arguments: {'personalDetailID': personalDetailID},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

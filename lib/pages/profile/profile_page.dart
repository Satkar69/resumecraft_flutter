import 'package:flutter/material.dart';
import 'package:resumecraft/config.dart';
import 'package:resumecraft/models/delete/delete_model.dart';
import 'package:resumecraft/services/personal_detail_api_service.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/utils/mixins/personal_detail/personal_details_mixin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with UserProfileMixin, PersonalDetailsMixin {
  final Color primaryColor = HexColor('#283B71');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Choose Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (personalDetails.isNotEmpty)
              ...personalDetails.map((personalDetail) {
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
                      title: Text(personalDetail.fullname ?? 'No Name'),
                      subtitle: Text(personalDetail.email ?? 'No Email'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete,
                            color: Colors
                                .red), // You can adjust the color as needed
                        onPressed: () {
                          // Handle delete action here
                          // For example, you might want to show a confirmation dialog before deleting
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Confirm Delete"),
                                content: Text(
                                    "Are you sure you want to delete this profile?"),
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
                                      // Perform delete operation here
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      final response =
                                          await PersonalDetailAPIService
                                              .deletePersonalDetail(
                                                  DeleteModel(
                                                      status: 'success',
                                                      statusCode: 200,
                                                      message:
                                                          'profile delete success'),
                                                  userToken,
                                                  personalDetail.id);
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
                                            "unable to delete this profile",
                                            "OK", () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        });
                                      }
                                      ;
                                      // Add your delete logic here
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
                          '/profile-section',
                          arguments: {
                            'personalDetailID': personalDetail.id,
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
                  'No profiles available. Please create a new profile.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                child: const Text('+ Create New Profile'),
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
                  Navigator.pushNamed(context, '/personal-detail');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

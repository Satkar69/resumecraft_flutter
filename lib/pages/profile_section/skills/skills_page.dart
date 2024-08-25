import 'package:flutter/material.dart';
import 'package:resumecraft/config.dart';
import 'package:resumecraft/models/delete/delete_model.dart';
import 'package:resumecraft/services/skill_api_service.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/utils/mixins/skill/skills_mixin.dart';

class SkillssPage extends StatefulWidget {
  const SkillssPage({super.key});

  @override
  State<SkillssPage> createState() => SkillssPageState();
}

class SkillssPageState extends State<SkillssPage>
    with UserProfileMixin, SkillsMixin {
  final Color primaryColor = HexColor('#283B71');

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final personalDetailID = args?['personalDetailID'] as String?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Skills', style: TextStyle(color: Colors.white)),
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
            if (skills.isNotEmpty)
              ...skills.map((skill) {
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
                      title: Text(skill.skillName ?? 'No skill name'),
                      subtitle:
                          Text(skill.skillPercentage ?? 'No skill percentage'),
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
                                    "Are you sure you want to delete this skill?"),
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
                                          await SkillAPIService.deleteSkill(
                                              DeleteModel(
                                                  status: 'success',
                                                  statusCode: 200,
                                                  message:
                                                      'skill delete success'),
                                              userToken,
                                              skill.id);
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
                                            "unable to delete this skill",
                                            "OK", () {
                                          Navigator.pop(
                                              context); // Close the dialog
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
                          '/skill',
                          arguments: {
                            'skillID': skill.id,
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
                  'No skills available. Please create a new skill.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                child: const Text('+ Add New Skill'),
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
                  Navigator.pushNamed(context, '/skill');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

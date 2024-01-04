import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/constants/text_styles.dart';
import 'package:to_do_app/model/user_model.dart';
import 'package:to_do_app/view_model/user_profile_view_model.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileViewModel =
        Provider.of<UserProfileViewModel>(context, listen: false);
    return Scaffold(
        body: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.grey.withOpacity(0.4),
        Colors.grey.withOpacity(0.5),
      ])),
      child: StreamBuilder<UserModel>(
          stream: userProfileViewModel.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: SpinKitCircle(
                color: kBlack,
              ));
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                  child: Text(
                'No user data',
                style: kHead2,
              ));
            } else {
              return ListView(
                children: [
                  Center(child: Consumer<UserProfileViewModel>(
                      builder: (context, value, child) {
                    return Stack(
                      children: [
                        value.image != null
                            ? CircleAvatar(
                                radius: 40,
                                child: ClipOval(
                                  child: Image.file(
                                    value.image!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 40,
                                child: ClipOval(
                                  child: Image.network(snapshot
                                          .data?.profileImage ??
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnme6H9VJy3qLGvuHRIX8IK4jRpjo_xUWlTw&usqp=CAU'),
                                ),
                              ),
                        Positioned(
                            left: 55,
                            bottom: -5,
                            child: InkWell(
                              onTap: () => userProfileViewModel.pickImage(),
                              child: value.isUpload
                                  ? const SpinKitCircle(
                                      size: 25,
                                      color: kBlack,
                                    )
                                  : const Icon(
                                      Icons.camera_alt,
                                      color: Colors.blueGrey,
                                    ),
                            ))
                      ],
                    );
                  })),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.grey.shade200,
                    child: ListTile(
                      title: const Text(
                        'User Name:',
                      ),
                      subtitle: Text(
                        snapshot.data!.userName,
                        style: kHead2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.grey.shade200,
                    child: ListTile(
                      title: const Text('User Email:'),
                      subtitle: Text(
                        snapshot.data!.email,
                        style: kHead2,
                      ),
                    ),
                  )
                ],
              );
            }
          }),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/ProfileViewModel.dart';
import 'EditProfileScreen.dart'; // Import ChangeNotifierProvider and Consumer


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileViewModel>(context, listen: false).fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Consumer<ProfileViewModel>(
          builder: (context, profileViewModel, child) {
            if (profileViewModel.emailController.text.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: profileViewModel.profilePic.isNotEmpty
                          ? NetworkImage(profileViewModel
                          .profilePic) as ImageProvider
                          : AssetImage('assets/images/avatar.png'),
                    ),
                    SizedBox(height: 20),
                    ProfileInfoRow(
                      label: 'Name',
                      value: profileViewModel.firstNameController.text + ' ' +
                          profileViewModel.lastNameController.text,
                    ),
                    ProfileInfoRow(
                      label: 'User Name',
                      value: profileViewModel.usernameController.text,
                    ),
                    ProfileInfoRow(
                      label: 'Email',
                      value: profileViewModel.emailController.text,
                    ),
                    ProfileInfoRow(
                      label: 'Phone',
                      value: profileViewModel.phoneNumberController.text,
                    ),
                    ProfileInfoRow(
                      label: 'Address',
                      value: profileViewModel.addressController.text,
                    ),
                    ProfileInfoRow(
                      label: 'Post Code',
                      value: profileViewModel.countryCodeController.text,
                    ),
                    ProfileInfoRow(
                      label: 'About',
                      value: profileViewModel.dobController.text,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileEditScreen()),
                        );
                      },
                      child: Text('Edit Profile'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  ProfileInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

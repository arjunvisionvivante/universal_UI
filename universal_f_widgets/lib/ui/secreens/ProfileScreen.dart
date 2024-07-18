import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/ProfileViewModel.dart'; // Import ChangeNotifierProvider and Consumer
// Import your updated ProfileViewModel

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  // Tablet/Desktop layout
                  return Row(
                    children: [
                      Expanded(
                        child: _buildProfilePicture(viewModel.profilePic),
                      ),
                      Expanded(
                        child: _buildProfileDetails(viewModel),
                      ),
                    ],
                  );
                } else {
                  // Mobile layout
                  return Column(
                    children: [
                      _buildProfilePicture(viewModel.profilePic),
                      _buildProfileDetails(viewModel),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfilePicture(String profilePic) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: profilePic.isNotEmpty
            ? NetworkImage(profilePic)
            : AssetImage('assets/images/anonymous.jpg') as ImageProvider,
      ),
    );
  }

  Widget _buildProfileDetails(ProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${viewModel.firstName} ${viewModel.lastName}', // Updated to use separate variables
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(viewModel.email),
          SizedBox(height: 16),
          _buildDetailRow(Icons.location_on, viewModel.address),
          _buildDetailRow(Icons.phone, viewModel.phoneNumber), // Updated variable name
          _buildDetailRow(Icons.work, viewModel.role), // Updated variable name
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 8),
          Expanded(child: Text(detail)),
        ],
      ),
    );
  }
}
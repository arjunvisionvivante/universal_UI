import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/AuthServices.dart';

class EndDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'User Name', // Replace with actual user name
              style: TextStyle(
                color: Colors.white,
                fontSize: 24, // Increased font size for better emphasis
                fontWeight: FontWeight.bold,
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor, // Use your theme color
            ),
          ),
          _createDrawerItem(
            icon: Icons.person,
            text: 'Profile',
            onTap: () {
              Navigator.pushNamed(context, "/profile").then((_)=>Navigator.pop(context));

              // Navigate to Profile screen
            },
          ),
          _createDrawerItem(
            icon: Icons.lock,
            text: 'Change Password',
            onTap: () {
              Navigator.pop(context);
              // Navigate to Change Password screen
            },
          ),
          _createDrawerItem(
            icon: Icons.list,
            text: 'Orders Listing',
            onTap: () {
              Navigator.pop(context);
              // Navigate to Orders Listing screen
            },
          ),
          _createDrawerItem(
            icon: Icons.phone,
            text: 'Contact Us',
            onTap: () {
              Navigator.pop(context);
              // Navigate to Contact Us screen
            },
          ),
          _createDrawerItem(
            icon: Icons.shopping_cart,
            text: 'Cart',
            onTap: () {
              Navigator.pop(context);
              // Navigate to Cart screen
            },
          ),
          _createDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              context.read<AuthService>().logout(context);
              // Implement logout functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text ?? "",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

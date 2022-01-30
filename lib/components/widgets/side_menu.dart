import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/menu_list_tile.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/log_in/log_in_page.dart';
import 'package:stoady/pages/user/avatar/avatar_page.dart';
import 'package:stoady/pages/user/group/group_page.dart';
import 'package:stoady/pages/user/home/home_page.dart';
import 'package:stoady/pages/user/saved/saved_page.dart';
import 'package:stoady/pages/user/statistics/statistics_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(Logic.currentUser.getName(),
                style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black)),
            accountEmail: Text(Logic.currentUser.getEmail(),
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black38)),
            currentAccountPicture: GestureDetector(child: CircleAvatar(
                child: ClipOval(
              child: Image.network(
                Logic.currentUser.getAvatar(),
                width: 95,
                height: 95,
                fit: BoxFit.cover,
              ),
            )),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SelectAvatarPage())),),

          ),
          MenuListTile(
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SavedQuestionsPage())),
              text: 'Saved',
              icon: Icons.star_outline_rounded),
          MenuListTile(
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StatisticsPage())),
              text: 'Statistics',
              icon: Icons.bar_chart_rounded),
          MenuListTile(
              press: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const GroupPage())),
              text: 'Groups',
              icon: Icons.groups_outlined),
          MenuListTile(
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserHomePage())),
              text: 'Subjects',
              icon: Icons.library_books_outlined),

          // TODO: check that person is admin in this group.
          MenuListTile(
              press: () => {},
              text: 'Admin Mode',
              icon: Icons.admin_panel_settings_outlined),
          const Divider(),
          MenuListTile(
              press: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LogInPage())),
              text: 'Log Out',
              icon: Icons.exit_to_app)
        ],
      ),
    );
  }
}

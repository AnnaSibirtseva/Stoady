import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/log_in/log_in_page.dart';
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
            currentAccountPicture: CircleAvatar(
                child: ClipOval(
              child: Image.network(
                'https://ie.wampi.ru/2022/01/01/frog-prince-1.png',
                width: 95,
                height: 95,
                fit: BoxFit.cover,
              ),
            )),
          ),
          ListTile(
            leading: const Icon(Icons.star_outline_rounded,
                size: 35, color: Colors.black),
            title: const Text('Saved',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700)),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SavedQuestionsPage())),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart_rounded,
                size: 35, color: Colors.black),
            title: const Text('Statistics',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700)),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const StatisticsPage())),
          ),
          ListTile(
            leading: const Icon(Icons.groups_outlined,
                size: 35, color: Colors.black),
            title: const Text('Groups',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700)),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GroupPage())),
          ),
          // TODO: check that person is admin in this group.
          ListTile(
            leading: const Icon(Icons.admin_panel_settings_outlined,
                size: 35, color: Colors.black),
            title: const Text('Admin Mode',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700)),
            onTap: () => {},
          ),
          const Divider(),
          ListTile(
            leading:
                const Icon(Icons.exit_to_app, size: 35, color: Colors.black),
            title: const Text('Log Out',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700)),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LogInPage())),
          )
        ],
      ),
    );
  }
}

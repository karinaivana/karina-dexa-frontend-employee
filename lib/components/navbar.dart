import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constant/route_name.dart';
import '../utils/shared_pref.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final SharedPrefForObject sharedPref = SharedPrefForObject();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            padding: EdgeInsets.fromLTRB(16.0, 36.0, 16.0, 8.0),
            decoration: BoxDecoration(color: Color(0xff9f2a28)),
            child: AutoSizeText(
              'Menu Navigasi',
              maxLines: 1,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const AutoSizeText('Halaman Utama', maxLines: 1),
            onTap: () =>
                {Navigator.of(context).pushNamed(RoutesName.HOME_PAGE)},
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const AutoSizeText('Profil', maxLines: 1),
            onTap: () => {Navigator.of(context).pushNamed(RoutesName.PROFILE)},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const AutoSizeText('Keluar', maxLines: 1),
            onTap: () async => {
              await sharedPref.remove("employee_data"),
              Navigator.of(context).pushNamed(RoutesName.LOGIN)
            },
          ),
        ],
      ),
    );
  }
}

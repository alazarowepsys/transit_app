import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transit_app/routes.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 235,
            child: DrawerHeader(
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/digesett.png"),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Transit App",
                    style: GoogleFonts.gabarito(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit_document, color: Colors.white, size: 30),
            title: Text(
              "Registro de multas",
              style: GoogleFonts.gabarito(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(kFineRegisterRoute);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.grid_view_rounded,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              "Multas registradas",
              style: GoogleFonts.gabarito(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(kFinesRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.white, size: 30),
            title: Text(
              "Acerca del agente",
              style: GoogleFonts.gabarito(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(kAboutRoute);
            },
          ),
        ],
      ),
    );
  }
}

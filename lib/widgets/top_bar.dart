import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key, required this.title, this.useArrowBack = false});

  final String title;
  final bool useArrowBack;

  @override
  Widget build(BuildContext context) {
    if (useArrowBack) {
      return AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          title,
          style: GoogleFonts.gabarito(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      );
    }

    return AppBar(
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(Icons.menu, color: Colors.white, size: 30),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        title,
        style: GoogleFonts.gabarito(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

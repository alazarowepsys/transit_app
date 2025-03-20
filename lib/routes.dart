import 'package:flutter/material.dart';
import 'package:transit_app/screens/about_screen.dart';
import 'package:transit_app/screens/fines_screen.dart';
import 'package:transit_app/screens/new_fine_screen.dart';

const String kFineRegisterRoute = '/new-fine';
const String kFinesRoute = '/fines';
const String kAboutRoute = '/about';

final Map<String, Widget Function(BuildContext)> kRoutes = {
  kFineRegisterRoute: (context) => NewFineScreen(),
  kFinesRoute: (context) => FinesScreen(),
  kAboutRoute: (context) => AboutScreen(),
};

import 'package:flutter/material.dart';
import 'package:transit_app/widgets/side_bar.dart';
import 'package:transit_app/widgets/top_bar.dart';

class NewFineScreen extends StatefulWidget {
  const NewFineScreen({super.key});

  @override
  State<NewFineScreen> createState() => _NewFineScreenState();
}

class _NewFineScreenState extends State<NewFineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: TopBar(title: "Nueva multa"),
      drawer: SideBar(),
    );
  }
}

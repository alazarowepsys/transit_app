import 'package:flutter/material.dart';
import 'package:transit_app/widgets/top_bar.dart';

class FineDetailsScreen extends StatelessWidget {
  const FineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: TopBar(title: "Detalles de la multa"));
  }
}

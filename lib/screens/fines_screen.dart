import 'package:flutter/material.dart';
import 'package:transit_app/widgets/side_bar.dart';
import 'package:transit_app/widgets/top_bar.dart';

class FinesScreen extends StatelessWidget {
  const FinesScreen({super.key});

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Eliminar multas"),
          content: Text(
            "¿Estás seguro de que deseas eliminar todas las multas? Debes realizar esta accion justo al finalizar tu jornada laboral.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: TopBar(title: "Multas registradas"),
      drawer: SideBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDeleteDialog(context);
        },
        child: Icon(Icons.delete_forever_rounded),
      ),
    );
  }
}

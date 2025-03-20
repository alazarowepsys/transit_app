import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transit_app/services/database_service.dart';
import 'package:transit_app/widgets/side_bar.dart';
import 'package:transit_app/widgets/top_bar.dart';

class FinesScreen extends StatelessWidget {
  FinesScreen({super.key});
  final DatabaseService _databaseService = DatabaseService();

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
        onPressed: () => _showDeleteDialog(context),
        child: Icon(Icons.delete_forever_rounded),
      ),
      body: Center(
        child: FutureBuilder(
          future: _databaseService.getFines(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              );
            }

            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Tenemos problemas en cargar las multas, por favor intente luego.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.gabarito(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              );
            }

            if (snapshot.data!.isEmpty) {
              return SizedBox(
                width: double.infinity,
                child: Text(
                  "No hay multas registradas",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.gabarito(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final fine = snapshot.data![index];
                return ListTile(
                  title: Text(
                    "Matrícula: ${fine.licensePlate}",
                    style: GoogleFonts.gabarito(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    "Tipo de infracción: ${fine.violationType}",
                    style: GoogleFonts.gabarito(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

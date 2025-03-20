import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transit_app/widgets/side_bar.dart';
import 'package:transit_app/widgets/top_bar.dart';
import 'package:transparent_image/transparent_image.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: TopBar(title: "Acerca del agente"),
      drawer: SideBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Nombre del agente",
              style: GoogleFonts.gabarito(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            Text(
              "Ariel David Lázaro Pérez",
              style: GoogleFonts.gabarito(
                fontWeight: FontWeight.w500,
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Matrícula del agente",
              style: GoogleFonts.gabarito(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            Text(
              "2023-0253",
              style: GoogleFonts.gabarito(
                fontWeight: FontWeight.w500,
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            FadeInImage(
              width: 200,
              height: 200,
              placeholder: MemoryImage(kTransparentImage),
              image: AssetImage("assets/images/yo.png"),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 55),
              child: Text(
                "\"La seguridad vial es un compromiso con la vida y un acto de servicio a la comunidad. Conduce con responsabilidad y protege a quienes te rodean.\"",
                style: GoogleFonts.gabarito(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

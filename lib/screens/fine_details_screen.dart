import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transit_app/models/fine.dart';
import 'package:transit_app/widgets/audio_player_widget.dart';
import 'package:transit_app/widgets/top_bar.dart';

class FineDetailsScreen extends StatelessWidget {
  FineDetailsScreen(this.fine, {super.key});

  Fine fine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: "Detalles de la multa", useArrowBack: true),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView(
            children: <Widget>[
              Text(
                "Marbete: ${fine.tagCode}",
                style: GoogleFonts.gabarito(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Marca: ${fine.brand}",
                style: GoogleFonts.gabarito(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Modelo: ${fine.model}",
                style: GoogleFonts.gabarito(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Color: ${fine.color}",
                style: GoogleFonts.gabarito(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Año: ${fine.year}",
                style: GoogleFonts.gabarito(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Placa: ${fine.licensePlate}",
                style: GoogleFonts.gabarito(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Tipo de Infracción: ${fine.violationType}",
                style: GoogleFonts.gabarito(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Fecha y hora: ${fine.timestamp.day}/${fine.timestamp.month}/${fine.timestamp.year} ${fine.timestamp.hour}:${fine.timestamp.minute}",
                style: GoogleFonts.gabarito(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Descripión: ${fine.description}",
                style: GoogleFonts.gabarito(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Image.file(File(fine.imagePath), width: 200, height: 300),
              AudioPlayerWidget(path: fine.audioRecordPath),
            ],
          ),
        ),
      ),
    );
  }
}

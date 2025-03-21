// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transit_app/constants/violation_type.dart';
import 'package:transit_app/models/fine.dart';
import 'package:transit_app/services/database_service.dart';
import 'package:transit_app/widgets/audio_record_btn.dart';
import 'package:transit_app/widgets/side_bar.dart';
import 'package:transit_app/widgets/top_bar.dart';
import 'package:http/http.dart';

class NewFineScreen extends StatefulWidget {
  const NewFineScreen({super.key});

  @override
  State<NewFineScreen> createState() => _NewFineScreenState();
}

class _NewFineScreenState extends State<NewFineScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _tagCodeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Map<String, dynamic>? _vehicleData;
  bool _isLoading = false;
  DateTime? _pickedDateTime;
  String _violationType = ViolationTypes.speeding;
  File? _pickedImage;
  File? _recordedAudio;
  bool _verifiedTag = false;

  @override
  void initState() {
    super.initState();
    _tagCodeController.addListener(() {
      setState(() {
        _verifiedTag = false;
      });
    });
  }

  Future<void> _fetchVehicleInfo(BuildContext context, String tagCode) async {
    setState(() {
      _isLoading = true;
    });

    Uri uri = Uri.parse("https://api.adamix.net/itla.php?m=$tagCode");
    Response response = await get(uri);

    if (response.statusCode >= 400) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Hubo un problema"),
            content: Text(
              "Tuvimos un error tratando de verificar el marbete, por favor, verifique que tenga acceso a internet, si el problema persiste, contacte a su administrador.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Entendido"),
              ),
            ],
          );
        },
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    Map<String, dynamic> data = json.decode(response.body);

    if (data["ok"] == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Marbete incorrecto"),
            content: Text(
              "El marbete que usted ha introducido es incorrecto o está desactualizado.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Entendido"),
              ),
            ],
          );
        },
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = false;
      _vehicleData = data;
      _verifiedTag = true;
    });
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 7)),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _pickedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    late Widget content;

    if (!_isLoading && _vehicleData == null) {
      content = SizedBox.shrink();
    } else if (!_isLoading && _vehicleData != null) {
      content = Text(
        """
Marca: ${_vehicleData!["marca"]}
Modelo: ${_vehicleData!["modelo"]}
Color: ${_vehicleData!["color"]}
Año: ${_vehicleData!["anio"]}
Placa: ${_vehicleData!["placa"]}
        """,
        textAlign: TextAlign.center,
        style: GoogleFonts.gabarito(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      );
    } else {
      content = CircularProgressIndicator(color: Colors.white);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: TopBar(title: "Nueva multa"),
      drawer: SideBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView(
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _tagCodeController,
                  decoration: InputDecoration(
                    labelText: "Código de marbete",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextButton.icon(
                  onPressed: () {
                    if (_tagCodeController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Marbete incorrecto"),
                            content: Text(
                              "Por favor, ingrese un código de marbete para verificar su validez.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Entendido"),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    _fetchVehicleInfo(context, _tagCodeController.text);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withAlpha(120),
                  ),
                  icon: Icon(Icons.search, color: Colors.white, size: 24),
                  label: Text(
                    "Verificar marbete",
                    style: GoogleFonts.gabarito(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(child: content),
                DropdownButton<String>(
                  menuWidth: 300,
                  isExpanded: true,
                  iconEnabledColor: Colors.green,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  value: _violationType,
                  items:
                      ViolationTypes.allOptions.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                  onChanged: (String? nuevaOpcion) {
                    setState(() {
                      _violationType = nuevaOpcion!;
                    });
                  },
                ),
                //MapInput(),
                TextButton.icon(
                  onPressed: () {
                    _selectDateTime(context);
                  },
                  label: Text(
                    _pickedDateTime == null
                        ? "Fecha y hora no seleccionada"
                        : "${_pickedDateTime!.day}/${_pickedDateTime!.month}/${_pickedDateTime!.year} ${_pickedDateTime!.hour.toString().padLeft(2, '0')}:${_pickedDateTime!.minute.toString().padLeft(2, '0')}",
                    style: GoogleFonts.gabarito(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  icon: Icon(Icons.calendar_month, color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Descripción de la multa",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  height: 200,
                  width: 300,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: _takePicture,
                    child:
                        _pickedImage == null
                            ? Text(
                              "Tomar foto",
                              style: GoogleFonts.gabarito(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            )
                            : GestureDetector(
                              onTap: _takePicture,
                              child: Image.file(
                                _pickedImage!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                  ),
                ),
                SizedBox(height: 20),
                AudioRecordButton(
                  onRecorded: (path) {
                    _recordedAudio = File(path);
                  },
                ),
                SizedBox(height: 35),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withAlpha(120),
                  ),
                  onPressed: () async {
                    if (!_verifiedTag ||
                        _pickedDateTime == null ||
                        _pickedImage == null ||
                        _descriptionController.text.isEmpty ||
                        _recordedAudio == null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Datos incompletos"),
                            content: Text(
                              "Por favor, verifique que haya ingresado todos los datos necesarios para registrar la multa.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Entendido"),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    int rowsAffected = await _databaseService.insertFine(
                      Fine(
                        audioRecordPath: _recordedAudio!.path,
                        description: _descriptionController.text,
                        imagePath: _pickedImage!.path,
                        tagCode: _tagCodeController.text,
                        violationType: _violationType,
                        brand: _vehicleData!["marca"],
                        model: _vehicleData!["modelo"],
                        color: _vehicleData!["color"],
                        year: int.parse(_vehicleData!["anio"]),
                        licensePlate: _vehicleData!["placa"],
                        timestamp: _pickedDateTime!,
                      ),
                    );

                    if (rowsAffected != 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Multa registrada correctamente."),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Hubo un problema al registrar la multa.",
                          ),
                        ),
                      );
                    }
                  },
                  label: Text(
                    "Registrar multa",
                    style: GoogleFonts.gabarito(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: Icon(Icons.save, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _takePicture() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 600,
      maxWidth: 800,
    );

    if (pickedImage == null) {
      return;
    }

    Directory directory = await getApplicationDocumentsDirectory();
    String imagePath = join(
      directory.path,
      DateTime.now().millisecondsSinceEpoch.toString(),
    );
    File imageFile = await File(pickedImage.path).copy(imagePath);
    setState(() {
      _pickedImage = imageFile;
    });
  }
}

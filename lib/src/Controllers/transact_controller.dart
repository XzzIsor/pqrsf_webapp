import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:pqrsf_webapp/src/Models/models.dart';
import 'package:pqrsf_webapp/src/apilink.dart';

class TransactController extends ChangeNotifier {
  TransactShow _selectedTransact = TransactShow(
      id: 0,
      tipoPqrsf: '',
      peticionario: '',
      tipoPeticionario: '',
      numeroOficio: '',
      dependencia: '',
      email: '',
      celular: '',
      direccion: '',
      fechaRecepcion: '',
      fechaVencimiento: '',
      medioRecepcion: '',
      descripcion: '',
      traza: [],
      asunto: '');
  String _selectedVU = "";

  TransactShow get selectedTransact => _selectedTransact;
  String get selectedVU => _selectedVU;

  TransactController();

  Future<List<TableTransact>> getAllTransacts() async {
    List<TableTransact> transacts = [];
    const url = '$apiLink/tramite/lista';
    Uri uri = Uri.parse(url);

    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"numeroVU": null, "idTipoTramite": null}));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      for (var element in data) {
        transacts.add(TableTransact.fromJson(element));
      }
    } else {}

    return transacts;
  }

  Future<bool> registerTransact(Transact newTransact) async {
    const url = '$apiLink/tramite';
    Uri uri = Uri.parse(url);

    String json = jsonEncode(newTransact);
    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'}, body: json);

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<List<TableTransact>> filterTransacts(int? numVU, int? type) async {
    List<TableTransact> transacts = [];

    const url = '$apiLink/tramite/lista';
    Uri uri = Uri.parse(url);

    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"numeroVU": numVU, "idTipoTramite": type}));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      for (var element in data) {
        transacts.add(TableTransact.fromJson(element));
      }
    } else {}

    return transacts;
  }

  Future<void> getTransactByID(int numVU) async {
    String url = '$apiLink/traza?numeroVU=$numVU';
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    dynamic data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      _selectedTransact = TransactShow.fromJson(data);
      _selectedVU = numVU.toString();
      notifyListeners();
    } else {
      _selectedTransact = TransactShow(
          id: 0,
          tipoPqrsf: '',
          peticionario: '',
          tipoPeticionario: '',
          numeroOficio: '',
          dependencia: '',
          email: '',
          celular: '',
          direccion: '',
          fechaRecepcion: '',
          fechaVencimiento: '',
          medioRecepcion: '',
          descripcion: '',
          traza: [],
          asunto: '');
      notifyListeners();
    }
  }

  Future<bool> registerTrace(
      int numVU, int dependency, String numOficio, String description) async {
    const url = '$apiLink/traza';
    Uri uri = Uri.parse(url);

    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "numeroVU": numVU,
          "idDependencia": dependency,
          "numeroOficio": numOficio,
          "descripcion": description
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

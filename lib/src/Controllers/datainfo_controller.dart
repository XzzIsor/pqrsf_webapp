import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:pqrsf_webapp/src/Models/models.dart';
import 'package:pqrsf_webapp/src/apilink.dart';

class DataInfoController extends ChangeNotifier {
  final List<Dependency> _dependencies = [];
  final List<TransactType> _transactsTypes = [];
  final List<ReceptionType> _receptionTypes = [];
  final List<PeticionaryType> _peticionaryTypes = [];

  List<String> getDependencies() {
    List<String> values = [];

    for (var element in _dependencies) {
      values.add(element.descripcion);
    }

    return values;
  }

  List<String> getTransactTypes() {
    List<String> values = [];

    for (var element in _transactsTypes) {
      values.add(element.descripcion);
    }

    return values;
  }

  List<String> getReceptionTypes() {
    List<String> values = [];

    for (var element in _receptionTypes) {
      values.add(element.descripcion);
    }

    return values;
  }

  List<String> getPeticionaryTypes() {
    List<String> values = [];

    for (var element in _peticionaryTypes) {
      values.add(element.descripcion);
    }

    return values;
  }

  DataInfoController() {
    getAllData();
  }

  Future<void> _getDependencies() async {
    const url = '$apiLink/catalogo/dependencia';
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      _dependencies.clear();

      for (var element in data) {
        _dependencies.add(Dependency.fromJson(element));
      }
    } else {
      print(jsonDecode(response.body));
    }
  }

  Future<void> _getTransactTypes() async {
    const url = '$apiLink/catalogo/tipo-tramite';
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      _dependencies.clear();

      for (var element in data) {
        _transactsTypes.add(TransactType.fromJson(element));
      }
    } else {
      print(jsonDecode(response.body));
    }
  }

  Future<void> _getReceptionTypes() async {
    const url = '$apiLink/catalogo/tipo-recepcion';
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      _dependencies.clear();

      for (var element in data) {
        _receptionTypes.add(ReceptionType.fromJson(element));
      }
    } else {
      print(jsonDecode(response.body));
    }
  }

  Future<void> _getPeticionaryTypes() async {
    const url = '$apiLink/catalogo/tipo-recepcion';
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      _dependencies.clear();

      for (var element in data) {
        _peticionaryTypes.add(PeticionaryType.fromJson(element));
      }
    } else {
      print(jsonDecode(response.body));
    }
  }

  Future<void> getAllData() async {
    await _getDependencies();
    await _getPeticionaryTypes();
    await _getReceptionTypes();
    await _getTransactTypes();
  }
}

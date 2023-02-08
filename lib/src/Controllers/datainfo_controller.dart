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

  int indexPeticionryType = -1;
  int indexDependency = -1;
  int indexReceptionType = -1;
  int indexTransactTypes = -1;

  void resetIndexes() {
    indexPeticionryType = -1;
    indexDependency = -1;
    indexReceptionType = -1;
    indexTransactTypes = -1;
  }

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
    } else {}
  }

  Future<void> _getTransactTypes() async {
    const url = '$apiLink/catalogo/tipo-tramite';
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      _transactsTypes.clear();

      for (var element in data) {
        _transactsTypes.add(TransactType.fromJson(element));
      }
    } else {}
  }

  Future<void> _getReceptionTypes() async {
    const url = '$apiLink/catalogo/tipo-recepcion';
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      _receptionTypes.clear();

      for (var element in data) {
        _receptionTypes.add(ReceptionType.fromJson(element));
      }
    } else {}
  }

  Future<void> _getPeticionaryTypes() async {
    const url = '$apiLink/catalogo/tipo-peticionario';
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      _peticionaryTypes.clear();

      for (var element in data) {
        _peticionaryTypes.add(PeticionaryType.fromJson(element));
      }
    } else {}
  }

  Future<bool> getAllData() async {
    await _getDependencies();
    await _getPeticionaryTypes();
    await _getReceptionTypes();
    await _getTransactTypes();
    return true;
  }
}

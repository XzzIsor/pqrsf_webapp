import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:pqrsf_webapp/src/Models/Models.dart';
import 'package:pqrsf_webapp/src/apilink.dart';

class DataInfoController {
  final List<Dependency> _dependencies = [];
  final List<TransactType> _transactsTypes = [];
  final List<ReceptionType> _receptionTypes = [];
  final List<PeticionaryType> _peticionaryTypes = [];

  get dependencies => _dependencies;
  get transactsTypes => _transactsTypes;
  get receptionTypes => _receptionTypes;
  get peticionaryTypes => _receptionTypes;

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

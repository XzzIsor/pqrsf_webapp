import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:pqrsf_webapp/src/Models/models.dart';
import 'package:pqrsf_webapp/src/apilink.dart';

class TransactController {
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
    } else {
      print(jsonDecode(response.body));
    }

    return transacts;
  }
}

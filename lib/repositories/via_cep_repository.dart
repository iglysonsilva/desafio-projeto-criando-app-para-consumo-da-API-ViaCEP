import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/cep_model.dart';

class ViaCepRepository {
  Future<CepModel> consultarCEP(String cep) async {
    var response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    if (response.statusCode == HttpStatus.ok) {
      var json = jsonDecode(response.body);
      if(json['erro'] != null){
        return CepModel.vazio();
      }
      return CepModel.fromJson(json);
    }
    return CepModel.vazio();
  }
}

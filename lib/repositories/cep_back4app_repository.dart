import 'package:app_viacep_back4app/models/ceps_back4app_model.dart';

import '../models/cep_model.dart';
import 'dio/back4app_custom_dio.dart';

class CepBack4appRepository {
  final _dioCustom = Back4appCustomDio();

  Future<CepsBack4appModel> findAll() async {
    var url = '/Ceps';
    var result = await _dioCustom.dio.get(url);
    return CepsBack4appModel.fromJson(result.data);
  }

  Future<CepsBack4appModel> findByCep(var cep) async {
    var url = '/Ceps';
    url = '$url?where={\"cep":\"$cep"}';
    var result = await _dioCustom.dio.get(url);
    return CepsBack4appModel.fromJson(result.data);
  }

  Future<void> criar(CepModel cepModel) async {
    var url = '/Ceps';
    print(cepModel.toCreateJson());
    await _dioCustom.dio.post(url, data: cepModel.toCreateJson());
  }

  Future<void> atualizar(CepModel cepModel) async {
    var url = '/Ceps/${cepModel.objectId}';
    await _dioCustom.dio.put(url, data: cepModel.toCreateJson());
  }

  Future<void> remover(CepModel cepModel) async {
    var url = '/Ceps/${cepModel.objectId}';
    await _dioCustom.dio.delete(url);
  }
}

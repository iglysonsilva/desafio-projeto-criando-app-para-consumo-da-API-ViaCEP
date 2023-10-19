import 'cep_model.dart';

class CepsBack4appModel {
  List<CepModel> ceps = [];

  CepsBack4appModel( this.ceps );

  CepsBack4appModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      ceps = <CepModel>[];
      json['results'].forEach((v) {
        ceps.add(CepModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.ceps != null) {
      data['results'] = this.ceps.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

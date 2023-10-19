import 'package:flutter/material.dart';

import '../models/cep_model.dart';
import '../repositories/cep_back4app_repository.dart';

class EdicaoCepPage extends StatefulWidget {
  CepModel cepModel;

  EdicaoCepPage(this.cepModel);

  @override
  _EdicaoCepPageState createState() => _EdicaoCepPageState();
}

class _EdicaoCepPageState extends State<EdicaoCepPage> {
  var cepController = TextEditingController(text: '');
  var cidadeController = TextEditingController(text: '');
  var ufController = TextEditingController(text: '');
  var ddController = TextEditingController(text: '');
  var ruaController = TextEditingController(text: '');
  var ibgbeController = TextEditingController(text: '');
  var giaController = TextEditingController(text: '');
  var bairroCotroller = TextEditingController(text: '');
  var siafiController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  var cepRepository = CepBack4appRepository();

  @override
  void initState() {
    atribuiValores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Edição de CEP'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: true,
                        controller: cepController,
                        decoration: const InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(),
                          label: Text('CEP'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cidadeController,
                        onSaved: (String? val) {
                          widget.cepModel.localidade = val!;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Cidade'),
                        ),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Campo obrigatório!';
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: ruaController,
                        onSaved: (String? val) {
                          widget.cepModel.logradouro = val!;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Rua'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: bairroCotroller,
                        onSaved: (String? val) {
                          widget.cepModel.bairro = val!;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Bairro'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: ibgbeController,
                        onSaved: (String? val) {
                          widget.cepModel.ibge = val!;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Código Ibge'),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: ufController,
                              onSaved: (String? val) {
                                widget.cepModel.uf = val!;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('UF'),
                              ),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Campo obrigatório';
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: ddController,
                              onSaved: (String? val) {
                                widget.cepModel.ddd = val!;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('DDD'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: giaController,
                              onSaved: (String? val) {
                                widget.cepModel.gia = val!;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('GIA'),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: siafiController,
                              onSaved: (String? val) {
                                widget.cepModel.siafi = val!;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('SIAFI'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    loading
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  salvar();
                                },
                                child: const Text(
                                  'Salvar',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void salvar() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        setState(() {
          loading = true;
        });
        cepRepository.atualizar(widget.cepModel);
        Navigator.pop(context, true);
        setState(() {
          loading = false;
        });
      } catch (e) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  void atribuiValores() {
    cepController.text = widget.cepModel.cep;
    ddController.text = widget.cepModel.ddd;
    giaController.text = widget.cepModel.gia;
    siafiController.text = widget.cepModel.siafi;
    bairroCotroller.text = widget.cepModel.bairro;
    ruaController.text = widget.cepModel.logradouro;
    ufController.text = widget.cepModel.uf;
    cidadeController.text = widget.cepModel.localidade;
    ibgbeController.text = widget.cepModel.ibge;
  }
}

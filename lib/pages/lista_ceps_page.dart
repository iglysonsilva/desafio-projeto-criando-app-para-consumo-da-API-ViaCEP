import 'package:app_viacep_back4app/pages/edicao_cep_page.dart';
import 'package:app_viacep_back4app/repositories/cep_back4app_repository.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:flutter/material.dart';

import '../models/cep_model.dart';
import '../models/ceps_back4app_model.dart';
import '../repositories/via_cep_repository.dart';

class ListaCepsPage extends StatefulWidget {
  @override
  _ListaCepsPageState createState() => _ListaCepsPageState();
}

class _ListaCepsPageState extends State<ListaCepsPage> {
  var cepController = TextEditingController(text: '');
  var maskFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {'#': RegExp(r'[0-9]')},
  );
  bool loading = false;

  var viaCepModel = CepModel.vazio();
  var viaCepRepository = ViaCepRepository();
  var cepRepository = CepBack4appRepository();
  var msgExecutando = '';
  var cepNaoEncontrado = false;
  var _ceps = CepsBack4appModel([]);

  @override
  void initState() {
    carregaCeps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const Text(
                'Lista CEPs Cadastrados',
                style: TextStyle(fontSize: 25),
              ),
              Visibility(
                visible: _ceps.ceps.isEmpty && !loading,
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: const [
                          SizedBox(
                            height: 20,
                          ),
                          Icon(
                            Icons.search_off_sharp,
                            size: 45,
                            color: Colors.deepOrange,
                          ),
                          Text(
                            'Nenhum CEP encontrado para apresentar',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              loading
                  ? const Center(
                      child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ))
                  : Expanded(
                      child: ListView.builder(
                          itemCount: _ceps.ceps.length,
                          itemBuilder: (BuildContext bc, int index) {
                            return Dismissible(
                              key: Key(_ceps.ceps[index].objectId!),
                              child: GestureDetector(
                                onTap: () async {
                                  var ret = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EdicaoCepPage(_ceps.ceps[index]),
                                    ),
                                  );

                                  if (ret != null && ret) {
                                    carregaCeps();
                                  }
                                },
                                child: ListTile(
                                  title: Text(_ceps.ceps[index].cep.toString()),
                                  subtitle: Text('${_ceps.ceps[index].localidade}-${_ceps.ceps[index].uf}'),
                                  trailing: InkWell(
                                      child: const Icon(Icons.delete),
                                      onTap: () {
                                        remover(index);
                                      }),
                                ),
                              ),
                              onDismissed: (DismissDirection dis) {
                                remover(index);
                              },
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void remover(int index) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
            title: const Text('Deseja excluir esse CEP ?'),
            content: Text(_ceps.ceps[index].cep.toString()),
            actions: [
              TextButton(
                  onPressed: () async {
                    carregaCeps();
                    Navigator.pop(context);
                  },
                  child: const Text('Não')),
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    setLoading(true);
                    await cepRepository.remover(_ceps.ceps[index]);
                    carregaCeps();
                  },
                  child: const Text('Sim')),
            ],
          );
        });
  }

  Future<void> carregaCeps() async {
    setLoading(true);
    _ceps = await cepRepository.findAll();
    setLoading(false);
  }

  void setLoading(bool val) {
    setState(() {
      loading = val;
    });
  }
}

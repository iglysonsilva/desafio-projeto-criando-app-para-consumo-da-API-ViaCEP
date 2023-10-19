import 'package:app_viacep_back4app/pages/busca_cep_page.dart';
import 'package:flutter/material.dart';

import 'lista_ceps_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ViaCEP e Back4app"),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    posicaoPagina = value;
                  });
                },
                children: [
                  BuscaCepPage(),
                  ListaCepsPage(),
                ],
              ),
            ),
            BottomNavigationBar(
                iconSize: 35,
                unselectedFontSize: 15,
                selectedFontSize: 18,
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  controller.jumpToPage(value);
                },
                currentIndex: posicaoPagina,
                items: const [
                  BottomNavigationBarItem(
                    label: "Consulta",
                    icon: Icon(Icons.search),
                  ),
                  BottomNavigationBarItem(
                    label: "Cadastrados",
                    icon: Icon(Icons.playlist_add_check_outlined),
                  ),
                ])
          ],
        ),
      ),
    );
  }
}

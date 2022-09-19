import 'package:flutter/material.dart';
import 'package:news_provider/src/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.green,
        ),
      ],
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (value) => navegacionModel.paginaActual = value,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'para ti',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Encabezados',
        ),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;

  PageController _pageController = PageController();

  int get paginaActual => _paginaActual;

  set paginaActual(int valor) {
    _paginaActual = valor;

    _pageController.animateToPage(
      valor,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );

    notifyListeners();
  }

  PageController get pageController => _pageController;
}

import 'package:flutter/material.dart';
import 'package:news_provider/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';
import 'package:news_provider/src/services/news_service.dart';

// Se convierte el stateful para mantener la posicion en el widget
class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final headLines = Provider.of<NewsService>(context).headLines;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        child: Scaffold(
          body: (headLines.isEmpty)
              ? const Center(child: CircularProgressIndicator())
              : ListaNoticias(noticias: headLines),
        ),
      ),
    );
  }

  // Mantener el estado del widget
  @override
  bool get wantKeepAlive => true; // Se mantiene en la posición
}

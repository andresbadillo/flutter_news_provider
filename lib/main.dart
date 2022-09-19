import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_provider/src/pages/tabs_page.dart';
import 'package:news_provider/src/services/news_service.dart';
import 'package:provider/provider.dart';

import 'src/theme/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        title: 'Material App',
        home: TabsPage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_provider/src/models/news_models.dart';

class NewsService with ChangeNotifier {
  List<Article> headLines = [];

  NewsService() {
    getTopHeadlines();
  }

  getTopHeadlines() {
    print('Cargando headLines...');
  }
}

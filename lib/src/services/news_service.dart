import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_provider/src/models/category_model.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _URL_NEWS = 'https://newsapi.org/v2';
final _API_KEY = 'f6d0051eb2824e3780d0375ba94a2268';

class NewsService with ChangeNotifier {
  List<Article> headLines = [];

  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.heart, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.basketball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();

    categories.forEach((element) {
      categoryArticles[element.name] = [];
    });

    getArticlesByCategory(_selectedCategory);
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String valor) {
    _selectedCategory = valor;
    _isLoading = true;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticlesCategorySelected =>
      categoryArticles[selectedCategory];

  getTopHeadlines() async {
    final url =
        Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=co');

    // final url = Uri.https(
    //   _URL_NEWS,
    //   '/top-headlines?',
    //   {'country': 'co', 'apiKey': _API_KEY},
    // );

    final resp = await http.get(url);

    final newsResponse = NewsResponse.fromJson(resp.body);

    headLines.addAll(newsResponse.articles!);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return categoryArticles[category];
    }

    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=co&category=$category');

    final resp = await http.get(url);

    final newsResponse = NewsResponse.fromJson(resp.body);
    categoryArticles[category]?.addAll(newsResponse.articles!);

    _isLoading = false;
    notifyListeners();
  }
}

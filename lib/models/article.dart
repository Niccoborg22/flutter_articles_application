import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Article {
  final String topic;
  final String title;
  final String article;

  Article(this.topic, this.title, this.article);

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      json['topic'],
      json['title'],
      json['article'],
    );
  }

  Map<String, dynamic> toJson() => {
      'topic': topic,
      'title': title,
      'article': article,
    };
}

// FUNCTION TO RETURN ALL ARTICLES
Future<List<Article>> loadArticlesFromJson() async {
  // Load JSON file from assets
  final String jsonString = await rootBundle.loadString('lib/assets/articles.json');
  
  // Decode JSON data
  final List<dynamic> jsonData = json.decode(jsonString)['articles'];
  
  // Convert JSON data to List<Article>
  return jsonData.map((articleData) => Article.fromJson(articleData)).toList();
}

// FUNCTION TO RETURN FOOTBALL ARTICLES
Future<List<Article>> loadFootballArticlesFromJson() async {
  List<Article> footballArticles = []; 

  final String jsonString = await rootBundle.loadString('lib/assets/articles.json');
  
  final List<dynamic> jsonData = json.decode(jsonString)['articles'];
  
  List<Article> articleList = jsonData.map((articleData) => Article.fromJson(articleData)).toList();

  for (Article article in articleList) {
    if (article.topic == "football"){
      footballArticles.add(article); 
    }
  }

  return footballArticles;
}

// FUNCTION TO RETURN MOTORSPORT ARTICLES
Future<List<Article>> loadMotorsportArticlesFromJson() async {
  List<Article> motorsportArticles = []; 

  final String jsonString = await rootBundle.loadString('lib/assets/articles.json');
  
  final List<dynamic> jsonData = json.decode(jsonString)['articles'];
  
  List<Article> articleList = jsonData.map((articleData) => Article.fromJson(articleData)).toList();

  for (Article article in articleList) {
    if (article.topic == "motorsport"){
      motorsportArticles.add(article); 
    }
  }

  return motorsportArticles;
}

// FUNCTION TO RETURN OTHER ARTICLES
Future<List<Article>> loadOtherArticlesFromJson() async {
  List<Article> otherArticles = []; 

  final String jsonString = await rootBundle.loadString('lib/assets/articles.json');
  
  final List<dynamic> jsonData = json.decode(jsonString)['articles'];
  
  List<Article> articleList = jsonData.map((articleData) => Article.fromJson(articleData)).toList();

  for (Article article in articleList) {
    if (article.topic == "other"){
      otherArticles.add(article); 
    }
  }

  return otherArticles;
}

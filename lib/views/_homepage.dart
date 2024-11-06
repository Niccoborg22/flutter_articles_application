import 'package:flutter/material.dart';
import 'UI/_article_box.dart';
import 'UI/_title.dart';
import '../models/article.dart';


// HOME PAGE
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // FUTURE THAT WILL HOLD THE ARTICLES
  late Future<List<Article>> articles;

  // CURRENT ARTICLE VAR
  int current = 0;

  @override

  // GET THE ARTICLES FROM THE JSON FILE
  void initState() {
    super.initState();
    articles = loadArticlesFromJson();
  }

  // FUNCTION TO CYCLE THROUGH ARTICLES
  void nextArticle(List<Article> articlesList) {
    setState(() {
      current = (current + 1) % articlesList.length;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(101, 245, 59, 59),
      body: Center(
        child: FutureBuilder<List<Article>>(
          future: articles,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("No articles found.");
            } else {
              final articlesList = snapshot.data!; // Loaded List<Article>
              return Column(
                children: [
                  // TITLE
                  const PageTitle(title: "Articles Application"),

                  // WELCOME TEXT
                  const Center(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text:
                                    "This application displays a series of sport articles to the audience. The topics of the articles are ",
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "football",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: ", "),
                                  TextSpan(
                                      text: "motorsport",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: " and "),
                                  TextSpan(
                                      text: "other miscellaneus",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          " ones. In the navigation bar you can choose the topic you want to read to make sure you are displayed the articles you are most interested about. In this homepage you can find articles about all the categories."),
                                ],
                              )))),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Text(
                      "Have fun and have a good read!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),

                  // DISPLAY CURRENT ARTICLE
                  ArticleBox(
                      title: articlesList[current].title,
                      article: articlesList[current].article),

                  // NEXT ARTICLE BUTTON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Next article",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => nextArticle(articlesList),
                        icon: const Icon(Icons.next_plan),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
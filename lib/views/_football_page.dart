import 'package:flutter/material.dart';
import 'UI/_article_box.dart';
import '../models/article.dart';
import 'UI/_title_bar.dart';

// FOOTBALL PAGE
class FootballPage extends StatefulWidget {
  @override
  State<FootballPage> createState() => _FootballPageState();
}

class _FootballPageState extends State<FootballPage> {
  // FUTURE THAT WILL HOLD THE ARTICLES
  late Future<List<Article>> articles;

  // CURRENT ARTICLE VAR
  int current = 0;

  @override
  // GET THE ARTICLES FROM THE JSON FILE
  void initState() {
    super.initState();
    articles = loadFootballArticlesFromJson();
  }

  // FUNCTION TO CYCLE THROUGH ARTICLES
  void nextArticle(List<Article> articlesList) {
    setState(() {
      current = (current + 1) % articlesList.length;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(127, 33, 247, 5),
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
                  final articlesList = snapshot.data!;
                  return Column(
                    children: [
                      // TITLE
                      const TitleBar(titlePage: "Football articles"),

                      // WELCOME TEXT
                      const Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                              text: "Here you can find articles about ",
                              children: <TextSpan>[
                                TextSpan(
                                    text: "football ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                TextSpan(
                                  text:
                                      ", the best sport in the world. These articles range from tactical analysis to romantic analysis",
                                ),
                              ])),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: Text(
                          "Have fun and have a good read!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
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
              }),
        ));
  }
}

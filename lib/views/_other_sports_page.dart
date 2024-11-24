import 'package:flutter/material.dart';
import 'UI/_article_box.dart';
import '../models/article.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'UI/_title_bar.dart';


// OTHER SPORTS PAGE
class OtherSportsPage extends StatefulWidget {
  @override
  State<OtherSportsPage> createState() => _OtherSportsPageState();
}

class _OtherSportsPageState extends State<OtherSportsPage> {
// FUTURE THAT WILL HOLD THE ARTICLES
  late Future<List<Article>> articles;

// LIST CAROUSEL IMAGES
List<Widget> carouselItems = [
  ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Image.asset(
      'lib/assets/carousel_pictures/nfl.jpg',
      fit: BoxFit.cover,
    ),
  ),
   ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Image.asset(
      'lib/assets/carousel_pictures/nba.jpg',
      fit: BoxFit.cover,
    ),
  ),
   ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Image.asset(
      'lib/assets/carousel_pictures/tennis.jpg',
      fit: BoxFit.cover,
    ),
  ),
];

  // CURRENT ARTICLE VAR
  int current = 0;

  @override
  // GET THE ARTICLES FROM THE JSON FILE
  void initState() {
    super.initState();
    articles = loadOtherArticlesFromJson();
  }

  // FUNCTION TO CYCLE THROUGH ARTICLES
  void nextArticle(List<Article> articlesList) {
    setState(() {
      current = (current + 1) % articlesList.length;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(118, 5, 247, 235),
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
                      const TitleBar(titlePage: "Other sports articles"),

                      // WELCOME TEXT
                      const Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                              text: "Here you can find articles about ",
                              children: <TextSpan>[
                                TextSpan(
                                    text: "various sports ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                TextSpan(
                                  text:
                                      ", ranging from American Football and the NFL, basketball and the NBA, Tennis and many more!",
                                ),
                              ])),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Have fun and have a good read!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),

                      // CAROUSEL IMAGES
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            CarouselSlider(
                                          items: carouselItems,
                                          options: CarouselOptions(
                                            aspectRatio: 16/4,
                                            viewportFraction: 0.5,
                                            autoPlay: true,
                                            autoPlayInterval: const Duration(seconds: 3),
                                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeFactor: 100,
                                            enlargeCenterPage: true,
                                            enableInfiniteScroll: true,
                                            scrollDirection: Axis.horizontal,
                                            onPageChanged: (index, reason) {
                                            },
                                          ),
                                        ),
                          ],
                        ),
                      ),

                      // DISPLAY CURRENT ARTICLE
                      Expanded(
                        child: ArticleBox(
                            title: articlesList[current].title,
                            article: articlesList[current].article),
                      ),

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
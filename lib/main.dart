import 'package:flutter/material.dart';
import 'views/UI/_article_box.dart';
import 'views/UI/_title.dart';
import 'views/_football_page.dart';
import 'views/_motorsport_page.dart';
import 'views/_other_sports_page.dart';
import 'models/article.dart';

void main() {
  runApp(const MyApp());
}

// APPLICATION ENTRY POINT
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Articles App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(41, 204, 5, 204),
      ),
      home: NavigationBar(),
    );
  }
}

// NAVIGATION BAR + PAGE ROUTING
class NavigationBar extends StatefulWidget {
  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  var selectedIndex = 0;

  // PAGE RETURN FUNCTION
  Widget _getPage(int index) {
    if (index == 0) {
      return const HomePage();
    }
    if (index == 1) {
      return FootballPage();
    }
    if (index == 2) {
      return MotorsportPage();
    } else {
      return OtherSportsPage();
    }
  }

  // FUNCTION TO CHANGE PAGE INDEX
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // COLOR CHANGE NAVIGATION RAIL
  Color getRailBackgroundColor(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return Colors.red; // Home
      case 1:
        return Colors.green; // Football
      case 2:
        return Colors.purple; // Motorsport
      case 3:
        return Colors.blue; // Other Sports
      default:
        return Colors.grey; // Default if index is out of bounds
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        // BOTTOM NAVIGATION BAR
        bottomNavigationBar: screenWidth < 600
            ? BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: Colors.red,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.sports_soccer),
                    label: 'Football',
                    backgroundColor: Colors.green,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.directions_car),
                    label: 'Motorsport',
                    backgroundColor: Colors.purple,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.sports),
                    label: 'Other Sports',
                    backgroundColor: Colors.blue,
                  ),
                ],
                currentIndex: selectedIndex,
                selectedItemColor: Colors.black,
                onTap: _onItemTapped,
              )
            : null,

        // PAGE SHOWN
        body: Row(
          children: [
            if (screenWidth >= 600)
              SafeArea(
                  child: NavigationRail(
                      backgroundColor: getRailBackgroundColor(selectedIndex),
                      extended: screenWidth > 900,
                      selectedIconTheme: const IconThemeData(
                        color: Colors.black,
                        size: 37,
                      ),
                      unselectedIconTheme: const IconThemeData(
                        color: Colors.white,
                        size: 25,
                      ),
                      selectedLabelTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      unselectedLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                      destinations: const [
                        NavigationRailDestination(
                            icon: Icon(Icons.home),
                            label: Text("Home"),
                            indicatorColor: Colors.red),
                        NavigationRailDestination(
                            icon: Icon(Icons.sports_soccer),
                            label: Text("Football")),
                        NavigationRailDestination(
                            icon: Icon(Icons.directions_car),
                            label: Text("Motorsport")),
                        NavigationRailDestination(
                            icon: Icon(Icons.sports),
                            label: Text("Other Sports")),
                      ],
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (value) {
                        setState(() {
                          selectedIndex = value;
                        });
                      })),
            Expanded(child: _getPage(selectedIndex)),
          ],
        ));
  }
}

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

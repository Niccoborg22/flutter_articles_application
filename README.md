# Flutter Sports Articles Application

[![Flutter Version](https://img.shields.io/badge/Flutter-v2.5+-blue.svg)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter application that provides users with the latest sports articles from various sources. This app is built with Flutter for cross-platform compatibility and offers a user-friendly interface to explore articles on different sports topics.

## Demo
**Website** \
![Demo_website](demo_screenshot_website.png)

**Phone Application** \
![Demo_phone](demo_screenshot_phone.png)

## Features
- **Login Implemented**: Login has been implemented in the app, currently the only user allowed is test@test.com with test as password
- **Latest Articles**: Access to sports articles organized by topic or randomized.
- **User-Friendly Interface**: Navigate seamlessly through the sports topics that I have most at heart.
- **Cross-Platform**: Consistent experience on both web and mobile platforms.

## Folder Structure
lib/ \
|-- main.dart        
|-- assets/ \
|-- models/ \
|-- views/  

In the assets folder you can find the articles json file and the series of images to show in the carousel in the others page. Differently, in models you can find the JSON serialization of the article JSON file while in the views folder there is the UI folder with some UI files and the pages a part from the landing one that is in the main.dart file.

## Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Niccoborg22/flutter_articles_application.git
   cd flutter_articles_application
   ```
2. **Install Dependencies**:
   Ensure you have Flutter installed. Then, run:
   ```bash
   flutter pub get
   ```
3. **Run the Application**:
   For mobile:
   ```bash
   flutter run
   ```
   For web:
   ```bash
   flutter run -d chrome
   ```

## Contact
For any inquiries or feedback, please contact Niccolò Matteo Borgato at borgato.niccolo@gmail.com.
# RandomUser iOS App

## Introduction 🌟

The RandomUser iOS App is a simple yet functional mobile application designed to browse and save random users from the internet. It serves as a technical challenge to showcase skills in iOS development, focusing on code structure, the tools used, and application architecture. This application aims to demonstrate that it's not only functional but well-structured and production-ready.

## Technical Challenge ⚔️

### Features of the Challenge

- **List of Users:** 
  - Browse through a list of random users fetched from the Random User API. 
  - The list supports infinite scrolling, pull-to-refresh, and searching. 
  - Fetches 25 items on each API call.

- **User Details:** 
  - View detailed information of a selected user. 
  - The UI design and information to display is intentionally left flexible to demonstrate creativity and design skills.

- **Bookmark Users:** 
  - Allows the user to bookmark/un-bookmark any user from any part of the app. 
  - This makes it easy to save favorite users and revisit their details.

- **Bookmarks Page:** 
  - A separate list that shows all bookmarked users for quick access.

### Technologies Used

- **UIKit:** 
  - Used for building the user interface of the app. 
  - Although SwiftUI is slowly being adopted, UIKit is still heavily used and is the focus of this technical challenge.

- **Realm:** 
  - A mobile database to persist bookmarked users, making it possible to revisit favorite users even after the app is closed and reopened.

- **Alamofire:** 
  - A networking library used to make API calls to the Random User API. 
  - It handles the heavy lifting of networking tasks.

- **Kingfisher:** 
  - An image caching library. 
  - Used for efficiently loading and caching images.


## Installation 🛠️

Clone this repository and import into Xcode:

```git clone https://github.com/Emin-Emini/RandomUser/tree/develop```


Run the app in your iOS simulator or a real device connected to your computer.

## Conclusion & Reflections 🤔

This app serves as a practical demonstration of what can be done using UIKit, Realm, Alamofire, and Kingfisher. It's a simple yet comprehensive project that shows off a lot of what iOS development has to offer.

Working on this project was like taking a fun trip down the iOS development landscape. From intricate UI designs to database management and API calls, every aspect of this project had its unique charm and challenges. I was like a kid in a candy store, excited to use the tried-and-true technologies I love and trust. I hope this enthusiasm reflects in the quality and usability of the app!

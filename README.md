<h1 align="center"> Valorant Guide </h1>

<p align="center">
  <a href="https://www.mozilla.org/en-US/MPL/2.0/"><img alt="License" src="https://img.shields.io/badge/License-MPL_2.0-brightgreen.svg"/></a>
  <a href="https://twitter.com/Mikaeld98471967"><img alt="API" src="https://img.shields.io/twitter/follow/Mikaeld98471967?style=social"/></a>
</p>

<p align="center">
  Design
</p>

![Design](https://github.com/MikaelDDavidd/valorant-guide-main/blob/main/screenshots/design.jpeg)
<p align="center">
  Design by: <a href="https://dribbble.com/shots/14073476-Valorant-Agents">Malik Abimanyu</a>
</p>

<p align="center">
  App
</p>

![App](https://github.com/MikaelDDavidd/valorant-guide-main/blob/main/screenshots/app.png)


<p align="center">
Valorant Guide app is a small demo application to demonstrate Flutter application tech-stacks with a Getx and Provider. I don't have design file so just tried to do what I see. It's still under development.
</p>

### Libraries & Tools Used

* [Http](https://github.com/flutterchina/dio)
* [getX](https://github.com/jonataslaw/getx)
* [Provider](https://github.com/rrousselGit/provider) (State Management)
* [Json Serialization](https://github.com/dart-lang/json_serializable)
* [cached_network_image](https://pub.dev/packages/cached_network_image)

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- constants/
|- data/
|- models/
|- modules/
|- routes/
|- widgets/
|- main.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- constants - All the application level constants are defined in this directory with-in their respective files. This directory contains the constants for `theme`, `dimentions`, `api endpoints`, `preferences` and `strings`.
2- data - Contains the data layer of your project, includes directories for local, network and shared pref/cache.
3- stores - Contains store(s) for state-management of your application, to connect the reactive data of your application with the UI. 
4- models — Contains all the ui of your project, contains sub directory for each screen.
5- widgets — Contains the common widgets for your applications. For example, Button, TextField etc.
6- routes — This file contains all the routes for your application.
8- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

### Constants

This directory contains all the application level constants. A separate file is created for each type as shown in example below:

```
constants/
|- app_assets.dart
|- app_colors.dart
|- app_storage_keys.dart
|- app_strings.dart
|- app_text_sizes.dart
|- qpp_values.dart
```

### Open API
Valorant Agents uses the [Valorant-api](https://dash.valorant-api.com/) for required data.
Valorant-api provides an extensive API containing data of most in-game items, assets and more!

### Tasks
- [ ] Make HomePage items background color dynamic

- [ ] Get more data from API and add more pages

- [ ] Localization

- [ ] Widget Testing

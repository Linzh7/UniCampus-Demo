# UniCampus

UniCampus is an all-in-one cross-platform mobile application.

All images in this README are real effects. All sensitive information,  image which not created by myself are blocked. In this repo, all image files (button, icon, etc.) are replaced with uncopyrighted images.

This repo only contains my code and free assest. You are free to use it for non-commercial use, such as modifying this application for use in your university. For commercial use please ask me for permission.

## Functions

### Welcome dialog

When the user launches the app for the first time, there is a dialog will pop up to show some information user should know or provide a shortcut for user to jump to some function, such as import courses info.

<img width="400" src="https://github.com/Linzh7/BigFileAchieve1/blob/master/UniCampusDemo/images/init.jpg?raw=true"/>


### Class schedules

There is a simple import method which enables the modifier(you) change the method easily in order to adapt different web pages. **Regular expressions are recommended**

Different courses are renderd different color, and the color is selcet by the name of course.

There are two pages at homepage, **today** and **week**.

User can find today and next day's class at **today**, meanwhile, they can slide page to **week** to view this week's class.

If there is no class today (or tomorrow), app will show a image as the following image.


<img width="400" src="https://github.com/Linzh7/BigFileAchieve1/blob/master/UniCampusDemo/images/today.jpg?raw=true"/>

If there are some classes in this week, user can find them at both page. At **week** page, it will like the following image.
<img width="400" src="https://github.com/Linzh7/BigFileAchieve1/blob/master/UniCampusDemo/images/timetable.jpg?raw=true"/>

By clicking the course block (include the grey block), user are able to change the course infomation.

<img width="400" src="https://github.com/Linzh7/BigFileAchieve1/blob/master/UniCampusDemo/images/addcourse.jpg?raw=true"/>

### Search in Library

A built-in total page browser is provided to query specific content.

<img width="400" src="https://github.com/Linzh7/BigFileAchieve1/blob/master/UniCampusDemo/images/search.jpg?raw=true"/>

After enter the title and start search, there will be a inAppWebView to view the result. If you want use users' default browser, you could change the code , e.g. `launch(xxxx.xxx/?q=${})`

<img width="400" src="https://github.com/Linzh7/BigFileAchieve1/blob/master/UniCampusDemo/images/library.jpg?raw=true"/>

### Customizable Subpages
You can customize information pages and information cards, or let users click on pictures that contain information.

<img width="400" src="https://github.com/Linzh7/BigFileAchieve1/blob/master/UniCampusDemo/images/subpage.jpg?raw=true"/>

### Yellow pages
You can make changes to the Yellow Pages information so that users can quickly look up phone numbers. In the following image all phone numbers are blocked by white.

<img width="400" src="https://github.com/Linzh7/BigFileAchieve1/blob/master/UniCampusDemo/images/yellowpage.jpg?raw=true"/>

### Feedback
Use Sentry for crash reporting, and users can also submit feedback manually.

<img width="400" src="https://github.com/Linzh7/BigFileAchieve1/blob/master/UniCampusDemo/images/feedback.jpg?raw=true"/>

### Message (need server support)
This app has a prototype of instant messaging, but if you want to use this feature, you need additional server software.

<img width="400" src="https://github.com/Linzh7/BigFileAchieve1/blob/master/UniCampusDemo/images/friends.jpg?raw=true"/>

## Stucture of Project

### Assert (./{}/)

All assert can be found at root dirctory, such as `images`, `fonts`, etc.

### Code (./lib/)

#### common (./lib/common/)

Global variables.

#### models (./lib/models/)

Models for objects, such as `course`, `message`, `news`, 

##### communicate (./lib/models/communicate/)

Deprecated.

##### database (./lib/models/database/)

Codes for operating SQLite database which stores the courses info.

#### resource (./lib/resource/)

Contains
- `PhoneNumber`, the phone number of yellow page
- `classIndexMap`, the start and end time of class
- `colorList`, available colors for render the schedules and a function for calculate the color by a string (course name)
- `url`, the url for check update, semester start time and university's website.

#### routes (./lib/routes/)

- `Routes`, the navigation of this app
- `YellowPages`, yellow pages
- `commonResource`, deprecated
- `libraryQuiry`, quiry books and other resources at e-library
- `rootRoute`, provide the outlook of this app
- `settingRoute`, deprecated
- `universityWebRoute`, a inAppWebView for get HTML to import courses info

##### pages (./lib/routes/pages/)

Main pages which could switch by bottom navigator.

##### settings (./lib/routes/settings/)
Deprecated.

##### square (./lib/routes/square/)

You can modify this pages to provide common school information.

#### uilts (./lib/uilts/)

- `classIndexUtil`, check if two cources conflict in order to enable click to swtich between two courses (some university allow students select courses at same time slice)
- `dateCalculator`, check and calculate the week index and day index
- `imageLoader`, deprecated
- `loginUtil`, deprecated (they even want to use socket XD)
- `notificationUtil`, create a notification channal to provide notification before class start
- `updateUtil`, check whether this app is ourdated
- `webUtil`, parse and add course info into database

#### widgets (./lib/widgets/)
- `blurWidget`, provide a blur widget
- `bodyProvider`, can change content by change index
- `classCard`, the card indicate the course info at **today** page
- `classCardList`, assmble class cards
- `classCube`, the cube indicate the course info at **week** page, and provide function to change course info and can handle conflict(user cannot add conflict courses, but if university provide conflicting courses, we can handle them)
- `customTabBar`, a custom TabBar
- `dialog`, a dialog provider
- `halfDayCoursesProvider`, provide classes in a range of index and assmble them to a widget
- `imageButton`, a image button
- `imageViewProvider`, a imageViewProvider
- `infoCard`, a info card
- `searchBar`, a search bar
- `subjectCalender`, deprecated
- `webViewPage`, a webViewProvider

## Icon of App

[University icons created by Smashicons - Flaticon](https://www.flaticon.com/free-icons/university)

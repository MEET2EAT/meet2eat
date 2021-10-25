Original App Design Project - README Template
===

# Meet2Eat

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Meet2Eat is an iOS app that do something useful???
Objects: restaurants, users
Use:
conclusion:
Meet2Eat stands for meet to eat. Socialize? Tech? How? use? conclusion?
### App Evaluation
- **Category:** Social, Video & Photo
- **Mobile:** The app allows user uses camera, access photo library to post, and provide fast ,convienence service, and great battery performance for user.
- **Story:** Allows users to make new friends, or connection when they go to eat by open table and let people who have the same interests. And also users can share picture.
- **Market:** Anyone that does not want to eat alone. For now, market will be focusing on college students since there are many people around and it serves the purpose of this app well. 
- **Habit:** Users can post throughout the day many times. Users willing to user our app at least once a day for meeting new people, making new friends, and earn the discount for the restaurant. Ranking system and bonus will encourage them using more frequently.
- **Scope:** Posting pics and view feeds. Open table (time to eat)to meet other users in person. May expanded to other area such as events meeting, sport matching...


## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
* User logs in to use the app.
* User can post the image and give other user's image comment.
* User can join, withdraw, cancel, or create table.
* User can see the list of tables.
* User can see the table details.
* User can check their personal information in profile page.

**Optional Nice-to-have Stories**

* Users can filter the table list based on their interest tag.
* Users can filter the capacity count of the table.
* Users can change their username, password, and interest tags through profile setting page.
* User's profile icon will be displayed next to their comment and caption.

### 2. Screen Archetypes

* Launch screen
   * App logo "MEET2EAT"
* Login/Signup screen
   * User can log in or sign up
* Post screen
   * User can view all the posts from all the app users
   * User can post a photo and add caption
   * User can comment a post
 * Host screen
   * User can host a table
   * User can choose filter based on their interests and capacity for the table 
 * Profile screen
   * User can view and edit their profile
### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Post
* Table
* Profile

**Flow Navigation** (Screen to Screen)

* LoginViewController
   * FeedTableViewController
* FeedTableViewController
   * LoginViewController
   * PostViewController
* PostViewController
   * FeedTableViewController
* LobbyTableViewController
   * HostViewController
   * FilterViewController
   * TableInfoViewController
* FilterViewController
   * LobbyTableViewController
* HostViewController
   * LobbyTableViewController
   * SearchRestaurantTableViewController
* TableInfoViewController
   * LobbyTableViewController
* ProfileViewController
   * ProfileSettingViewController
* ProfileSettingViewController
   * ProfileViewController

## Wireframes
<img src="https://media.discordapp.net/attachments/897965541472501763/898770550606950431/image0.jpg?width=1178&height=1571" width=500><br>


### [BONUS] Digital Wireframes & Mockups

<img src="https://media.discordapp.net/attachments/897965541971607613/902320984869175326/Screen_Shot_2021-10-25_at_5.20.54_PM.png?width=1874&height=957" width=800><br>

### [BONUS] Interactive Prototype
<img src="https://submissions.us-east-1.linodeobjects.com/ios_university/G5hDvyS5.gif" width=200>

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]


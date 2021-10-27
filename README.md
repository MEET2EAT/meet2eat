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
Meet2Eat is an iOS app that connects people through thoughtful conversations during meals. By giving away discounts to our users to encourage them connecting to different people and experiencing a different perspective of the world and community. Meet2Eat: a place for good food and good company to gather around.


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
<img src="G5hDvyS5.gif" width=200>

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]


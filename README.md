# Meet2Eat

## Work Distribution
* Khanh Ho: LoginViewController, FeedTableViewController
* Airi Shimamura: ProfileViewController, ProfileSettingViewController
* KuoHuang Vincent Hew: LobbyTableViewController, FilterViewController
* Loc Luu: PostViewController, HostViewController
* An Lam: TableInfoViewController, SearchRestaurantViewController

## Weekly User Story Check-off

### Unit 10
- [x] Work distribution for each team member.
- [x] Project prototype.
- [x] Install CocoaPod.
- [x] Updated status of issues in Project board. (2pts)
- [x] Sprint planned for next week (Issues created, assigned & added to project board). (3pts)
- [x] Completed user stories checked-off in README. (2pts)
- [x] Gifs created to show build progress and added to README. (3pts)

#### Build Progress Walkthrough

<img src='G5hDvyS5.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />

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
1. Users
2. Posts
3. Comments
4. Likes/Hearts
5. Table
6. Restaurant


### Models
#### POST
| Property      | Type     | Description |
| ------------- | -------- | ------------|
| objectId      | String   | unique id for the user post(default field) |
| user        | Pointer to User| image user |
| image         | File     | image that user posts |
| caption       | String   | image caption by user |
| commentsCount | Number   | number of comments that has been posted to an image |
| likesCount    | Number   | number of likes for the post |
| createdAt     | DateTime | date when post is created (default field) |
| updatedAt     | DateTime | date when post is last updated (default field) |

#### PROFILE
| Property      | Type     | Description |
| ------------- | -------- | ------------|
| objectId      | String   | unique id for the user post(default field) |
| user          | Pointer to User| username|
| password      | String| password for user|
| profileImage  | File     | image that user icon |
| createdAt     | DateTime | date when post is created (default field) |
| updatedAt     | DateTime | date when post is last updated (default field) |

#### Table
| Property      | Type     | Description |
| ------------- | -------- | ------------|
| objectId      | String   | unique id for the table (default field) |
| host          | Pointer to User| the host of the table|
| guest         | Array Pointer to User| the guests of the table|
| capacity      | Integer  | number of people accepted in the table|
| restaurant    | String  | the name of the restaurant where to open tb|
| phone         | Number  | the phone of the restaurant|
| location        | object   | The street of the location address of the table location = {street, state, city, country, zipcode}|
| createdAt     | DateTime | date when post is created (default field) |
| updatedAt     | DateTime | date when post is last updated (default field) |



### Networking
- Post Screen
    - (Read/GET) Query all posts where user is author
         ```swift
         let query = PFQuery(className:"Post")
         query.whereKey("author", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
         ```
    - (Create/POST) Create a new like on a post
        ```swift
        var parseObject = PFObject(className:"Post")
        
        parseObject["objectId"] = "default"
        parseObject["user"] = "user's image post"
        parseObject["image"] = "url/.pnj"
        parseObject["caption"] = "String"
        parseObject["commentsCount"] = "number"
        parseObject["likesCount"] = "number"

        // Saves the new object.
        parseObject.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
            // The object has been saved.
          } else {
            // There was a problem, check error.description
          }
        }
        ```

    - (Delete) Delete existing like
        ```swift
            var deleteAttributesOnly = true
            var query = PFQuery(className:"Post")

            query.getObjectInBackgroundWithId("<PARSE_OBJECT_ID>") {
              (parseObject: PFObject?, error: NSError?) -> Void in
              if error != nil {
                print(error)
              } else if parseObject != nil {
                if deleteAttributesOnly {
                    parseObject["likesCount"] = "number"
                    parseObject.saveInBackground()
                } else {
                      parseObject.deleteInBackground()
                }
              }
            }
        ```
    - (Create/POST) Create a new comment on a post
    - (Delete) Delete existing comment
        ```swift
            var deleteAttributesOnly = true
            var query = PFQuery(className:"Post")

            query.getObjectInBackgroundWithId("<PARSE_OBJECT_ID>") {
              (parseObject: PFObject?, error: NSError?) -> Void in
              if error != nil {
                print(error)
              } else if parseObject != nil {
                if deleteAttributesOnly {
                    parseObject["comment"] = "String"
                    parseObject.saveInBackground()
                } else {
                      parseObject.deleteInBackground()
                }
              }
            }
        ```
- Create Post Screen
    - (Create/POST) Create a new post object
- Profile Screen
    - (Read/GET) Query logged in user object
    - (Update/PUT) Update user profile image
- Table Screen
    - (Read/GET) Query all table information
    - (Delete) Delete existing table
- Create Table Screen
    - (Create/POST) Create a table for host and users

# Bishopric Assistant
Often times in the Church of Jesus Christ of Latter Day Saints Bishoprics are overwhelmed with many different tasks and responsibilities. The intention of this software is to help oliviate some of those stresses and help to organize tasks that need to be done as well as manage assignments, meetings and more.

[Project Link](https://framer.com/projects/Bishopric-Assistant--wzwg61DlBXbe1V1mMWYQ-2tWPm)

# Data Model Structure
![Database Structure](./charts/Database_Structure.png)

## Firebase
- According to [this article](https://stackoverflow.com/questions/41107699/using-same-firebase-app-with-web-and-mobile-app) a firebase project can be used as a backend to web applicaiton and mobile applications at the same time.
- Potential video from [youtube](https://www.youtube.com/watch?v=xZn0Vzc4uFE) that talks about how to integrate firebase into multiple platforms.
- This backend could potentially assist in a lot fo other ways if the application wanted to be scaled up. One suche example is it will allow the number of users to increase by simply switching to the pay as you use plan offered by firebase with minimal up keep.
- By offering a real time database the users would recieve changes instantly on their devices.

### Pricing **Free Within**
|Authentication|Cloud Firestore|Hosting|Realtime Database|Cloud Storage|Test Lab|
|-|-|-|-|-|-|
|10k/month|Stored Data 1GiB, Network egress 10GiB/Month, Document writes 20k/day, Document reads 50k/day, Document deletes 20k/day|Storage 10Gb, Data transfer 360MB/day, Custom Domain, Multiple sites| Simultaneous connections 100, GB stored 1GB, Gb downloaded, 10Gb/month, Database per project 1|GB stored 5GB, GB downloaded 1GB/day, Upload operatios 20k/day, DownloadOperations 50k/day, Buckets per project 1|Virtual Divice Tests 10 tests/day, Physical Device Tests 5 tests/day|

## Alternative Databases to Firebase
Based on the following alternatives it would be wise to use Firebase as it will provide a host server and all database needs.
- [MySQL](mysql.com) costs money and is only a database needs a server to run on
- [Cloud Firestore](https://firebase.google.com/products/firestore?gclid=Cj0KCQjwu7OIBhCsARIsALxCUaP3cRtbRxYQMtxVvUBaViJtdN7LEiIIJ3HfHvmVfc4tIeB9PNai0NEaAhN6EALw_wcB&gclsrc=aw.ds)(Included in Firebase)
- [Parse](https://docs.parseplatform.org/parse-server/guide/) is similar to firebase uses either MongoDB or Postgres as databases, but still needs a server
- [MongoDB](https://www.mongodb.com) but it is only a database
- [Postgres](https://www.postgresql.org/about/) needs a server to run on

<!-- ```
- Bishopric
    - Members: Class
        - Bishop: Person, Level 1
        - Counselors: List\<Person\>, Level 2
        - Secretaries: List\<Person\>, Level 3
        - Clerks: List\<Person\>, Level 3
        - Ward Counsel Members: List\<Person\>, Level 4
    - Events: Class
        - Meeting: Event
        - Interview: Event
    - Assignments: Class

- Person: Class, Role
    - ID
    - First Name
    - Last Name
    - Email
    - Phone Number
    - Assigned Events List
    - Assigned Assignments List

- Level 1 Clearance: Level 2 Clearance, Level 3 Clearance, Level 4 Clearance
    - Add/Remove any member
    - Creates an organization

- Level 2 Clearance: Level 3 Clearance, Level 4 Clearance
    - Add/Remove Level 3 & 4 Clearance members
    - Can view progress on assignments of any members
    - Can be scheduled interview events

- Level 3 Clearance: Level 4 Clearance
    - Add/Remove Level 2 & 4 Clearance members
    - Create events
    - Create assignments
    - Can cancel events

- Level 4 Clearance
    - Can be scheduled meeting events
    - Can be scheduled assignments
    - Can complete assignments
    - Can view assigned events
    - Can view assigned assignments

- Role
    - Bishop
    - Counselor
    - Secretary
    - Clerk
    - Ward Counsel Member
``` -->
# Functionalities
## User Accounts
User accounts are essential. The account will be used to house the following information:  
- **Name** First & Last
- **Phone Number** contacting purposes
- **Email** contacting purposes and doubles as their username
- **Password** used for privacy and security of sensitive data in different accounts
- **Organization Role** security clearance purposes to assist in privacy
- **List of Assigned Events** 
- **List of Assigned Assignments** 
- **ID* form of identification with application users
- Profile Image This is still on the table, but not a necessity, images will take up a lot of space on a database.

### Account Creation
User will be able to create an account with the following information. [Mobile](./images/appImages/SignUpView.png), [Desktop](./images/desktopImages/SignUpPage.png)
|Function|Detail|
|-|-|
|Prompts User|First & Last Name, email, Phone Number, Choose from a list of Roles, password & confirmation|
|Checks email|Verifies to make sure the email is not currently in use in the database & is a valid email address|
|Checks password|Verifies that the password is secure|
|Checks confirm password|Verifies that the second password matches the first|
|Insertion Check|Checks that it is safe to insert information into database|
|Request Insertion|Inserts the data into database|
|Verify Insertion|Verifys that the information was properly inserted into the database|

### Account Login
User will be able to login to the application through a login process. [Mobile](./images/appImages/LoginView.png), [Desktop](./images/desktopImages/LoginPage.png)
|Function|Detail|
|-|-|
|Prompts User|User is given a space for username and password|
|Confirms Account|Requests data to confirm account information|
|Successful then...|Loads user data into application and permits access to app|
|Failure then...|Enters [Login State Management](TODO)|

### Forgotten Passwords
Should the user need to change their password a method should be provided to them at login. [Mobile PIN](./images/appImages/PinView.png), [Desktop PIN](./images/desktopImages/PinPage.png), [Mobile Password Change](./images/appImages/PasswordChangeRequestView.png), [Desktop Password Change](./images/desktopImages/PasswordChangeRequestPage.png), [Mobile Change](./images/appImages/ChangePasswordView.png), [Desktop Change](./images/desktopImages/ChangePasswordPage.png)
|Function|Detail|
|-|-|
|Username Prompted|The user should be given a space to provide their username/email|
|Email Sent|A unique PIN is sent to the users email, verifies email sends successfully|
|Pin Verification|A space is provided to the user to allow for PIN input|
|Successful then...|User is directed to password and confirmation space where it enters [Passowrd State Management](TODO)|
|Failure then...| User is given option to resubmit the PIN or request a new pin, enters [Password Recovery State Management](TODO)|

### Viewing & Changing Account Information
The user is provided with a space to view their account information. [Mobile Profile](./images/appImages/ProfileView.png), [Desktop Profile](./images/desktopImages/ProfilePage.png), [Mobile Edit Profile](./images/appImages/EditProfileView.png), [Desktop Edit Profile](./images/desktopImages/EditProfilePage.png)
|Function|Detail|
|-|-|
|||

## Home
The Home design for a mobile platform will differ from a web platform. [Desktop Home](./images/desktopImages/HomePage.png)  

### Mobile
The user will not have a Home View.  

### Web
The user will see:
- a list of organization events.
- a list of assigned assignments.
- a list of the members in the organization.

|Function|Detail|
|-|-|
|[Events List](TODO)|Displays a current list of all organization events sorted by more recent date & time. Users should only see the events they are assigned to|
|[Assignements List](TODO)|Displays a current list of all assignments from the organization the user is assigned to, sorted by most recent due date & time|
|[Organization List](TODO)|Displays a list of current organization member cards, sorted by the security levels from highest to lowest|
|Navigation|Standard [Desktop Navigation](TODO)|
|Footer|Standard [Desktop Footer](TODO)|



<!-- Template to attach image links [Mobile](./images/appImages/View.png), [Desktop](./images/desktopImages/Page.png) -->


- Organize Bishopric
    - Create a bishopric account
    - Add/Remove members as they are called and released during the service of a bishop
    - Maintain private information privy to those who should know within the Bishopric
- See avaliability of members in the Bishopric
- Schedule meetings 
    - Assign meeting to specific bishopric member(s)
    - Detail the agenda of the meeting
    - Detail the time and place of the meeting
    - Detail the attendees of the meeting
    - Detail additional notes
    - Detail the type of meeting
    - Detail the name of the meeting
- Assignments
    - Assign assignment to specific member of the bishopric
    - Detail the due date
    - Detail additional notes
    - Detail the name of the assignment
- Limit viewability to specific members
- Allow for multiple Bishoprics usability
- Assign different roles
    - Bishop
        - Full Admin Rights
    - Counselor
        - Partical Admin Rights
    - Secretary
        - Partical Admin Rights
    - Ward Counsel Member
        - Limited Admin Rights/View only
- Notifications
    - Notify assigned users of meetings and assignments
    - Notify assigned users of new meetings and assignments

## Bishopric Organization
The Bishopric will follow this structure, (**NOTE:** the structure also includes viewing clearance):
1. One Bishop 
    - The Bishop has the power to add any members that have requested to join in his organization
    - The Bishop has the power to remove any members from his organization
2. Up to 2 counselors
    - A counselor has the power to add or remove any Secretary or Ward Counsel Member from the organization
3. Zero or more Secretaries & Clerks
    - A Secretary has the power to add or remove any Counselor or Ward Counsel Member from the organization
4. Zero or more Ward Counsel Members

- A member of the organization may view upcoming meetings they have clearance for, special secretaries and clerks may have Bishop level viewing
- Any Meeting or Assignment assigned to a member gives them overriding clearance to see

### Creating a Bishopric
Only a bishop can create an organization.  
Every member in the organization will need to create an account and request too join the Bishops organization.  
The Bishop should first create his account and the organization account, then either request or add users as they are called to the organization.  

## Creating, Scheduling, & Organizing Meetings
### Bishopric Member Avaliability
**Level 2 Clearance Required**  
Counselors and the Bishop will be able to block out or set hours they are avaliable for interiews each day of the week  
Secretaries & Clerks will be able to see Bishop & Counselors avaliability and schedule Meetings in those time slots
Time slots should have a minimum of 15 min increments, multiple time slots may be selected for one event

### Scheduling Events & Assignments
**Level 3 Clearance Required**  
Level 3 and above may create, edit, & assign events to any member of the organization  
Level 3 and above may create, edit, & assign assignments to any member of the organization
#### Event & Assignment Details
Events should include the following:

| Event Detail | Meeting | Interview | Assignment |
|--------------|---------|-----------|------------|
| Name         | X       | X         | X          |
| Time         | X       | X         | X          |
| Date         | X       | X         | X          |
| Place        | X       | X         |            |
| Assignee     | X       | X         | X          |
| Agenda       | X       |           |            |
| Interviewee  |         | X         |            |
| Notes        | X       | X         | X          |
| Notify       | X       | X         | X          |
| Custom Notify| X       | X         | X          |

## Notifications
Members will be notified when a new assignment or event has been assigned to them  
Members will be notified of reminders should they choose to opt in  
Members may choose to recieve a notification via: text, email, or on device  
Members may recieve custom notifications from creator of the event  
Members of Level 3 Clearance may recieve organization access request notifications

## Colors
[Link to Colors](https://coolors.co/071013-e73a23-fbfbff-7192be-5370b9)<br><br>
<img src= "https://via.placeholder.com/150/071013/FFFFFF?text=071013">
<img src= "https://via.placeholder.com/150/e73a23/FFFFFF?text=E73A23">
<img src= "https://via.placeholder.com/150/fbfbff/000000?text=FBFBFF">
<img src= "https://via.placeholder.com/150/7192be/FFFFFF?text=7192BE">
<img src= "https://via.placeholder.com/150/5370b9/FFFFFF?text=5370b9">
<img src= "https://via.placeholder.com/150/A3A3A3/FFFFFF?text=A3A3A3">

# Image & Video Reference
![App Demo](./videos/Mobile_Demo.mov)
![Project Overview](./images/Mobile_Overview.png)
![Desktop Demo](./videos/Desktop_Demo.mov)
![Project Overview](./images/Desktop_Overview.png)

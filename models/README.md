# Domain Models
Models in a DDD

[TOC]

# Use Cases
## Assignment
### Create
- Must be a member of that organization
- Must have a date and a time
- May have an assignee
- May have some notes
- Must have a name

### Edit
- Have an assignment already created
  - What parts can you edit?
    - Notes can freely be edited
    - Assignee, time, and date

### Mark Complete
- Must have an assignment already created

### Remove/Delete
- Must have an assignment already created
- Must be member with higher or equal privileges as creator

### Search
- Search by the Assignment ID
- Search by Member ID

## Event
### Create
- Must be created by a member
- Member must be in the organization
- Must assign events to only members within the organization
- Must have a name
- Must have a location
- Must have a Time and Date
- Mustn’t be a generic event, must be a subclass
- May have assignees, but may also have no assignees

### Edit
- Event must already exist
- May change the name
- May change the time & date
- May change the location
- May change the assignee(s)
- May not change the type of event

### Remove/Delete
- Event must already exist
- Must be a member with equal or higher privileges as creator

### Search
- Event must already exist
- Search by Event ID
- Search by Member assigned ID
- Search my Members assigned IDs

## Organization (Domain)
### Create
- Must be created by a User (creator) Use Case Policy
- Must have a Creator Class Policy
- Must be given a name Class Policy
- Must include one member Class Policy
### Add Member
- Promotes User to Member
- Must be a User
- Must be given a role
- Must exist
- Must have an organization
- Must have an organization Role
### Remove Member
- Must be a member
- Must demote to User
- Must be creator of organization
### Edit Member
- May change the users role
### Search
- Must exist
- Search existing members by Member ID
- Search by organization ID
- Search by member relation ID
- Search by Event relation ID
- Search by Assignment relation ID

### Remove/Delete
- Must be existing organization
- Must be the creator of the organization
- Must set transform all members to users

### Edit
- Must be existing organization
- Must be creator
- May change the name of the organization

`class Organization extends Entity`
`class CreateOrganization extend UseCase`

## Member
### Create
- Must be a User
- Must have organization relationship
- Must have an organization Role

### Edit
- Must exist 
- May change Name
- May change Phone Number
- May change password

### Search
- Must exist
- Find by Member ID
- Find by Organization relation ID

### Remove/Delete
- Must exist
- Must be Organization or creator of organization

## User
### Create
- Must be given a password
- Must be given a name
- Must be given a email

### Remove/Delete
- Must exist
- Must not have an organization?

### Edit
- Must exist
- May change password
- May change phone number
- May change name

### Search
- Must exist
- Find by User ID

### Types of Users
1. User Used in Organization
   - Any generic Application User. This 'user' has a first name, last name, name, username, password.
2. MemberUser Used in Member
   - Any Generic User. This user has a first name, last name, name, email, phone number, and role. Role may be modified by a Current Member who has Privilages.
3. CurrentUser
   - The user that is accessing the application. This user has a first name, last name, name, email, phone number, role, password, username, Privilages. All but role is modifyable.

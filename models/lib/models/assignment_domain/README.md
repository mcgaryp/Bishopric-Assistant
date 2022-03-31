### Assignments

1. Assignment

+ ID: AssignmentID
+ Title: String
+ Notes: String
+ Due Date: Date
+ Creator: Role
+ Editable By Others: bool
+ Reassignable By Others: bool
+ isArchived: bool
+ isCompleted: bool
+ isOverDue: bool
+ Viewers: List<Role>
+ Assignee: Role
+ canView(RoleID): bool
+ canEdit(RoleID): bool
+ canReassign(RoleID): bool
+ archive()
+ unArchive()
+ markComplete()
+ markIncomplete()


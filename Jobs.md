### Contributors Collaboration Efforts

<details><summary>Table Details</summary>

- Contributor - Developer who contributes to the project
- Story - ID from the list below... This will eventually be moved to the issues and will be a link to the correct Issue
- Branch - Name or link of the branch the work can be found on
- Merge Request - link to the MR on GitLab
- App Version - Version number of the app after story is merged into the parent branch

</details>

|Contributor|Story|Branch|Merged Request|App Version|
|-----------|-----|------|--------------|-----------|
|Porter     |1.|porter/front-end-with-models|[17](https://gitlab.com/the-vikings/mjolnir/bishopric-assistant/-/merge_requests/17)|0.0.2|
|Johnathan  |||||
|Chandler   |||||

**Stories Backlog**
1. As a user I want to create an account on the bishopric webpage so that I can sign and access the Application.
  - [ ] Provide the user a way to navigate back to the login page
  - [ ] Create sign up page that includes using the `CreateAccountUseCase`
  - [ ] Define insert, generateNextId, and findUserByUsername function in `AccountRepository`
  - [ ] Create an Account table in Firestore Database
  - [ ] Handle return of error message or account
    - [ ] On error display error messages
    - [ ] Display a message to the user on success with their name in it. Navigate user to Login page.
2. As a developer I want the front end to not rely on the validating the data so that an adapter can take its place.
3. As a user I want to login to my account on the bishopric webpage so that I can interact with the application
  - [ ] Use `AuthenticateAccountUseCase`
  - [ ] Need to provide a username and password textField
  - [ ] Login button that allows the credentials to be checked before gaining access
    - [ ] On error display error message
    - [ ] On success navigate the user to the main page
  - [ ] Sign up button that navigates the user to the signup page
  - [ ] Forgot username or password button that navigates the request recover account
4. As a user I want to be able to recover my account so that I if ever lose my password or username I can reset them
  - [ ] Implement
  - [ ] Recover Account page: Offers Text field to insert the users email or phone number
    - [ ] Use `RecoverAccountUseCase` and `ChangePasswordUseCase`
    - [ ] On error display error
    - [ ] On success send confirmation email or text to the user, navigate to PIN Confirmation page
  - [ ] PIN Confirmation page: Offers Text Field to insert Confirmation PIN
    - [ ] On error display error
    - [ ] On success navigate user to Reset Password page
  - [ ] Reset Password page: Offers Text Fields for password and confirmation password
    - [ ] On error display error
    - [ ] On success navigate user to login page
5. As a user I want the ability to remove my information from the system so that I know that others can't see my information on the webapp
  - [ ] Use `DeleteAccountUseCase`
  - [ ] On the User Profile Page a button should be provided to deactivate the user account
  - [ ] Deactivate the user account by switching the active to inactive. No user account information should be deleted! Only invisible to others on the service
6. As a user I want to change my password on demand after logging into my account so that if I need to change my password ofr security reasons
  - [ ] Use `ChangePasswordUseCase`
  - [ ] On the user profile Page a button to change the password of the user account gives the user access to change their password
    - [ ] On error display error
    - [ ] On success notify user of success and return the profile page back to normal
7. As a user I want to change my contact information on demand after logging into my account
  - [ ] Use `ChangeContactUseCase`
  - [ ] On the user profile Page a button to edit the contact information of the user account that gives the user access to change their 
      - [ ] On error display error
      - [ ] On success notify user of success and return the profile page back to normal
8. As a developer I want an `Entity` to have `toJson` and `fromJson` methods so that the API works more fluidly with mapping.
  - [ ] Look at `Account` as a reference to what these methods and constructors should look like for `Entity`
  - [ ] Consider changing how `ValueObject` forces `decode` and `encode`

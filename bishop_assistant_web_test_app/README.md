## Flavor of Builds

Each flavor separates different environments and target audiences. Any debug "scenario" can be
created of any environments.

1. Production - the stage that runs the flutter app the way end-users will see the application.
   `flutter run --dart-define=prod=true`
2. Beta - the staging ground for new features that need to run through our testing crowd.
   `flutter run --dart-define=beta=true`
3. Development - the stage and environment safe for experimentation and new feature development
   `flutter run`

### Add Separate Run/Debug Configurations with Flavors

Before beginning:

- ensure Android Studio with Flutter and Dart plugins are installed.
- ensure the correct `.env` files are located in the project directory. Files should be named as
  follows:
    - Development Environment `dev.env`
    - Beta Environment `beta.env`
    - Production Environment `prod.env`

1. <b>OPEN</b> `assistant` App in Android Studio.
2. In the top menu bar of Android Studio, <b>CLICK</b> on the drop down menu next to the green
   Run/Debug Triangle button.
3. In the drop down menu, <b>CLICK</b> `Edit Configurations`. A popup box entitled.
   `Run/Debug Configurations` should display.
4. On the top left hand side of the popup <b>CLICK</b> the `+` button. A dropdown menu should appear
5. From the drop down menu <b>CLICK</b> `Flutter`. A new form should appear in the right hand side
   of the popup box.
6. Give your configuration a `Name`.
7. As the `Dart entrypoint` enter
   `local_path_to_project/bishopric-assistant/bishop_assistant_web_test_app/lib/main.dart`
8. As the `Additional run args` enter only one of the following for each configuration:
    - `--dart-define=prod=true` for Production Environment
    - `--dart-define=beta=true` for Beta Environment
    - `` for Developer Environment
9. Repeat steps 2-8 for each environment. Ensure each configuration has a distinct name.
10. Repeat step 2.
11. Select the environment configuration you would like to run/debug.
12. Select the device dropdown to the left of the run/debug configuration dropdown. Select the
    device you would like to run the application on.
11. Select the green Run/Debug Triangle button to run the application on it's selected device and
    environment.

## Release Notes
<table>
   <thead>
      <tr>
         <th>Version</th>
         <th>Release Notes</th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>0.1.2</td>
         <td><b>Infinite Loading Screen</b>
            <ul>
               <li>Fixes Infinite Loading screen</li>
               <li>Login is more intuitive to website paths</li>
            </ul>
         </td>
      </tr>
      <tr>
         <td>0.1.1</td>
         <td><b>Patch</b>
            <ul>
               <li>Beta Invites support more ways to share</li>
               <li>Organization Name change on enter button</li>
               <li>Dev database support</li>
               <li>Media Picker for Bug Reports foundation</li>
            </ul>
         </td>
      </tr>
      <tr>
         <td>0.1.0</td>
         <td><b>Beta Release</b>
            <ul>
               <li>Sign Up with Beta 24hr Link</li>
               <li>Login</li>
               <li>View Organizations</li>
               <li>Search Organizations</li>
               <li>Create Organization</li>
               <li>Request to Join Organization</li>
               <li>Manage Organization</li>
               <li>Create Assignments</li>
               <li>Create Bug Reports</li>
               <li>View Account Details</li>
            </ul>
         </td>
      </tr>
   </tbody>
</table>
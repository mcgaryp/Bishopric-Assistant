# Firebase Deployment Process
1. Navigate to the path `bishop_assistant_web_test_app/`
2. Ensure that the flutter project is cleaned up `flutter clean`
3. Make sure to build the web application using `flutter build web` don not forget to add 
   appropriate tags

## Deploy to Temporary Site
1. `firebase login`
   - Login properly
2. `firebase use default`
3. `firebase hosting:channel:deploy dev_channel`
   
## Deploy to https://www.theassistantbeta.app
1. `firebase login`
   - Login properly
2. `firebase use beta`
3. `firebase deploy --only hosting`

## Deploy to https://www.theassistant.app
1. `firebase login`
    - Login properly
2. `firebase use prod`
3. `firebase deploy --only hosting`
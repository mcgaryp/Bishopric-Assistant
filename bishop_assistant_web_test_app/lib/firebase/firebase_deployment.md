# Firebase Deployment Process
1. Make sure to build the web application using `flutter build web`

## Deploy to Temporary Site
1. `firebase login`
   - Login properly
2. `firebase use dev`
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
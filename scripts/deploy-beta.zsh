zsh ./build-beta.zsh
cd ../bishop_assistant_web_test_app || exit
firebase use beta
firebase deploy --only hosting
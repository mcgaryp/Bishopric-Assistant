zsh ./build-beta.zsh
cd ../bishop_assistant_web_test_app || exit
firebase use default
firebase hosting:channel:deploy dev_channel
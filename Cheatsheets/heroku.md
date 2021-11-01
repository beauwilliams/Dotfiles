<!-- Add existing repo to heroku -->
heroku git:remote -a ribitz

<!-- Create new heroku app -->
heroku create

<!-- deploy -->
git push heroku master

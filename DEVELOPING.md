# Set up environment

## Clone Repo

```
git clone https://github.com/rails-school/school.git
```

## Install gems

```
bundle install
```

## Running migrations and creating basic data in the development database for the app to run

```
rake db:migrate
rake db:seed
```

# Push to production

## Add remote branches

```
git remote add rssf https://git.heroku.com/rssf.git
git remote add rssf-worker https://git.heroku.com/rssf-worker.git
```

## Push your changes

```
git push rssf master
git push rssf-worker master
```

## Run migrations

```
heroku run rake db:migrate --app rssf
```

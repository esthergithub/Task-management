## Task
| Column name | Data type |
|:------------|:-----------|
| title       | string     |
| content     | text       |
| due date    | datetime   |
| progress    | string     |
| priority    | integer    |
| id          | integer    |


## User
| Column name | Data type |
|:----------------|:-----------|
| name            | string     |
| email           | string     |
| password        | string     |
| id              | integer     |


## Label
| Column name | Data type |
|:------------|:-----------|
| name        | string     |


## Deploying on Heroku

1. Login
 - Login using the command
 ```heroku login ```


2. Create an app on heroku using
  ```heroku create```


3. Send codes to heroku from main branch using
  ```git push heroku main ```


4. Run migrations on heroku using
  ```heroku run:detached rails db:migrate```

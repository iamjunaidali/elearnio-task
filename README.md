[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails)
[![Rails Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rails.rubystyle.guide)

### Project Setup

 1. Clone the Project:
 ```sh
git clone git@github.com:iamjunaidali/elearnio-task.git
cd elearnio-task
```
System Dependencies:
- Ruby version (3.0.0)
- PostgreSQL (12.4)

2. Bundle install
    + `bundle install`
3. Run Data Migrations
    + `rails db:setup db:migrate`
4. Populate Data
    + `rails db:seed`
**Running the Rails Server**

 - rails s

**Running Tests**

- bundle exec rspec

# API Endpoints

## Course:
### Create

curl -X POST \
  http://localhost:3000/api/v1/courses \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.api+json' \
  -H 'postman-token: 3b918287-4d4a-5e3f-ece7-8c769418722e' \
  -d '{
   "data":{
      "type":"courses",
      "attributes":{
         "name":"CS401"
      },
      "relationships":{
         "coach":{
            "data":{
               "type":"coaches",
               "id":"3"
            }
         }
      }
   }
}'

### Show

curl -X GET \
  http://localhost:3000/api/v1/courses/:id \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.api+json' \
  -H 'postman-token: e958708c-f72f-5489-0bd3-a33421f022e9' \

### Index

curl -X GET \
  http://localhost:3000/api/v1/courses \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.api+json' \
  -H 'postman-token: e958708c-f72f-5489-0bd3-a33421f022e9' \

### Self Assignable Courses

curl -X GET \
  'http://localhost:3000/api/v1/courses?filter%5Bself_assignable%5D=true' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.api+json' \
  -H 'postman-token: 5de4ff63-2fe5-2439-1563-8a30aef2b8f7' \

## Coach:
### Create

curl -X POST \
  http://localhost:3000/api/v1/coaches \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.api+json' \
  -H 'postman-token: 3b918287-4d4a-5e3f-ece7-8c769418722e' \
  -d '{
   "data":{
      "type":"coaches",
      "attributes":{
         "name":"Morgan"
      }
   }
}'

### Delete

curl -X DELETE \
  http://localhost:3000/api/v1/coaches/:id \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.api+json' \
  -H 'postman-token: e4557ef5-56bc-eaa3-7068-dc5c069b16b5' \

### Show

curl -X GET \
  http://localhost:3000/api/v1/coaches/:id \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.api+json' \
  -H 'postman-token: e958708c-f72f-5489-0bd3-a33421f022e9' \

### Index

curl -X GET \
  http://localhost:3000/api/v1/coaches \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.api+json' \
  -H 'postman-token: e958708c-f72f-5489-0bd3-a33421f022e9' \

## Activities:
### Create

curl -X POST \
  http://localhost:3000/api/v1/activities \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.api+json' \
  -H 'postman-token: 3b918287-4d4a-5e3f-ece7-8c769418722e' \
  -d '{
   "data":{
      "type":"activities",
      "attributes":{
         "name":"Q1"
      },
      "relationships":{
         "course":{
            "data":{
               "type":"courses",
               "id":"3"
            }
         }
      }
   }
}'

### Delete

curl -X DELETE \
  http://localhost:3000/api/v1/activities/:id \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.api+json' \
  -H 'postman-token: e4557ef5-56bc-eaa3-7068-dc5c069b16b5' \

### Show

curl -X GET \
  http://localhost:3000/api/v1/activities/:id \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.api+json' \
  -H 'postman-token: e958708c-f72f-5489-0bd3-a33421f022e9' \

### Index

curl -X GET \
  http://localhost:3000/api/v1/activities \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.api+json' \
  -H 'postman-token: e958708c-f72f-5489-0bd3-a33421f022e9' \


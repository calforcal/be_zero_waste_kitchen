# zero_waste_kitchen

## Welcome!
At Zero Waste Kitchen we're here to combat the growing problem of food waste in the United States. American households generate an estimated 42 billion pounds of food waste each year. This is enough food to feed **21 million people each year**. 

The consequences of this waste not only has a direct impact on people but far reaching effects for the planet. **96% of this waste ends up in the landfill** - resulting in roughly 12 Million Tons of CO2 emissions. That amount of emissions is equivalent to powering 1.5 million homes for a year, or driving a car 2.6 million miles.

Our app is aimed at helping people eliminate food waste in their homes by providing recipes based on ingredients that will soon spoil and contribute to food waste. We hope to inspire users to waste less, save more and have an increased awareness around their personal impact and ability to contribute by having a Zero Waste Kitchen.

## Project Repos and Links
#### Repos
1. [Frontend Repository](https://github.com/calforcal/fe_zero_waste_kitchen)
2. [Backend Repository](https://github.com/calforcal/be_zero_waste_kitchen)

#### Production Deployment
1. [Frontend Production](https://fe-zero-waste-kitchen.onrender.com/)
2. [Backend Production](https://be-zero-waste-kitchen.onrender.com/)

## Contributors
- K.D Hubbard | [LinkedIn](https://www.linkedin.com/in/k-d-hubbard/) | | [Github](https://github.com/kdhubb) |
- Boston Lowrey | [LinkedIn](https://www.linkedin.com/in/boston-lowrey/) | | [Github](https://github.com/blowrey24) |
- Michael Callahan | [LinkedIn](https://www.linkedin.com/in/michaelcallahanjr/) | | [Github](https://github.com/calforcal) |
- Matthew William Johnson | [LinkedIn](https://www.linkedin.com/in/matthewwjohnsonttu/) | | [Github](https://github.com/mwmjohnson) |

## Repo Installation
In your terminal run the following commands to clone the repositories:

**Frontend**
          
     git clone git@github.com:calforcal/fe_zero_waste_kitchen.git

**Backend**

     git clone git@github.com:calforcal/be_zero_waste_kitchen.git

**Installing the Gems Locally**

     bundle install

**Front API Keys Needed**

Both of these keys will need to be requested from an Admin (see above)
- `GOOGLE_OAUTH_CLIENT_ID`
- `GOOGLE_OAUTH_CLIENT_SECRET`
- `ZWK_API_KEY`

**Backend API Keys Needed**

- NUTRITION_API_KEY: [API Ninjas](https://api-ninjas.com/api/nutrition)
- EMISSIONS_API_KEY: [ClimatIQ](https://www.climatiq.io/docs/api-reference/estimate)
- SPOON-KEY: [Spoonacular](https://spoonacular.com/food-api/docs#Search-Recipes-by-Ingredients)
- NX_APP_ID: [Nutronix](https://docs.google.com/document/d/1_q-K-ObMTZvO0qUEAxROrN3bwMujwAN25sLHwJzliK0/edit#heading=h.h3vlpu5rgxy0)
- NX_APP_KEY: [Nutronix](https://docs.google.com/document/d/1_q-K-ObMTZvO0qUEAxROrN3bwMujwAN25sLHwJzliK0/edit#heading=h.h3vlpu5rgxy0)
- BACKEND_API_KEY: *Request From Admin*

**Installing Figaro**

[Figaro Gem Docs](https://github.com/laserlemon/figaro)

In your terminal run:

     bundle exec figaro install

In the new file `config/application.yml`

Post your keys as they are listed above in this file, for both frontend and backend.

**Testing the Repositories**

Start up BOTH Servers (Frontend / Backend) by running the following command in each terminal:

     rails s

To run the full test suite:

     bundle exec rspec

## Databse Schema

**[Link to Virtual Design](https://dbdiagram.io/d/64c2cfe502bd1c4a5ed24ed9)**

#### Ingredients

    t.string "name"
    t.float "units"
    t.string "unit_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

#### Recipe Ingredients

    t.bigint "recipe_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"

#### Recipes

    t.string "name"
    t.string "instructions", default: [], array: true
    t.string "image_url"
    t.integer "cook_time"
    t.boolean "public_status", default: true
    t.string "source_name"
    t.string "source_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "user_submitted"
    t.string "api_id"

#### Saved Ingredients

    t.bigint "user_id", null: false
    t.string "ingredient_name"
    t.string "unit_type"
    t.float "units"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_saved_ingredients_on_user_id"

#### User Recipes

    t.bigint "user_id", null: false
    t.bigint "recipe_id", null: false
    t.integer "num_stars"
    t.boolean "cook_status"
    t.boolean "saved_status"
    t.boolean "is_owner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_user_recipes_on_recipe_id"
    t.index ["user_id"], name: "index_user_recipes_on_user_id"

#### Users

    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

#### Foreign Keys

  ```
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "saved_ingredients", "users"
  add_foreign_key "user_recipes", "recipes"
  add_foreign_key "user_recipes", "users"
  ```

## ZWK JSON Contract

### Fetch One User
<p> GET '/api/v1/users/:id’ </p>
<p> Example response of the User resource </p>

```
{
  "data": {
    "id": "integer",
    "type": "string",
    "attributes": {
      "uid": "string",
      "name": "string",
      "email": "string",
      "stats": {
        "lions_saved": "integer",
        "recipes_cooked": "integer",
        "recipes_created": "integer"
      }
      "cooked_recipes": [
        {
          "name": "string",
          "api_id": "string",
          "id": "integer"
        }
      ]
      "created_recipes": [
        {
          "name": "string",
          "api_id": "string",
          "id": "integer"
        }
      ]
      "saved_recipes": [
        {
          "name": "string",
          "api_id": "string",
          "id": "integer"
        }
      ]
      "num_cooked_recipes": "integer",
      "num_created_recipes": "integer",
      "num_saved_recipes": "integer"
    }
  }
}
```


### Create One User
<p> POST '/api/v1/users’ </p>
<p> Example of the body details to be provided when creating a user </p>

```
{
  "uid": "string"
}
```

### Create a Recipe
<p> POST ‘/api/v1/user/:user_id/recipes’ </p>
<p> Example of the body details to be provided when creating a recipe </p>

```
{
  "name": "string",
  "instructions": "array",
  "image_url": "string",
  "cook_time": "string",
  "public_status": "boolean",
  "source_name": "string",
  "source_url": "string",
  "user_submitted": "boolean",
  "api_id": "string",
  "uid": "string",
  "ingredients": [
    {
      "name": "string",
      "units": "float",
      "unit_type": "string" 
    },
    {
      "name": "string",
      "units": "float",
      "unit_type": "string" 
    }
  ]
}
```

### Create a Cooked Recipe (user_recipes)
<p> POST ‘/api/v1/user/:user_id/recipes/:recipe_id’ </p>
<p> Example of the body details to be provided when creating a cooked recipe </p>

```
{
  "uid": "string",
  "recipe_id": "integer",
  "api_id": "string",
  "cook_status": "boolean"
}
```

### Create Saved Ingredients (user_ingredients)
<p> POST ‘/api/v1/user/:user_id/ingredients’ </p>
<p> Example of the body details to be provided when creating a saved recipe </p>

```
{
  "uid": "string",
  "ingredients: [
    {
      "ingredient_name": "string",
      "units": "float",
      "unit_type": "string" 
    }
  ]
}
```

### Create a Saved Recipe (user_recipes)
<p> POST ‘/api/v1/user/:user_id/recipes/:recipe_id’ </p>
<p> Example of the body details to be provided when creating a saved recipe </p>

```
{
  "uid": "integer",
  "recipe_id": "integer",
  "api_id": "string",
  "saved_status": "boolean"
}
```
### Rate a Recipe (user_recipes)
<p> POST ‘/api/v1/user/:user_id/recipes/:recipe_id’ </p>
<p> Example of the body details to be provided when creating a saved recipe. (Ratings are 1-5) </p>

```
{
  "uid": "string",
  "recipe_id": "integer",
  "api_id": "string",
  "num_stars": "integer"
}
```

### Update a Cooked Recipe (user_recipes)
<p> PATCH ‘/api/v1/user/:user_id/recipes/:recipe_id’ </p>
<p> Example of the body details to be provided when updating (rating) a cooked recipe </p>

```
{
  "uid": "string",
  "recipe_id": "integer",
  "api_id": "string",
  "cook_status": "boolean",
  "num_stars": "integer"
}
```

### Update One User
<p> PATCH '/api/v1/users/:id’ </p>
<p> Example of the body details to be provided when updating a user </p>

```
{
  "uid": "string",
  "name": "string",
  "email": "string"
}
```

### Fetch One Saved Recipes
<p>GET '/api/v1/recipes/:id'</p>
<p> Example response of a Recipes resource </p>

```
{
  "id": "integer",
  "type": "string",
  "attributes": {
    "image_url": "string",
    "name": "string",
    "rating_from_api": "float",
    "cook_time": "integer",
    "public_status": "boolean",
    "ingredients": [
      {
        "name": "string",
        "units": "float",
        "unit_type": "string"
      },
      {
        "name": "string",
        "units": "float",
        "unit_type": "string"
      }
    ],
    "source_name": "string",
    "source_url": "string",
    "instructions": ["string", "string", ...]
  }
}
```

### Update One Recipe
<p> PATCH '/api/v1/user/:user_id/recipes/:recipe_id’ </p>
<p> Example of the body details to be provided when updating a recipe </p>

```
{
  "user_id": "integer",
  "recipe_id": "integer",
  "name": "string",
  "cook_time": "integer",
  "source_name": "string"
}
```

### Delete One Recipe
<p> DELETE '/api/v1/user/:user_id/recipes/:recipe_id’ </p>
<p> Example of the body details to be provided when deleting a recipe </p>

```
{
  "uid": "string",
  "recipe_id": "integer"
}
```

### Fetch One Users Friends (chefs)
<p> GET '/api/v1/users/:id/chefs’ </p>
<p> Example response of the Users Chefs resource </p>

```
{
  "data": [
  {
    "id": "string",
    "type": "string",
    "attributes": {
      "name": "string",
      "username": "string"
    },
  },
  {
    "id": "string",
    "type": "string",
    "attributes": {
      "name": "string",
      "username": "string"
    }
  }]
}
```

### Fetch all ingredients
<p> GET '/api/v1/ingredients' </p>
<p> Example response of the Ingredients resource </p>

```
{
  "data": [
    {
      "name": "string"
    },
    {
      "name": "string"
    },
    {
      "name": "string"
    }
  ]
}
```

### Fetch searched recipes --> by Name
<p> GET ‘/api/v1/recipes/search?search=query%string’ </p>
<p> Example of a response from the Search (by name) resource </p>


```
{
  "data": [
    {
      "id": "string",
      "type": "string",
      "attributes": {
        "name": "string",
      }
    },
    {
      "id": "string",
      "type": "string",
      "attributes": {
        "name": "string",
      }
    }
  ]
}
```


### Fetch searched recipes --> by Ingredients
<p> GET ‘/api/v1/recipes/search?ingredients=query%string,+query’ </p>
<p> Example of a response from the Search (by ingredients(s) ) resource </p>


```
{
  "data": [
    {
      "id": "string",
      "type": "string",
      "attributes": {
        "name": "string",
      }
    },
    {
      "id": "string",
      "type": "string",
      "attributes": {
        "name": "string",
      }
    }
  ]
}
```

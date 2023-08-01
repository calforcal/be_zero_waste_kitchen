# zero_waste_kitchen

# ZWK JSON Contract

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
      },
      "cooked_recipes": [
        {
          "name": "string",
          "api_id": "string",
          "id": "integer"
        }
      ],
      "created_recipes": [
        {
          "name": "string",
          "api_id": "string",
          "id": "integer"
        }
      ],
      "saved_recipes": [
        {
          "name": "string",
          "api_id": "string",
          "id": "integer"
        }
      ],
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
  "api_id": "string"
}
```

### Create a Cooked Recipe (user_recipes)
<p> POST ‘/api/v1/user/:user_id/recipes/:recipe_id’ </p>
<p> Example of the body details to be provided when creating a cooked recipe </p>

```
{
  "user_id": "integer",
  "recipe_id": "integer",
  "api_id": "string",
  "cook_status": "boolean"
}
```

### Create a Saved Recipe (user_recipes)
<p> POST ‘/api/v1/user/:user_id/recipes/:recipe_id’ </p>
<p> Example of the body details to be provided when creating a saved recipe </p>

```
{
  "user_id": "integer",
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
  "uid": "integer",
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
  "user_id": "integer",
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
  "id": "integer",
  "name": "string",
  "email": "string"
}
```

### Fetch One Saved Recipes
<p>GET '/api/v1/recipes/:id'</p>
<p> Example response of a Recipes resource </p>

```
{
  "id": "string",
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
  "user_id": "integer",
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
<p> GET ‘/api/v1/recipes/search?name=query%string’ </p>
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
<p> GET ‘/api/v1/recipes/search?ingredient=query%string,+query’ </p>
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

# Users

Users can be used to log into the web shop. They are useful for exposing your shop to a limited audience or verifiying that a customers can actually be reached via an email.

A user always belongs to a Customer. A customer can have multiple users. This is relevant for companies where multiple people are allowed to book orders in the name of that company.
Because of this, a user should always be an actual person, not a legal person.

Depending on the setting in your Booqable account, creating a user can actually mean that you're inviting the user. In that case, the user still needs to confirm their email and set a password before the account is active. (See *status*)

## Endpoints
`GET /api/boomerang/users`

`GET /api/boomerang/users/{id}`

`POST /api/boomerang/users`

`PUT /api/boomerang/users/{id}`

## Fields
Every user has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`first_name` | **String** <br>The first name of the user
`last_name` | **String** <br>The last name of the user
`name` | **String** <br>The full name of the user (first_name + last_name)
`email` | **String** <br>The email of the user
`status` | **String** `readonly`<br>One of `disabled`, `active`, `invited`, `unconfirmed`
`disabled` | **Boolean** `writeonly`<br>When a user is disabled they cannot log into their account or create orders
`customer_id` | **Uuid** <br>The associated Customer


## Relationships
Users have the following relationships:

Name | Description
-- | --
`customer` | **Customers** <br>Associated Customer
`notes` | **Notes** `readonly`<br>Associated Notes


## Listing users



> How to fetch a list of users:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/users' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "25a76e3d-256b-465f-9c0e-8ba6d4803bc7",
      "type": "users",
      "attributes": {
        "created_at": "2024-09-16T09:26:07.527020+00:00",
        "updated_at": "2024-09-16T09:26:07.527020+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-6@doe.test",
        "status": "active",
        "customer_id": "0fc07cb5-3de6-47cb-9d67-fcf155a6a833"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> How to find users belonging to a customer:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=f53b1526-87d2-4dda-94a5-eb31f646d47b&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5e26696f-9807-4b15-b937-a92dc99f403c",
      "type": "users",
      "attributes": {
        "created_at": "2024-09-16T09:26:06.922257+00:00",
        "updated_at": "2024-09-16T09:26:06.922257+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-5@doe.test",
        "status": "active",
        "customer_id": "f53b1526-87d2-4dda-94a5-eb31f646d47b"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/users`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[users]=created_at,updated_at,first_name`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`first_name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`last_name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`email` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`customer_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a user



> How to fetch a user:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/users/ca84934e-800b-4376-bf5f-c746e24255b3' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ca84934e-800b-4376-bf5f-c746e24255b3",
    "type": "users",
    "attributes": {
      "created_at": "2024-09-16T09:26:03.411975+00:00",
      "updated_at": "2024-09-16T09:26:03.411975+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-2@doe.test",
      "status": "active",
      "customer_id": "11b32947-db42-4923-bf81-d738dfa8cd2a"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/users/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=customer,disabled_by,notes`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[users]=created_at,updated_at,first_name`


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Inviting a user



> How to invite a user:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/users' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "users",
        "attributes": {
          "first_name": "Bob",
          "last_name": "Bobsen",
          "email": "bob@booqable.com",
          "customer_id": "0c5b1db9-3762-4282-988e-9091f03f0b02"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "bb576068-230d-4063-aa1e-ddf04e6f8c4f",
    "type": "users",
    "attributes": {
      "created_at": "2024-09-16T09:26:04.286551+00:00",
      "updated_at": "2024-09-16T09:26:04.298151+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "0c5b1db9-3762-4282-988e-9091f03f0b02"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/users`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=customer,disabled_by,notes`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[users]=created_at,updated_at,first_name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][first_name]` | **String** <br>The first name of the user
`data[attributes][last_name]` | **String** <br>The last name of the user
`data[attributes][name]` | **String** <br>The full name of the user (first_name + last_name)
`data[attributes][email]` | **String** <br>The email of the user
`data[attributes][disabled]` | **Boolean** <br>When a user is disabled they cannot log into their account or create orders
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Updating a user



> How to update a user:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/users/2d1b4531-a128-4bab-a98a-3ea42400f8fe' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2d1b4531-a128-4bab-a98a-3ea42400f8fe",
        "type": "users",
        "attributes": {
          "first_name": "Bobba"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2d1b4531-a128-4bab-a98a-3ea42400f8fe",
    "type": "users",
    "attributes": {
      "created_at": "2024-09-16T09:26:05.862574+00:00",
      "updated_at": "2024-09-16T09:26:05.920153+00:00",
      "first_name": "Bobba",
      "last_name": "Doe",
      "name": "Bobba Doe",
      "email": "john-4@doe.test",
      "status": "active",
      "customer_id": "afb6ce04-1a04-4eb4-a3e0-1dfa0be89ab9"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/users/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=customer,disabled_by,notes`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[users]=created_at,updated_at,first_name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][first_name]` | **String** <br>The first name of the user
`data[attributes][last_name]` | **String** <br>The last name of the user
`data[attributes][name]` | **String** <br>The full name of the user (first_name + last_name)
`data[attributes][email]` | **String** <br>The email of the user
`data[attributes][disabled]` | **Boolean** <br>When a user is disabled they cannot log into their account or create orders
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Enabling a user



> How to enable a user:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/users/a04f46cd-d2de-4c24-af31-765712bb5b16' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a04f46cd-d2de-4c24-af31-765712bb5b16",
        "type": "users",
        "attributes": {
          "disabled": false
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a04f46cd-d2de-4c24-af31-765712bb5b16",
    "type": "users",
    "attributes": {
      "created_at": "2024-09-16T09:26:08.694911+00:00",
      "updated_at": "2024-09-16T09:26:08.807500+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-8@doe.test",
      "status": "active",
      "customer_id": "8ea37a1c-a8ac-4511-aa78-8ce54df809af"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/users/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=customer,disabled_by,notes`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[users]=created_at,updated_at,first_name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][first_name]` | **String** <br>The first name of the user
`data[attributes][last_name]` | **String** <br>The last name of the user
`data[attributes][name]` | **String** <br>The full name of the user (first_name + last_name)
`data[attributes][email]` | **String** <br>The email of the user
`data[attributes][disabled]` | **Boolean** <br>When a user is disabled they cannot log into their account or create orders
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Disabling a user



> How to disable a user:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/users/4137e651-6d69-459d-8597-02d6a6f551e3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4137e651-6d69-459d-8597-02d6a6f551e3",
        "type": "users",
        "attributes": {
          "disabled": true
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4137e651-6d69-459d-8597-02d6a6f551e3",
    "type": "users",
    "attributes": {
      "created_at": "2024-09-16T09:26:08.048539+00:00",
      "updated_at": "2024-09-16T09:26:08.104308+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-7@doe.test",
      "status": "disabled",
      "customer_id": "8cb8cddc-03cd-4ddb-9c96-079888ec9a31"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/users/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=customer,disabled_by,notes`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[users]=created_at,updated_at,first_name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][first_name]` | **String** <br>The first name of the user
`data[attributes][last_name]` | **String** <br>The last name of the user
`data[attributes][name]` | **String** <br>The full name of the user (first_name + last_name)
`data[attributes][email]` | **String** <br>The email of the user
`data[attributes][disabled]` | **Boolean** <br>When a user is disabled they cannot log into their account or create orders
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






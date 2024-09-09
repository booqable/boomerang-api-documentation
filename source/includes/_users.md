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
      "id": "24156b26-5571-447b-8098-11e41ba927de",
      "type": "users",
      "attributes": {
        "created_at": "2024-09-09T09:25:10.053034+00:00",
        "updated_at": "2024-09-09T09:25:10.053034+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-6@doe.test",
        "status": "active",
        "customer_id": "89fbeb65-a027-4cad-a8e2-529948b9c34b"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=2e912fda-1ad2-4d3f-95e3-3b80697a273d&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "250b8d01-d0fa-4671-8d36-dcfc96d7540b",
      "type": "users",
      "attributes": {
        "created_at": "2024-09-09T09:25:09.518800+00:00",
        "updated_at": "2024-09-09T09:25:09.518800+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-5@doe.test",
        "status": "active",
        "customer_id": "2e912fda-1ad2-4d3f-95e3-3b80697a273d"
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
    --url 'https://example.booqable.com/api/boomerang/users/c5853151-8c87-42d6-ac2a-ee556f512ea4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c5853151-8c87-42d6-ac2a-ee556f512ea4",
    "type": "users",
    "attributes": {
      "created_at": "2024-09-09T09:25:10.582516+00:00",
      "updated_at": "2024-09-09T09:25:10.582516+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-7@doe.test",
      "status": "active",
      "customer_id": "fcc7614e-9c3c-443b-b773-6349216c29fb"
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
          "customer_id": "ec6fc690-4303-453d-baa6-806b49483cbb"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "cb039f62-5c89-499a-9dc0-ab84f5434c71",
    "type": "users",
    "attributes": {
      "created_at": "2024-09-09T09:25:09.002256+00:00",
      "updated_at": "2024-09-09T09:25:09.018669+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "ec6fc690-4303-453d-baa6-806b49483cbb"
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
    --url 'https://example.booqable.com/api/boomerang/users/4bfad0c2-b097-498a-945d-7d20f759ebf7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4bfad0c2-b097-498a-945d-7d20f759ebf7",
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
    "id": "4bfad0c2-b097-498a-945d-7d20f759ebf7",
    "type": "users",
    "attributes": {
      "created_at": "2024-09-09T09:25:07.723102+00:00",
      "updated_at": "2024-09-09T09:25:07.775345+00:00",
      "first_name": "Bobba",
      "last_name": "Doe",
      "name": "Bobba Doe",
      "email": "john-2@doe.test",
      "status": "active",
      "customer_id": "593af03a-949a-4107-9476-93cc701675fd"
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
    --url 'https://example.booqable.com/api/boomerang/users/f3386828-1c21-46e0-8cc7-8df374d47358' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f3386828-1c21-46e0-8cc7-8df374d47358",
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
    "id": "f3386828-1c21-46e0-8cc7-8df374d47358",
    "type": "users",
    "attributes": {
      "created_at": "2024-09-09T09:25:11.146890+00:00",
      "updated_at": "2024-09-09T09:25:11.237188+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-8@doe.test",
      "status": "active",
      "customer_id": "b1f0ae24-21c1-4a04-8bdd-af195abf3394"
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
    --url 'https://example.booqable.com/api/boomerang/users/72d8df9e-3ad8-4f6c-9d08-3c3ef40725db' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "72d8df9e-3ad8-4f6c-9d08-3c3ef40725db",
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
    "id": "72d8df9e-3ad8-4f6c-9d08-3c3ef40725db",
    "type": "users",
    "attributes": {
      "created_at": "2024-09-09T09:25:08.226085+00:00",
      "updated_at": "2024-09-09T09:25:08.279573+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-3@doe.test",
      "status": "disabled",
      "customer_id": "51656825-e356-47a5-aecc-ede6c5685d9a"
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






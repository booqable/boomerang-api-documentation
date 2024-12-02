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
`email` | **String** `readonly-after-create`<br>The email of the user
`status` | **String** `readonly`<br>One of `disabled`, `active`, `invited`, `unconfirmed`
`disabled` | **Boolean** `writeonly`<br>When a user is disabled they cannot log into their account or create orders
`customer_id` | **Uuid** `readonly-after-create`<br>Associated Customer


## Relationships
Users have the following relationships:

Name | Description
-- | --
`customer` | **[Customer](#customers)** <br>Associated Customer
`notes` | **[Notes](#notes)** <br>Associated Notes


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
      "id": "600fa552-d1b8-4b93-a987-016f9a260c96",
      "type": "users",
      "attributes": {
        "created_at": "2024-12-02T13:01:39.290766+00:00",
        "updated_at": "2024-12-02T13:01:39.290766+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-2@doe.test",
        "status": "active",
        "customer_id": "07571cc7-228d-4516-a0b6-c868a5998bdc"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=78e3f779-3ef6-4ac0-b2f2-5fba06e6031f&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "de8346fa-0903-4983-b426-fb2864013c7a",
      "type": "users",
      "attributes": {
        "created_at": "2024-12-02T13:01:38.682396+00:00",
        "updated_at": "2024-12-02T13:01:38.682396+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-1@doe.test",
        "status": "active",
        "customer_id": "78e3f779-3ef6-4ac0-b2f2-5fba06e6031f"
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
    --url 'https://example.booqable.com/api/boomerang/users/598de5b6-0faf-4790-9dbe-a2ea14777bf5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "598de5b6-0faf-4790-9dbe-a2ea14777bf5",
    "type": "users",
    "attributes": {
      "created_at": "2024-12-02T13:01:39.836217+00:00",
      "updated_at": "2024-12-02T13:01:39.836217+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-3@doe.test",
      "status": "active",
      "customer_id": "2a540981-7f1c-4f9d-a9e9-a38637db185a"
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
          "customer_id": "5ac0b346-f9c9-4644-9236-b8446400944e"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e47d5f2e-4d3f-4222-8c38-de37f195b700",
    "type": "users",
    "attributes": {
      "created_at": "2024-12-02T13:01:40.632557+00:00",
      "updated_at": "2024-12-02T13:01:40.647341+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "5ac0b346-f9c9-4644-9236-b8446400944e"
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
`data[attributes][customer_id]` | **Uuid** <br>Associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Updating a user



> How to update a user:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/users/f054306e-08c5-4aa4-93ce-a8b9291af539' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f054306e-08c5-4aa4-93ce-a8b9291af539",
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
    "id": "f054306e-08c5-4aa4-93ce-a8b9291af539",
    "type": "users",
    "attributes": {
      "created_at": "2024-12-02T13:01:41.925294+00:00",
      "updated_at": "2024-12-02T13:01:42.007752+00:00",
      "first_name": "Bobba",
      "last_name": "Doe",
      "name": "Bobba Doe",
      "email": "john-6@doe.test",
      "status": "active",
      "customer_id": "eacf3d5b-3340-4a17-9433-8ebbd79f9b38"
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
`data[attributes][customer_id]` | **Uuid** <br>Associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Enabling a user



> How to enable a user:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/users/86c0e2b5-bbd9-4eb5-ad09-8368275b61b0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "86c0e2b5-bbd9-4eb5-ad09-8368275b61b0",
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
    "id": "86c0e2b5-bbd9-4eb5-ad09-8368275b61b0",
    "type": "users",
    "attributes": {
      "created_at": "2024-12-02T13:01:42.572961+00:00",
      "updated_at": "2024-12-02T13:01:42.667926+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-7@doe.test",
      "status": "active",
      "customer_id": "c62fada1-82b8-48c0-8c6e-9ca9b8acd9ea"
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
`data[attributes][customer_id]` | **Uuid** <br>Associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Disabling a user



> How to disable a user:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/users/243512f0-9ed7-4d64-9b03-3b57542d2ae6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "243512f0-9ed7-4d64-9b03-3b57542d2ae6",
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
    "id": "243512f0-9ed7-4d64-9b03-3b57542d2ae6",
    "type": "users",
    "attributes": {
      "created_at": "2024-12-02T13:01:41.237385+00:00",
      "updated_at": "2024-12-02T13:01:41.326601+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-5@doe.test",
      "status": "disabled",
      "customer_id": "2defd6ed-8481-4c3e-9001-83c29c388e85"
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
`data[attributes][customer_id]` | **Uuid** <br>Associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






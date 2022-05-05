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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`first_name` | **String**<br>The first name of the user
`last_name` | **String**<br>The last name of the user
`name` | **String**<br>The full name of the user (first_name + last_name)
`email` | **String**<br>The email of the user
`status` | **String** `readonly`<br>One of `disabled`, `active`, `invited`, `unconfirmed`
`disabled` | **Boolean** `writeonly`<br>When a user is disabled they cannot log into their account or create orders
`customer_id` | **Uuid**<br>The associated Customer


## Relationships
Users have the following relationships:

Name | Description
- | -
`customer` | **Customers**<br>Associated Customer
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
      "id": "e8b2b5b6-e204-42d7-be77-8e1b5ca0b213",
      "type": "users",
      "attributes": {
        "created_at": "2022-05-05T12:28:55+00:00",
        "updated_at": "2022-05-05T12:28:55+00:00",
        "first_name": "Joshua",
        "last_name": "Haag",
        "name": "Joshua Haag",
        "email": "haag.joshua@williamson.io",
        "status": "active",
        "customer_id": "3b95e5c1-a6a7-47bc-aadd-736b4631211a"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/3b95e5c1-a6a7-47bc-aadd-736b4631211a"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e8b2b5b6-e204-42d7-be77-8e1b5ca0b213&filter[owner_type]=users"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to find users belonging to a customer:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=99646e9b-23ed-4da5-9594-9a6c9ac2d0dd&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6fd9173b-654b-4eb1-9d8d-8aaac2596136",
      "type": "users",
      "attributes": {
        "created_at": "2022-05-05T12:28:55+00:00",
        "updated_at": "2022-05-05T12:28:55+00:00",
        "first_name": "Gilbert",
        "last_name": "Torphy",
        "name": "Gilbert Torphy",
        "email": "gilbert.torphy@ruecker.net",
        "status": "active",
        "customer_id": "99646e9b-23ed-4da5-9594-9a6c9ac2d0dd"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/99646e9b-23ed-4da5-9594-9a6c9ac2d0dd"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6fd9173b-654b-4eb1-9d8d-8aaac2596136&filter[owner_type]=users"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/users`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,notes`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-05T12:25:37Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`first_name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`last_name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`email` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`status` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`customer_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a user



> How to fetch a user:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/users/6ee65aa2-7063-4453-9f52-857744683a04' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6ee65aa2-7063-4453-9f52-857744683a04",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-05T12:28:56+00:00",
      "updated_at": "2022-05-05T12:28:56+00:00",
      "first_name": "Juliann",
      "last_name": "Collier",
      "name": "Juliann Collier",
      "email": "collier.juliann@rodriguez.org",
      "status": "active",
      "customer_id": "dfebd81a-1022-4d04-a979-01cee1b42ed6"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/dfebd81a-1022-4d04-a979-01cee1b42ed6"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=6ee65aa2-7063-4453-9f52-857744683a04&filter[owner_type]=users"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/users/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,notes`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`


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
          "customer_id": "a6673e58-034e-431a-bf6c-c39a3496b906"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "60157bb4-3eb6-4f23-8f61-f444e091f0fb",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-05T12:28:56+00:00",
      "updated_at": "2022-05-05T12:28:56+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "a6673e58-034e-431a-bf6c-c39a3496b906"
    },
    "relationships": {
      "customer": {
        "meta": {
          "included": false
        }
      },
      "notes": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/users`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,notes`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][first_name]` | **String**<br>The first name of the user
`data[attributes][last_name]` | **String**<br>The last name of the user
`data[attributes][name]` | **String**<br>The full name of the user (first_name + last_name)
`data[attributes][email]` | **String**<br>The email of the user
`data[attributes][disabled]` | **Boolean**<br>When a user is disabled they cannot log into their account or create orders
`data[attributes][customer_id]` | **Uuid**<br>The associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Updating a user



> How to update a user:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/users/9fd56b0e-84f0-4a5a-a52f-fb60b4df1b2f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9fd56b0e-84f0-4a5a-a52f-fb60b4df1b2f",
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
    "id": "9fd56b0e-84f0-4a5a-a52f-fb60b4df1b2f",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-05T12:28:56+00:00",
      "updated_at": "2022-05-05T12:28:56+00:00",
      "first_name": "Bobba",
      "last_name": "Sporer",
      "name": "Bobba Sporer",
      "email": "sporer.twanna@sawayn-schaefer.com",
      "status": "active",
      "customer_id": "89161aff-3da7-42f5-b34d-ea3b4f50b9f2"
    },
    "relationships": {
      "customer": {
        "meta": {
          "included": false
        }
      },
      "notes": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/users/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,notes`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][first_name]` | **String**<br>The first name of the user
`data[attributes][last_name]` | **String**<br>The last name of the user
`data[attributes][name]` | **String**<br>The full name of the user (first_name + last_name)
`data[attributes][email]` | **String**<br>The email of the user
`data[attributes][disabled]` | **Boolean**<br>When a user is disabled they cannot log into their account or create orders
`data[attributes][customer_id]` | **Uuid**<br>The associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Enabling a user



> How to enable a user:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/users/9bce5662-fe0f-460b-843b-ae2be80f9727' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9bce5662-fe0f-460b-843b-ae2be80f9727",
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
    "id": "9bce5662-fe0f-460b-843b-ae2be80f9727",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-05T12:28:57+00:00",
      "updated_at": "2022-05-05T12:28:57+00:00",
      "first_name": "Ned",
      "last_name": "Block",
      "name": "Ned Block",
      "email": "ned_block@roberts-robel.co",
      "status": "active",
      "customer_id": "f3f96ea5-c68c-45f0-a621-7c51e558d04d"
    },
    "relationships": {
      "customer": {
        "meta": {
          "included": false
        }
      },
      "notes": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/users/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,notes`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][first_name]` | **String**<br>The first name of the user
`data[attributes][last_name]` | **String**<br>The last name of the user
`data[attributes][name]` | **String**<br>The full name of the user (first_name + last_name)
`data[attributes][email]` | **String**<br>The email of the user
`data[attributes][disabled]` | **Boolean**<br>When a user is disabled they cannot log into their account or create orders
`data[attributes][customer_id]` | **Uuid**<br>The associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Disabling a user



> How to disable a user:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/users/d53bd04b-0ad6-4819-884e-6db4da8c51f3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d53bd04b-0ad6-4819-884e-6db4da8c51f3",
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
    "id": "d53bd04b-0ad6-4819-884e-6db4da8c51f3",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-05T12:28:57+00:00",
      "updated_at": "2022-05-05T12:28:57+00:00",
      "first_name": "Sylvia",
      "last_name": "Greenfelder",
      "name": "Sylvia Greenfelder",
      "email": "greenfelder.sylvia@sporer.io",
      "status": "disabled",
      "customer_id": "be45baac-41a8-4ac1-904b-e442ffd6cf2f"
    },
    "relationships": {
      "customer": {
        "meta": {
          "included": false
        }
      },
      "notes": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/users/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,notes`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][first_name]` | **String**<br>The first name of the user
`data[attributes][last_name]` | **String**<br>The last name of the user
`data[attributes][name]` | **String**<br>The full name of the user (first_name + last_name)
`data[attributes][email]` | **String**<br>The email of the user
`data[attributes][disabled]` | **Boolean**<br>When a user is disabled they cannot log into their account or create orders
`data[attributes][customer_id]` | **Uuid**<br>The associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






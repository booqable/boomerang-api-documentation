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
      "id": "a3ea90be-d578-4f27-a277-e4e1434e34c3",
      "type": "users",
      "attributes": {
        "created_at": "2022-03-29T09:21:58+00:00",
        "updated_at": "2022-03-29T09:21:58+00:00",
        "first_name": "Lavonne",
        "last_name": "Larkin",
        "name": "Lavonne Larkin",
        "email": "lavonne_larkin@upton-quigley.net",
        "status": "active",
        "customer_id": "de0062bb-34f4-43a2-93b3-b291dd851c83"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/de0062bb-34f4-43a2-93b3-b291dd851c83"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a3ea90be-d578-4f27-a277-e4e1434e34c3&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=4da92419-d59a-414f-a089-6e5d28d6a133&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8bf95aef-fe12-44d0-8d64-74a7c730a99f",
      "type": "users",
      "attributes": {
        "created_at": "2022-03-29T09:21:59+00:00",
        "updated_at": "2022-03-29T09:21:59+00:00",
        "first_name": "Elisha",
        "last_name": "Rolfson",
        "name": "Elisha Rolfson",
        "email": "elisha.rolfson@robel.net",
        "status": "active",
        "customer_id": "4da92419-d59a-414f-a089-6e5d28d6a133"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/4da92419-d59a-414f-a089-6e5d28d6a133"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8bf95aef-fe12-44d0-8d64-74a7c730a99f&filter[owner_type]=users"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-29T09:19:16Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/c1c5041b-49eb-4342-9d6d-7148acbd0938' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c1c5041b-49eb-4342-9d6d-7148acbd0938",
    "type": "users",
    "attributes": {
      "created_at": "2022-03-29T09:21:59+00:00",
      "updated_at": "2022-03-29T09:21:59+00:00",
      "first_name": "Blair",
      "last_name": "Paucek",
      "name": "Blair Paucek",
      "email": "paucek_blair@runolfsson.co",
      "status": "active",
      "customer_id": "c598e2fd-2833-4b87-a76e-3766fd3c0f3b"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/c598e2fd-2833-4b87-a76e-3766fd3c0f3b"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=c1c5041b-49eb-4342-9d6d-7148acbd0938&filter[owner_type]=users"
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
          "customer_id": "bab3c68c-9fe5-455b-a7ff-1088da89d376"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4be81ee1-360f-4e48-9ae6-a20554d042f3",
    "type": "users",
    "attributes": {
      "created_at": "2022-03-29T09:21:59+00:00",
      "updated_at": "2022-03-29T09:21:59+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "bab3c68c-9fe5-455b-a7ff-1088da89d376"
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
    --url 'https://example.booqable.com/api/boomerang/users/f0736c64-629d-4e3e-9d11-23e74dca620a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f0736c64-629d-4e3e-9d11-23e74dca620a",
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
    "id": "f0736c64-629d-4e3e-9d11-23e74dca620a",
    "type": "users",
    "attributes": {
      "created_at": "2022-03-29T09:22:00+00:00",
      "updated_at": "2022-03-29T09:22:00+00:00",
      "first_name": "Bobba",
      "last_name": "Nolan",
      "name": "Bobba Nolan",
      "email": "benito_nolan@shanahan.net",
      "status": "active",
      "customer_id": "d82edff9-f78d-4053-9634-f681c4ebbf4a"
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
    --url 'https://example.booqable.com/api/boomerang/users/03e6e7c6-c874-4d7f-8292-8c1dfc887ff4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "03e6e7c6-c874-4d7f-8292-8c1dfc887ff4",
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
    "id": "03e6e7c6-c874-4d7f-8292-8c1dfc887ff4",
    "type": "users",
    "attributes": {
      "created_at": "2022-03-29T09:22:00+00:00",
      "updated_at": "2022-03-29T09:22:00+00:00",
      "first_name": "Andres",
      "last_name": "Funk",
      "name": "Andres Funk",
      "email": "funk_andres@goodwin.co",
      "status": "active",
      "customer_id": "63c372f2-467b-4fb8-a2ad-de6c93ac91cc"
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
    --url 'https://example.booqable.com/api/boomerang/users/33c852c2-42fd-447d-9f8b-3dfcfa0b93bd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "33c852c2-42fd-447d-9f8b-3dfcfa0b93bd",
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
    "id": "33c852c2-42fd-447d-9f8b-3dfcfa0b93bd",
    "type": "users",
    "attributes": {
      "created_at": "2022-03-29T09:22:00+00:00",
      "updated_at": "2022-03-29T09:22:00+00:00",
      "first_name": "Zenia",
      "last_name": "Altenwerth",
      "name": "Zenia Altenwerth",
      "email": "altenwerth.zenia@barton-hermiston.name",
      "status": "disabled",
      "customer_id": "ca9a91c9-9434-4f1b-920a-7890d7ffff01"
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






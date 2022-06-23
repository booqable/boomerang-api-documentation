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
      "id": "c06e9bc3-c905-474a-acaa-45008dd7c5b4",
      "type": "users",
      "attributes": {
        "created_at": "2022-06-23T19:03:58+00:00",
        "updated_at": "2022-06-23T19:03:58+00:00",
        "first_name": "Toshia",
        "last_name": "Dickens",
        "name": "Toshia Dickens",
        "email": "dickens_toshia@quitzon.co",
        "status": "active",
        "customer_id": "d90cefee-1427-49e9-8d4f-300bf4f050a1"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/d90cefee-1427-49e9-8d4f-300bf4f050a1"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c06e9bc3-c905-474a-acaa-45008dd7c5b4&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=e9bb6334-a638-43d9-84aa-a6d50dc04281&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0fb9ce6c-ba13-4225-89c3-9c7e33cdf3d6",
      "type": "users",
      "attributes": {
        "created_at": "2022-06-23T19:03:58+00:00",
        "updated_at": "2022-06-23T19:03:58+00:00",
        "first_name": "Evia",
        "last_name": "Conn",
        "name": "Evia Conn",
        "email": "conn.evia@hudson.info",
        "status": "active",
        "customer_id": "e9bb6334-a638-43d9-84aa-a6d50dc04281"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/e9bb6334-a638-43d9-84aa-a6d50dc04281"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0fb9ce6c-ba13-4225-89c3-9c7e33cdf3d6&filter[owner_type]=users"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-23T19:00:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/b546e02d-23e0-4e0b-9152-dfcd59696b1d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b546e02d-23e0-4e0b-9152-dfcd59696b1d",
    "type": "users",
    "attributes": {
      "created_at": "2022-06-23T19:03:59+00:00",
      "updated_at": "2022-06-23T19:03:59+00:00",
      "first_name": "Walton",
      "last_name": "Hamill",
      "name": "Walton Hamill",
      "email": "hamill_walton@kuvalis-jakubowski.org",
      "status": "active",
      "customer_id": "59733e3c-b425-4fd3-81f5-edd3f2a8deb7"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/59733e3c-b425-4fd3-81f5-edd3f2a8deb7"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=b546e02d-23e0-4e0b-9152-dfcd59696b1d&filter[owner_type]=users"
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
          "customer_id": "704b4a49-fa98-4239-9220-dde6f3098531"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "405b821d-cc2b-48d4-b2d8-b7a66dfcf3d3",
    "type": "users",
    "attributes": {
      "created_at": "2022-06-23T19:03:59+00:00",
      "updated_at": "2022-06-23T19:03:59+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "704b4a49-fa98-4239-9220-dde6f3098531"
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
    --url 'https://example.booqable.com/api/boomerang/users/a09bf124-3bcf-485e-9776-82915e1064e2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a09bf124-3bcf-485e-9776-82915e1064e2",
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
    "id": "a09bf124-3bcf-485e-9776-82915e1064e2",
    "type": "users",
    "attributes": {
      "created_at": "2022-06-23T19:04:00+00:00",
      "updated_at": "2022-06-23T19:04:00+00:00",
      "first_name": "Bobba",
      "last_name": "Hickle",
      "name": "Bobba Hickle",
      "email": "stacey.hickle@rempel.net",
      "status": "active",
      "customer_id": "38dfdc55-2f22-4e9a-a6cc-8b4ecac234a6"
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
    --url 'https://example.booqable.com/api/boomerang/users/587b711a-1ded-498b-a92d-38318e2d28c8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "587b711a-1ded-498b-a92d-38318e2d28c8",
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
    "id": "587b711a-1ded-498b-a92d-38318e2d28c8",
    "type": "users",
    "attributes": {
      "created_at": "2022-06-23T19:04:00+00:00",
      "updated_at": "2022-06-23T19:04:00+00:00",
      "first_name": "Rolland",
      "last_name": "Crooks",
      "name": "Rolland Crooks",
      "email": "rolland_crooks@heaney-orn.info",
      "status": "active",
      "customer_id": "987d3f82-8df9-45e2-a61c-add116d391d8"
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
    --url 'https://example.booqable.com/api/boomerang/users/7abb6729-5f0b-4ffb-a550-ee19ffa39756' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7abb6729-5f0b-4ffb-a550-ee19ffa39756",
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
    "id": "7abb6729-5f0b-4ffb-a550-ee19ffa39756",
    "type": "users",
    "attributes": {
      "created_at": "2022-06-23T19:04:00+00:00",
      "updated_at": "2022-06-23T19:04:00+00:00",
      "first_name": "Ardella",
      "last_name": "Hegmann",
      "name": "Ardella Hegmann",
      "email": "ardella.hegmann@russel-okeefe.org",
      "status": "disabled",
      "customer_id": "5904e634-0a16-4206-9a73-fdfb6167217c"
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






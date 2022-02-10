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
      "id": "736e062c-45db-49d1-8ceb-9b801243b435",
      "type": "users",
      "attributes": {
        "created_at": "2022-02-10T10:33:28+00:00",
        "updated_at": "2022-02-10T10:33:28+00:00",
        "first_name": "Sharilyn",
        "last_name": "Cruickshank",
        "name": "Sharilyn Cruickshank",
        "email": "sharilyn_cruickshank@champlin.com",
        "status": "active",
        "customer_id": "e06a9d25-1fbc-4d89-9e04-9a8ebfc85de5"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/e06a9d25-1fbc-4d89-9e04-9a8ebfc85de5"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=736e062c-45db-49d1-8ceb-9b801243b435&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=7b07c386-9cb7-4daf-a4f5-f774118f08d3&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d705a342-6af7-4f40-afd6-ac23b496e495",
      "type": "users",
      "attributes": {
        "created_at": "2022-02-10T10:33:28+00:00",
        "updated_at": "2022-02-10T10:33:28+00:00",
        "first_name": "Sherice",
        "last_name": "Batz",
        "name": "Sherice Batz",
        "email": "sherice.batz@ullrich.name",
        "status": "active",
        "customer_id": "7b07c386-9cb7-4daf-a4f5-f774118f08d3"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/7b07c386-9cb7-4daf-a4f5-f774118f08d3"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d705a342-6af7-4f40-afd6-ac23b496e495&filter[owner_type]=users"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-10T10:30:50Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/c57dbd84-23d8-4aeb-89b7-81146359cc90' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c57dbd84-23d8-4aeb-89b7-81146359cc90",
    "type": "users",
    "attributes": {
      "created_at": "2022-02-10T10:33:29+00:00",
      "updated_at": "2022-02-10T10:33:29+00:00",
      "first_name": "Jerry",
      "last_name": "Rodriguez",
      "name": "Jerry Rodriguez",
      "email": "jerry_rodriguez@mills.name",
      "status": "active",
      "customer_id": "2dbd6036-ead6-4682-9462-19336a8c8bf4"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/2dbd6036-ead6-4682-9462-19336a8c8bf4"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=c57dbd84-23d8-4aeb-89b7-81146359cc90&filter[owner_type]=users"
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
          "customer_id": "37128da0-e44b-46c5-8984-646ca80a373e"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "756c9df3-859a-4281-a262-bd07cb1f3535",
    "type": "users",
    "attributes": {
      "created_at": "2022-02-10T10:33:29+00:00",
      "updated_at": "2022-02-10T10:33:29+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "37128da0-e44b-46c5-8984-646ca80a373e"
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
    --url 'https://example.booqable.com/api/boomerang/users/351e249a-a33a-42ee-a1d2-b828bce9e55b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "351e249a-a33a-42ee-a1d2-b828bce9e55b",
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
    "id": "351e249a-a33a-42ee-a1d2-b828bce9e55b",
    "type": "users",
    "attributes": {
      "created_at": "2022-02-10T10:33:29+00:00",
      "updated_at": "2022-02-10T10:33:29+00:00",
      "first_name": "Bobba",
      "last_name": "Hahn",
      "name": "Bobba Hahn",
      "email": "hahn.jeniffer@huels.co",
      "status": "active",
      "customer_id": "6d414e44-c47f-43aa-bd70-86fb1cc83950"
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
    --url 'https://example.booqable.com/api/boomerang/users/601bb0eb-d30b-482d-bc4c-d91ff1cfb3be' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "601bb0eb-d30b-482d-bc4c-d91ff1cfb3be",
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
    "id": "601bb0eb-d30b-482d-bc4c-d91ff1cfb3be",
    "type": "users",
    "attributes": {
      "created_at": "2022-02-10T10:33:30+00:00",
      "updated_at": "2022-02-10T10:33:30+00:00",
      "first_name": "Amber",
      "last_name": "Jaskolski",
      "name": "Amber Jaskolski",
      "email": "jaskolski.amber@herzog-wilkinson.biz",
      "status": "active",
      "customer_id": "586e4a6b-3322-47d0-90d9-7b52b2beac80"
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
    --url 'https://example.booqable.com/api/boomerang/users/e224647f-cc64-4eaa-a67a-9ccce1957696' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e224647f-cc64-4eaa-a67a-9ccce1957696",
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
    "id": "e224647f-cc64-4eaa-a67a-9ccce1957696",
    "type": "users",
    "attributes": {
      "created_at": "2022-02-10T10:33:30+00:00",
      "updated_at": "2022-02-10T10:33:30+00:00",
      "first_name": "Lorretta",
      "last_name": "Bauch",
      "name": "Lorretta Bauch",
      "email": "bauch.lorretta@botsford-lakin.net",
      "status": "disabled",
      "customer_id": "2cdc1ec5-aa3d-4017-a9be-de51cf7cd8f6"
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






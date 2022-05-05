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
      "id": "1d951a64-1bd1-4b53-916a-eca1acdaeb1b",
      "type": "users",
      "attributes": {
        "created_at": "2022-05-05T09:15:15+00:00",
        "updated_at": "2022-05-05T09:15:15+00:00",
        "first_name": "Deadra",
        "last_name": "Hartmann",
        "name": "Deadra Hartmann",
        "email": "deadra_hartmann@cole-leuschke.com",
        "status": "active",
        "customer_id": "97aa4933-c52a-4338-9cc7-fd0fd0cd392d"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/97aa4933-c52a-4338-9cc7-fd0fd0cd392d"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=1d951a64-1bd1-4b53-916a-eca1acdaeb1b&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=e9f25744-1043-46a4-8364-1751e7084d20&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0a0f05e3-9450-4b01-b4fd-28310c5ba32e",
      "type": "users",
      "attributes": {
        "created_at": "2022-05-05T09:15:15+00:00",
        "updated_at": "2022-05-05T09:15:15+00:00",
        "first_name": "Ashly",
        "last_name": "Mertz",
        "name": "Ashly Mertz",
        "email": "mertz_ashly@harvey.io",
        "status": "active",
        "customer_id": "e9f25744-1043-46a4-8364-1751e7084d20"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/e9f25744-1043-46a4-8364-1751e7084d20"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0a0f05e3-9450-4b01-b4fd-28310c5ba32e&filter[owner_type]=users"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-05T09:12:15Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/7d5d33e4-bbcb-4262-a5bd-3b6d55d3fe4b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7d5d33e4-bbcb-4262-a5bd-3b6d55d3fe4b",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-05T09:15:16+00:00",
      "updated_at": "2022-05-05T09:15:16+00:00",
      "first_name": "Classie",
      "last_name": "Durgan",
      "name": "Classie Durgan",
      "email": "durgan_classie@beer.com",
      "status": "active",
      "customer_id": "28a790ad-8f3a-4ab7-99dc-e3851a3258b9"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/28a790ad-8f3a-4ab7-99dc-e3851a3258b9"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=7d5d33e4-bbcb-4262-a5bd-3b6d55d3fe4b&filter[owner_type]=users"
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
          "customer_id": "e3e6e4d4-cb58-465c-b8c2-3197da9a2fd8"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4898e645-0cea-4c2e-ab98-03faa512f983",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-05T09:15:16+00:00",
      "updated_at": "2022-05-05T09:15:16+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "e3e6e4d4-cb58-465c-b8c2-3197da9a2fd8"
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
    --url 'https://example.booqable.com/api/boomerang/users/a840308b-1fa7-432d-9cfe-cac97717bb82' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a840308b-1fa7-432d-9cfe-cac97717bb82",
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
    "id": "a840308b-1fa7-432d-9cfe-cac97717bb82",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-05T09:15:16+00:00",
      "updated_at": "2022-05-05T09:15:16+00:00",
      "first_name": "Bobba",
      "last_name": "Bergnaum",
      "name": "Bobba Bergnaum",
      "email": "donnetta_bergnaum@jacobi.com",
      "status": "active",
      "customer_id": "0bf901ce-a4a0-4fb5-8111-78c348bfe807"
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
    --url 'https://example.booqable.com/api/boomerang/users/05db0266-3588-44d1-a652-ca7f8695f519' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "05db0266-3588-44d1-a652-ca7f8695f519",
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
    "id": "05db0266-3588-44d1-a652-ca7f8695f519",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-05T09:15:17+00:00",
      "updated_at": "2022-05-05T09:15:17+00:00",
      "first_name": "Carolin",
      "last_name": "Emard",
      "name": "Carolin Emard",
      "email": "carolin.emard@breitenberg.co",
      "status": "active",
      "customer_id": "940afd60-3ac3-447c-b21d-38eb2bfc8e2a"
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
    --url 'https://example.booqable.com/api/boomerang/users/ec576c3f-dbc9-4287-acde-ee25d147bb35' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ec576c3f-dbc9-4287-acde-ee25d147bb35",
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
    "id": "ec576c3f-dbc9-4287-acde-ee25d147bb35",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-05T09:15:17+00:00",
      "updated_at": "2022-05-05T09:15:17+00:00",
      "first_name": "Fredric",
      "last_name": "Hermiston",
      "name": "Fredric Hermiston",
      "email": "hermiston_fredric@bruen-mayer.info",
      "status": "disabled",
      "customer_id": "45560ee2-24e6-48ce-a1dc-cd3acf61561b"
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






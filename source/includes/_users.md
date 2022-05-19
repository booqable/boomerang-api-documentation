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
      "id": "6f95bfdc-ba8a-4d7d-8f1c-6c122a3696e0",
      "type": "users",
      "attributes": {
        "created_at": "2022-05-19T14:24:44+00:00",
        "updated_at": "2022-05-19T14:24:44+00:00",
        "first_name": "Tula",
        "last_name": "Rowe",
        "name": "Tula Rowe",
        "email": "tula.rowe@wilkinson-kub.co",
        "status": "active",
        "customer_id": "b207dc1d-f74e-400a-8412-2414b2ff24a9"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/b207dc1d-f74e-400a-8412-2414b2ff24a9"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=6f95bfdc-ba8a-4d7d-8f1c-6c122a3696e0&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=b1bd3dc1-3ec9-4790-b304-a7e442d60526&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2e43c43d-fd02-4d6a-82bc-3d221788a7ef",
      "type": "users",
      "attributes": {
        "created_at": "2022-05-19T14:24:44+00:00",
        "updated_at": "2022-05-19T14:24:44+00:00",
        "first_name": "Lavette",
        "last_name": "Romaguera",
        "name": "Lavette Romaguera",
        "email": "romaguera.lavette@ryan.name",
        "status": "active",
        "customer_id": "b1bd3dc1-3ec9-4790-b304-a7e442d60526"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/b1bd3dc1-3ec9-4790-b304-a7e442d60526"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2e43c43d-fd02-4d6a-82bc-3d221788a7ef&filter[owner_type]=users"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-19T14:22:16Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/2408f459-aa23-4a7d-926e-2bb6eeb47f8f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2408f459-aa23-4a7d-926e-2bb6eeb47f8f",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-19T14:24:44+00:00",
      "updated_at": "2022-05-19T14:24:44+00:00",
      "first_name": "Barney",
      "last_name": "Satterfield",
      "name": "Barney Satterfield",
      "email": "satterfield_barney@okuneva.net",
      "status": "active",
      "customer_id": "52bab5f3-ed87-4412-b758-fc49496013b6"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/52bab5f3-ed87-4412-b758-fc49496013b6"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=2408f459-aa23-4a7d-926e-2bb6eeb47f8f&filter[owner_type]=users"
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
          "customer_id": "d2f917d0-4e15-41f9-9930-1baadb9e0b0f"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "28520589-4b57-4700-8d00-555c49bfe660",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-19T14:24:45+00:00",
      "updated_at": "2022-05-19T14:24:45+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "d2f917d0-4e15-41f9-9930-1baadb9e0b0f"
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
    --url 'https://example.booqable.com/api/boomerang/users/6abc570d-849c-45a7-8145-a1466e38aa16' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6abc570d-849c-45a7-8145-a1466e38aa16",
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
    "id": "6abc570d-849c-45a7-8145-a1466e38aa16",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-19T14:24:45+00:00",
      "updated_at": "2022-05-19T14:24:45+00:00",
      "first_name": "Bobba",
      "last_name": "Conroy",
      "name": "Bobba Conroy",
      "email": "conroy.angel@yundt.info",
      "status": "active",
      "customer_id": "f7aa44b9-0669-4008-a7de-13aef5dd2b98"
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
    --url 'https://example.booqable.com/api/boomerang/users/330ebd04-85a9-495b-b395-51dad1146b47' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "330ebd04-85a9-495b-b395-51dad1146b47",
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
    "id": "330ebd04-85a9-495b-b395-51dad1146b47",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-19T14:24:45+00:00",
      "updated_at": "2022-05-19T14:24:45+00:00",
      "first_name": "Christin",
      "last_name": "Champlin",
      "name": "Christin Champlin",
      "email": "champlin_christin@toy-aufderhar.co",
      "status": "active",
      "customer_id": "af1052ea-a778-4ec2-b538-6080a7739a9a"
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
    --url 'https://example.booqable.com/api/boomerang/users/63eef51e-4924-447a-9d1d-b20bd52b9ec7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "63eef51e-4924-447a-9d1d-b20bd52b9ec7",
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
    "id": "63eef51e-4924-447a-9d1d-b20bd52b9ec7",
    "type": "users",
    "attributes": {
      "created_at": "2022-05-19T14:24:46+00:00",
      "updated_at": "2022-05-19T14:24:46+00:00",
      "first_name": "Randolph",
      "last_name": "Lueilwitz",
      "name": "Randolph Lueilwitz",
      "email": "randolph_lueilwitz@turner-torp.org",
      "status": "disabled",
      "customer_id": "9af69aaf-5bda-44ff-ae34-79b80d45d225"
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






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
      "id": "ff201497-a82f-4605-a94d-136a4b2e99a4",
      "type": "users",
      "attributes": {
        "created_at": "2022-01-26T14:25:54+00:00",
        "updated_at": "2022-01-26T14:25:54+00:00",
        "first_name": "Dean",
        "last_name": "Veum",
        "name": "Dean Veum",
        "email": "veum_dean@carroll.biz",
        "status": "active",
        "customer_id": "73984d0f-fd15-4f30-86f7-766ae340dde2"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/73984d0f-fd15-4f30-86f7-766ae340dde2"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=ff201497-a82f-4605-a94d-136a4b2e99a4&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=3b9abdb7-6dfd-4bff-9ca2-75b616f4a494&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f5fdedd1-7a6e-4ecc-96ec-7da5317961b2",
      "type": "users",
      "attributes": {
        "created_at": "2022-01-26T14:25:54+00:00",
        "updated_at": "2022-01-26T14:25:54+00:00",
        "first_name": "Buford",
        "last_name": "Brekke",
        "name": "Buford Brekke",
        "email": "buford.brekke@rau-flatley.io",
        "status": "active",
        "customer_id": "3b9abdb7-6dfd-4bff-9ca2-75b616f4a494"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/3b9abdb7-6dfd-4bff-9ca2-75b616f4a494"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=f5fdedd1-7a6e-4ecc-96ec-7da5317961b2&filter[owner_type]=users"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-26T14:23:27Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/7ca00f79-b8ae-4ec9-a7f8-b8c16ffbd6b6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7ca00f79-b8ae-4ec9-a7f8-b8c16ffbd6b6",
    "type": "users",
    "attributes": {
      "created_at": "2022-01-26T14:25:55+00:00",
      "updated_at": "2022-01-26T14:25:55+00:00",
      "first_name": "Ronald",
      "last_name": "Schuppe",
      "name": "Ronald Schuppe",
      "email": "ronald_schuppe@franecki.biz",
      "status": "active",
      "customer_id": "066021c7-8a17-466a-886b-af3ee2fca3c2"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/066021c7-8a17-466a-886b-af3ee2fca3c2"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=7ca00f79-b8ae-4ec9-a7f8-b8c16ffbd6b6&filter[owner_type]=users"
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
          "customer_id": "60080df2-1472-450e-bb3b-7ab6fa157915"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "075522d3-31f9-4a9f-84c9-ce2e3d254755",
    "type": "users",
    "attributes": {
      "created_at": "2022-01-26T14:25:55+00:00",
      "updated_at": "2022-01-26T14:25:55+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "60080df2-1472-450e-bb3b-7ab6fa157915"
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
    --url 'https://example.booqable.com/api/boomerang/users/3af7655b-8ec9-41b3-88e1-23e81403054b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3af7655b-8ec9-41b3-88e1-23e81403054b",
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
    "id": "3af7655b-8ec9-41b3-88e1-23e81403054b",
    "type": "users",
    "attributes": {
      "created_at": "2022-01-26T14:25:55+00:00",
      "updated_at": "2022-01-26T14:25:56+00:00",
      "first_name": "Bobba",
      "last_name": "Swaniawski",
      "name": "Bobba Swaniawski",
      "email": "claudio_swaniawski@monahan-hills.com",
      "status": "active",
      "customer_id": "92decc3a-2b7b-4fb8-bc07-9461446e895f"
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
    --url 'https://example.booqable.com/api/boomerang/users/c0784d66-bf74-47e1-ade9-dae3648d82c7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c0784d66-bf74-47e1-ade9-dae3648d82c7",
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
    "id": "c0784d66-bf74-47e1-ade9-dae3648d82c7",
    "type": "users",
    "attributes": {
      "created_at": "2022-01-26T14:25:56+00:00",
      "updated_at": "2022-01-26T14:25:56+00:00",
      "first_name": "Kellie",
      "last_name": "O'Keefe",
      "name": "Kellie O'Keefe",
      "email": "o.kellie.keefe@torphy-heathcote.io",
      "status": "active",
      "customer_id": "70f232ab-ffd2-4185-97a6-802f01eb4e64"
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
    --url 'https://example.booqable.com/api/boomerang/users/26f2e226-7114-4417-863a-154b3fb0cc96' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "26f2e226-7114-4417-863a-154b3fb0cc96",
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
    "id": "26f2e226-7114-4417-863a-154b3fb0cc96",
    "type": "users",
    "attributes": {
      "created_at": "2022-01-26T14:25:56+00:00",
      "updated_at": "2022-01-26T14:25:56+00:00",
      "first_name": "Genoveva",
      "last_name": "Jacobi",
      "name": "Genoveva Jacobi",
      "email": "jacobi_genoveva@wyman.com",
      "status": "disabled",
      "customer_id": "31e9bbe2-5689-4bc0-8505-d0b5028520d1"
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






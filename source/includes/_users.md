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
      "id": "836c6b8d-b08c-4761-bd28-31629abaa407",
      "type": "users",
      "attributes": {
        "created_at": "2022-01-12T10:57:10+00:00",
        "updated_at": "2022-01-12T10:57:10+00:00",
        "first_name": "Kermit",
        "last_name": "Wolff",
        "name": "Kermit Wolff",
        "email": "wolff.kermit@lynch.com",
        "status": "active",
        "customer_id": "1465b8ab-4be3-43d2-bec1-e2eff93eaa76"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/1465b8ab-4be3-43d2-bec1-e2eff93eaa76"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=836c6b8d-b08c-4761-bd28-31629abaa407&filter[owner_type]=users"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/users?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/users?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/users?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to find users belonging to a customer:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=0be6e545-c851-4b39-9fe7-18a4d9c7e9f2&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c9062d9f-5a63-4338-92d0-2a8653ffa495",
      "type": "users",
      "attributes": {
        "created_at": "2022-01-12T10:57:10+00:00",
        "updated_at": "2022-01-12T10:57:10+00:00",
        "first_name": "Isreal",
        "last_name": "Fisher",
        "name": "Isreal Fisher",
        "email": "isreal.fisher@waters-lueilwitz.net",
        "status": "active",
        "customer_id": "0be6e545-c851-4b39-9fe7-18a4d9c7e9f2"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/0be6e545-c851-4b39-9fe7-18a4d9c7e9f2"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c9062d9f-5a63-4338-92d0-2a8653ffa495&filter[owner_type]=users"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/users?filter%5Bcustomer_id%5D=0be6e545-c851-4b39-9fe7-18a4d9c7e9f2&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/users?filter%5Bcustomer_id%5D=0be6e545-c851-4b39-9fe7-18a4d9c7e9f2&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/users?filter%5Bcustomer_id%5D=0be6e545-c851-4b39-9fe7-18a4d9c7e9f2&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-12T10:54:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/40e2165f-c48e-4bb1-96e1-c571265fd0eb' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "40e2165f-c48e-4bb1-96e1-c571265fd0eb",
    "type": "users",
    "attributes": {
      "created_at": "2022-01-12T10:57:10+00:00",
      "updated_at": "2022-01-12T10:57:10+00:00",
      "first_name": "Harlan",
      "last_name": "Yundt",
      "name": "Harlan Yundt",
      "email": "yundt.harlan@ledner-mills.com",
      "status": "active",
      "customer_id": "7540c6ef-8cd5-4f8c-89b7-2a30fceaacf5"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/7540c6ef-8cd5-4f8c-89b7-2a30fceaacf5"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=40e2165f-c48e-4bb1-96e1-c571265fd0eb&filter[owner_type]=users"
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
          "customer_id": "c5df335d-4d7e-4d82-b072-ce11f261b160"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1cc5c62d-9898-465e-bf4d-c4bb278781da",
    "type": "users",
    "attributes": {
      "created_at": "2022-01-12T10:57:11+00:00",
      "updated_at": "2022-01-12T10:57:11+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "c5df335d-4d7e-4d82-b072-ce11f261b160"
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
  "links": {
    "self": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=c5df335d-4d7e-4d82-b072-ce11f261b160&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=c5df335d-4d7e-4d82-b072-ce11f261b160&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=c5df335d-4d7e-4d82-b072-ce11f261b160&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/users/c9ce23d3-273d-4662-ba34-bd695b704ad7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c9ce23d3-273d-4662-ba34-bd695b704ad7",
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
    "id": "c9ce23d3-273d-4662-ba34-bd695b704ad7",
    "type": "users",
    "attributes": {
      "created_at": "2022-01-12T10:57:11+00:00",
      "updated_at": "2022-01-12T10:57:11+00:00",
      "first_name": "Bobba",
      "last_name": "Braun",
      "name": "Bobba Braun",
      "email": "lisette_braun@runte.name",
      "status": "active",
      "customer_id": "4f4ae687-3a87-4ae4-aa05-957e58378f7a"
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
    --url 'https://example.booqable.com/api/boomerang/users/fd26b929-625e-4657-ac13-bae43e5c3516' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fd26b929-625e-4657-ac13-bae43e5c3516",
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
    "id": "fd26b929-625e-4657-ac13-bae43e5c3516",
    "type": "users",
    "attributes": {
      "created_at": "2022-01-12T10:57:11+00:00",
      "updated_at": "2022-01-12T10:57:11+00:00",
      "first_name": "Ray",
      "last_name": "Larson",
      "name": "Ray Larson",
      "email": "larson_ray@zieme-dickinson.co",
      "status": "active",
      "customer_id": "860ed505-fed5-47cc-b89f-dfc11daded81"
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
    --url 'https://example.booqable.com/api/boomerang/users/e3a9129f-f50d-441e-a980-ca39d7ef4c49' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e3a9129f-f50d-441e-a980-ca39d7ef4c49",
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
    "id": "e3a9129f-f50d-441e-a980-ca39d7ef4c49",
    "type": "users",
    "attributes": {
      "created_at": "2022-01-12T10:57:12+00:00",
      "updated_at": "2022-01-12T10:57:12+00:00",
      "first_name": "Claretha",
      "last_name": "Kunde",
      "name": "Claretha Kunde",
      "email": "kunde_claretha@wunsch-klocko.name",
      "status": "disabled",
      "customer_id": "651d8de6-adaa-46aa-9b17-e8fc778a3e6b"
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






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
      "id": "8ab2d831-71d4-4526-b23d-98d9584c5d80",
      "type": "users",
      "attributes": {
        "created_at": "2023-03-01T17:41:02+00:00",
        "updated_at": "2023-03-01T17:41:02+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-1@doe.test",
        "status": "active",
        "customer_id": "84c4c706-1428-433a-84d4-0ce35b9721de"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/84c4c706-1428-433a-84d4-0ce35b9721de"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=8ab2d831-71d4-4526-b23d-98d9584c5d80&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=20f9102a-66b2-4ac6-8daa-25e054c0f015&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e36e2ee5-2e45-4113-967d-377a29e683b3",
      "type": "users",
      "attributes": {
        "created_at": "2023-03-01T17:41:02+00:00",
        "updated_at": "2023-03-01T17:41:02+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-2@doe.test",
        "status": "active",
        "customer_id": "20f9102a-66b2-4ac6-8daa-25e054c0f015"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/20f9102a-66b2-4ac6-8daa-25e054c0f015"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e36e2ee5-2e45-4113-967d-377a29e683b3&filter[owner_type]=users"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=customer,notes`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T17:36:22Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
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
- | -
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a user



> How to fetch a user:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/users/f29afa8b-358c-40fa-9e35-48da385733ff' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f29afa8b-358c-40fa-9e35-48da385733ff",
    "type": "users",
    "attributes": {
      "created_at": "2023-03-01T17:41:03+00:00",
      "updated_at": "2023-03-01T17:41:03+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-3@doe.test",
      "status": "active",
      "customer_id": "3e529740-bbcc-40ba-8a70-86539d83af11"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/3e529740-bbcc-40ba-8a70-86539d83af11"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=f29afa8b-358c-40fa-9e35-48da385733ff&filter[owner_type]=users"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=customer,notes`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`


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
          "customer_id": "cdf7caf5-5cb4-4dea-a5cd-33af049c535a"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "dff26df8-4720-4b78-a957-2d7afd60a754",
    "type": "users",
    "attributes": {
      "created_at": "2023-03-01T17:41:03+00:00",
      "updated_at": "2023-03-01T17:41:03+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "cdf7caf5-5cb4-4dea-a5cd-33af049c535a"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=customer,notes`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/users/948cb3ad-2d8b-4e3b-960f-0191187d02f7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "948cb3ad-2d8b-4e3b-960f-0191187d02f7",
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
    "id": "948cb3ad-2d8b-4e3b-960f-0191187d02f7",
    "type": "users",
    "attributes": {
      "created_at": "2023-03-01T17:41:03+00:00",
      "updated_at": "2023-03-01T17:41:04+00:00",
      "first_name": "Bobba",
      "last_name": "Doe",
      "name": "Bobba Doe",
      "email": "john-5@doe.test",
      "status": "active",
      "customer_id": "2fdd975b-59ba-4314-bda9-2faca902fadf"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=customer,notes`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/users/a8da893a-2de1-4df6-8822-e138e7e1a8ed' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a8da893a-2de1-4df6-8822-e138e7e1a8ed",
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
    "id": "a8da893a-2de1-4df6-8822-e138e7e1a8ed",
    "type": "users",
    "attributes": {
      "created_at": "2023-03-01T17:41:04+00:00",
      "updated_at": "2023-03-01T17:41:04+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-6@doe.test",
      "status": "active",
      "customer_id": "0a47d840-01be-47e1-a548-ec5be95bf338"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=customer,notes`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/users/9d2275b4-3030-43c4-93ba-a6b47c1bf247' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9d2275b4-3030-43c4-93ba-a6b47c1bf247",
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
    "id": "9d2275b4-3030-43c4-93ba-a6b47c1bf247",
    "type": "users",
    "attributes": {
      "created_at": "2023-03-01T17:41:04+00:00",
      "updated_at": "2023-03-01T17:41:04+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-7@doe.test",
      "status": "disabled",
      "customer_id": "a75a8ccb-d6d8-4e1e-8a09-75bccc566e74"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=customer,notes`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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






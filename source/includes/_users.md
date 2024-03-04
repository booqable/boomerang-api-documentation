# Users

Users can be used to log into the web shop. They are useful for exposing your shop to a limited audience or verifiying that a customers can actually be reached via an email.

A user always belongs to a Customer. A customer can have multiple users. This is relevant for companies where multiple people are allowed to book orders in the name of that company.
Because of this, a user should always be an actual person, not a legal person.

Depending on the setting in your Booqable account, creating a user can actually mean that you're inviting the user. In that case, the user still needs to confirm their email and set a password before the account is active. (See *status*)

## Endpoints
`PUT /api/boomerang/users/{id}`

`POST /api/boomerang/users`

`GET /api/boomerang/users`

`GET /api/boomerang/users/{id}`

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
`email` | **String** <br>The email of the user
`status` | **String** `readonly`<br>One of `disabled`, `active`, `invited`, `unconfirmed`
`disabled` | **Boolean** `writeonly`<br>When a user is disabled they cannot log into their account or create orders
`customer_id` | **Uuid** <br>The associated Customer


## Relationships
Users have the following relationships:

Name | Description
-- | --
`customer` | **Customers**<br>Associated Customer
`notes` | **Notes** `readonly`<br>Associated Notes


## Disabling a user



> How to disable a user:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/users/227406da-012b-44b2-a2cc-4a6a79ae6be1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "227406da-012b-44b2-a2cc-4a6a79ae6be1",
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
    "id": "227406da-012b-44b2-a2cc-4a6a79ae6be1",
    "type": "users",
    "attributes": {
      "created_at": "2024-03-04T09:13:37+00:00",
      "updated_at": "2024-03-04T09:13:37+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-1@doe.test",
      "status": "disabled",
      "customer_id": "9dc19592-83b8-47c0-ac07-b4edf29844db"
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
    --url 'https://example.booqable.com/api/boomerang/users/1add98d2-ba1d-40cc-aa39-6efef53f689b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1add98d2-ba1d-40cc-aa39-6efef53f689b",
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
    "id": "1add98d2-ba1d-40cc-aa39-6efef53f689b",
    "type": "users",
    "attributes": {
      "created_at": "2024-03-04T09:13:38+00:00",
      "updated_at": "2024-03-04T09:13:38+00:00",
      "first_name": "Bobba",
      "last_name": "Doe",
      "name": "Bobba Doe",
      "email": "john-2@doe.test",
      "status": "active",
      "customer_id": "8c980a48-22e0-4cd8-98cc-2b5c124df6c8"
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
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer


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
          "customer_id": "ad2a5892-c28b-4750-8036-7253002768ff"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c43160f3-c4c9-4b64-a6f6-8e8fdcb75cb2",
    "type": "users",
    "attributes": {
      "created_at": "2024-03-04T09:13:39+00:00",
      "updated_at": "2024-03-04T09:13:40+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "ad2a5892-c28b-4750-8036-7253002768ff"
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
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Listing users



> How to find users belonging to a customer:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=bcfe1c3e-3e5e-41c0-b712-2dec4ad032ce&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "692ddd27-3710-4acf-af6c-acb0cc8c0f3e",
      "type": "users",
      "attributes": {
        "created_at": "2024-03-04T09:13:40+00:00",
        "updated_at": "2024-03-04T09:13:40+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-4@doe.test",
        "status": "active",
        "customer_id": "bcfe1c3e-3e5e-41c0-b712-2dec4ad032ce"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/bcfe1c3e-3e5e-41c0-b712-2dec4ad032ce"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=692ddd27-3710-4acf-af6c-acb0cc8c0f3e&filter[owner_type]=users"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


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
      "id": "79965af5-5ddc-4d8d-9663-420808a62e4e",
      "type": "users",
      "attributes": {
        "created_at": "2024-03-04T09:13:41+00:00",
        "updated_at": "2024-03-04T09:13:41+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-5@doe.test",
        "status": "active",
        "customer_id": "175c8e01-9fb1-4d0d-bf38-5af1cead171d"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/175c8e01-9fb1-4d0d-bf38-5af1cead171d"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=79965af5-5ddc-4d8d-9663-420808a62e4e&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users/57be68de-7625-4a75-988a-7023736fec65' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "57be68de-7625-4a75-988a-7023736fec65",
    "type": "users",
    "attributes": {
      "created_at": "2024-03-04T09:13:42+00:00",
      "updated_at": "2024-03-04T09:13:42+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-6@doe.test",
      "status": "active",
      "customer_id": "92420b7e-0c5d-42f0-9c95-231db954ad47"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/92420b7e-0c5d-42f0-9c95-231db954ad47"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=57be68de-7625-4a75-988a-7023736fec65&filter[owner_type]=users"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=customer,disabled_by,notes`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[users]=created_at,updated_at,first_name`


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Enabling a user



> How to enable a user:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/users/d652d45f-e618-4973-ad3e-26b3a35e7ea9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d652d45f-e618-4973-ad3e-26b3a35e7ea9",
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
    "id": "d652d45f-e618-4973-ad3e-26b3a35e7ea9",
    "type": "users",
    "attributes": {
      "created_at": "2024-03-04T09:13:42+00:00",
      "updated_at": "2024-03-04T09:13:42+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-7@doe.test",
      "status": "active",
      "customer_id": "83c4fc95-2320-4e9d-ba47-513970189c88"
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
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






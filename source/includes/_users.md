# Users

Users can be used to log into the web shop. They are useful for exposing your shop to a limited audience or verifiying that a customers can actually be reached via an email.

A user always belongs to a Customer. A customer can have multiple users. This is relevant for companies where multiple people are allowed to book orders in the name of that company.
Because of this, a user should always be an actual person, not a legal person.

Depending on the setting in your Booqable account, creating a user can actually mean that you're inviting the user. In that case, the user still needs to confirm their email and set a password before the account is active. (See *status*)

## Endpoints
`PUT /api/boomerang/users/{id}`

`POST /api/boomerang/users`

`GET /api/boomerang/users/{id}`

`GET /api/boomerang/users`

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
    --url 'https://example.booqable.com/api/boomerang/users/9fe2ba69-a492-443e-a087-e843c0af372e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9fe2ba69-a492-443e-a087-e843c0af372e",
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
    "id": "9fe2ba69-a492-443e-a087-e843c0af372e",
    "type": "users",
    "attributes": {
      "created_at": "2024-05-06T09:23:30+00:00",
      "updated_at": "2024-05-06T09:23:30+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-2@doe.test",
      "status": "disabled",
      "customer_id": "45ee187d-779f-4734-8def-9bf835e2e6b0"
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
          "customer_id": "00c7ad17-afa3-4c19-9439-984edb32f442"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "30885471-4725-46f8-af7d-842d9947bae9",
    "type": "users",
    "attributes": {
      "created_at": "2024-05-06T09:23:30+00:00",
      "updated_at": "2024-05-06T09:23:30+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "00c7ad17-afa3-4c19-9439-984edb32f442"
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






## Enabling a user



> How to enable a user:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/users/905717ad-5311-4fba-81ee-699a67157221' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "905717ad-5311-4fba-81ee-699a67157221",
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
    "id": "905717ad-5311-4fba-81ee-699a67157221",
    "type": "users",
    "attributes": {
      "created_at": "2024-05-06T09:23:31+00:00",
      "updated_at": "2024-05-06T09:23:31+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-4@doe.test",
      "status": "active",
      "customer_id": "8932c41f-6da1-4d53-b689-61dafc799b3e"
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






## Fetching a user



> How to fetch a user:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/users/f0b56fcf-1b58-41aa-a7a2-f8033383c3c6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f0b56fcf-1b58-41aa-a7a2-f8033383c3c6",
    "type": "users",
    "attributes": {
      "created_at": "2024-05-06T09:23:32+00:00",
      "updated_at": "2024-05-06T09:23:32+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-5@doe.test",
      "status": "active",
      "customer_id": "6b740263-39a7-47ce-be14-f04ffa376acc"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/6b740263-39a7-47ce-be14-f04ffa376acc"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=f0b56fcf-1b58-41aa-a7a2-f8033383c3c6&filter[owner_type]=users"
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
      "id": "201119e3-df6c-4cf8-872d-00a90b2b046e",
      "type": "users",
      "attributes": {
        "created_at": "2024-05-06T09:23:32+00:00",
        "updated_at": "2024-05-06T09:23:32+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-6@doe.test",
        "status": "active",
        "customer_id": "44583339-e95b-4dca-bb6e-a2908fab774e"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/44583339-e95b-4dca-bb6e-a2908fab774e"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=201119e3-df6c-4cf8-872d-00a90b2b046e&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=06e12b88-cf7c-477b-91f6-71d45dbe189e&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e8f94542-1908-4008-93fa-a7db03d466ef",
      "type": "users",
      "attributes": {
        "created_at": "2024-05-06T09:23:33+00:00",
        "updated_at": "2024-05-06T09:23:33+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-7@doe.test",
        "status": "active",
        "customer_id": "06e12b88-cf7c-477b-91f6-71d45dbe189e"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/06e12b88-cf7c-477b-91f6-71d45dbe189e"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e8f94542-1908-4008-93fa-a7db03d466ef&filter[owner_type]=users"
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
## Updating a user



> How to update a user:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/users/9f1f6958-4a1d-4c98-8079-652a6c7348ee' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9f1f6958-4a1d-4c98-8079-652a6c7348ee",
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
    "id": "9f1f6958-4a1d-4c98-8079-652a6c7348ee",
    "type": "users",
    "attributes": {
      "created_at": "2024-05-06T09:23:33+00:00",
      "updated_at": "2024-05-06T09:23:33+00:00",
      "first_name": "Bobba",
      "last_name": "Doe",
      "name": "Bobba Doe",
      "email": "john-8@doe.test",
      "status": "active",
      "customer_id": "e19ecbac-4e83-4173-a7ee-0f1869c14325"
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






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
      "id": "13196751-027d-45bb-b276-4125340bb4cc",
      "type": "users",
      "attributes": {
        "created_at": "2022-11-16T14:26:26+00:00",
        "updated_at": "2022-11-16T14:26:26+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-1@doe.test",
        "status": "active",
        "customer_id": "5ca72585-85e8-4acf-8802-e4ba1d155681"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/5ca72585-85e8-4acf-8802-e4ba1d155681"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=13196751-027d-45bb-b276-4125340bb4cc&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=ef2137cd-bd56-42d1-a684-3a5ff827f74c&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2bea8a5e-2b80-4168-814b-294675c57b7a",
      "type": "users",
      "attributes": {
        "created_at": "2022-11-16T14:26:26+00:00",
        "updated_at": "2022-11-16T14:26:26+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-2@doe.test",
        "status": "active",
        "customer_id": "ef2137cd-bd56-42d1-a684-3a5ff827f74c"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/ef2137cd-bd56-42d1-a684-3a5ff827f74c"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=2bea8a5e-2b80-4168-814b-294675c57b7a&filter[owner_type]=users"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-16T14:21:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/60d0ddc3-90c8-43fd-8286-ef5caca3faaa' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "60d0ddc3-90c8-43fd-8286-ef5caca3faaa",
    "type": "users",
    "attributes": {
      "created_at": "2022-11-16T14:26:26+00:00",
      "updated_at": "2022-11-16T14:26:26+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-3@doe.test",
      "status": "active",
      "customer_id": "9aaf0339-10d0-468d-90c5-e026ffa55434"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/9aaf0339-10d0-468d-90c5-e026ffa55434"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=60d0ddc3-90c8-43fd-8286-ef5caca3faaa&filter[owner_type]=users"
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
          "customer_id": "426ea35d-3a75-40da-b63e-2a083bf6db45"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "75bbbd61-511a-45bb-910a-1e79820bc4cb",
    "type": "users",
    "attributes": {
      "created_at": "2022-11-16T14:26:27+00:00",
      "updated_at": "2022-11-16T14:26:27+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "426ea35d-3a75-40da-b63e-2a083bf6db45"
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
    --url 'https://example.booqable.com/api/boomerang/users/16ffde3f-5003-4331-afd5-89f397d65f41' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "16ffde3f-5003-4331-afd5-89f397d65f41",
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
    "id": "16ffde3f-5003-4331-afd5-89f397d65f41",
    "type": "users",
    "attributes": {
      "created_at": "2022-11-16T14:26:27+00:00",
      "updated_at": "2022-11-16T14:26:27+00:00",
      "first_name": "Bobba",
      "last_name": "Doe",
      "name": "Bobba Doe",
      "email": "john-5@doe.test",
      "status": "active",
      "customer_id": "9804f671-a1b1-4e5a-a6db-b0d23fa36b68"
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
    --url 'https://example.booqable.com/api/boomerang/users/766200ec-5f5a-42b6-a552-72a5d282e24e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "766200ec-5f5a-42b6-a552-72a5d282e24e",
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
    "id": "766200ec-5f5a-42b6-a552-72a5d282e24e",
    "type": "users",
    "attributes": {
      "created_at": "2022-11-16T14:26:28+00:00",
      "updated_at": "2022-11-16T14:26:28+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-6@doe.test",
      "status": "active",
      "customer_id": "550c80b9-ea48-43d1-b730-41084cc17828"
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
    --url 'https://example.booqable.com/api/boomerang/users/b50097c1-b4af-451b-a4f3-80026f1800fd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b50097c1-b4af-451b-a4f3-80026f1800fd",
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
    "id": "b50097c1-b4af-451b-a4f3-80026f1800fd",
    "type": "users",
    "attributes": {
      "created_at": "2022-11-16T14:26:28+00:00",
      "updated_at": "2022-11-16T14:26:28+00:00",
      "first_name": "John",
      "last_name": "Doe",
      "name": "John Doe",
      "email": "john-7@doe.test",
      "status": "disabled",
      "customer_id": "74a5558f-ac39-4ca7-9a8b-ad5ecc8f2bc8"
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






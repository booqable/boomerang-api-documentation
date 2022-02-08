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
      "id": "34ed4a83-c6b5-4bb3-a891-059277123c4a",
      "type": "users",
      "attributes": {
        "created_at": "2022-02-08T09:14:57+00:00",
        "updated_at": "2022-02-08T09:14:57+00:00",
        "first_name": "Isaura",
        "last_name": "Orn",
        "name": "Isaura Orn",
        "email": "isaura_orn@lehner.biz",
        "status": "active",
        "customer_id": "9f1b1fe7-1626-4bb2-95cb-2034008ced03"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/9f1b1fe7-1626-4bb2-95cb-2034008ced03"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=34ed4a83-c6b5-4bb3-a891-059277123c4a&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=78e33589-e9ef-4985-8f3d-bd886e46f27b&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3b0c032f-5b28-4d6e-8ec6-c9c213ee9e3f",
      "type": "users",
      "attributes": {
        "created_at": "2022-02-08T09:14:57+00:00",
        "updated_at": "2022-02-08T09:14:57+00:00",
        "first_name": "Arnulfo",
        "last_name": "Pollich",
        "name": "Arnulfo Pollich",
        "email": "arnulfo.pollich@crist-white.co",
        "status": "active",
        "customer_id": "78e33589-e9ef-4985-8f3d-bd886e46f27b"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/78e33589-e9ef-4985-8f3d-bd886e46f27b"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3b0c032f-5b28-4d6e-8ec6-c9c213ee9e3f&filter[owner_type]=users"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-08T09:12:26Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/24082b63-dd85-40a8-930f-bc952f7ba05e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "24082b63-dd85-40a8-930f-bc952f7ba05e",
    "type": "users",
    "attributes": {
      "created_at": "2022-02-08T09:14:57+00:00",
      "updated_at": "2022-02-08T09:14:57+00:00",
      "first_name": "Phyllis",
      "last_name": "Lindgren",
      "name": "Phyllis Lindgren",
      "email": "phyllis_lindgren@rath.co",
      "status": "active",
      "customer_id": "bf602eb5-53ad-4e5b-b528-c914a5060ed9"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/bf602eb5-53ad-4e5b-b528-c914a5060ed9"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=24082b63-dd85-40a8-930f-bc952f7ba05e&filter[owner_type]=users"
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
          "customer_id": "d091f7b5-e546-4972-82eb-8e2c249b03fe"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e2ca1cc1-adad-43cc-80b1-550a290d5ce7",
    "type": "users",
    "attributes": {
      "created_at": "2022-02-08T09:14:58+00:00",
      "updated_at": "2022-02-08T09:14:58+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "d091f7b5-e546-4972-82eb-8e2c249b03fe"
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
    --url 'https://example.booqable.com/api/boomerang/users/a92bf244-a0d7-41c3-9b87-9bedd1502995' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a92bf244-a0d7-41c3-9b87-9bedd1502995",
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
    "id": "a92bf244-a0d7-41c3-9b87-9bedd1502995",
    "type": "users",
    "attributes": {
      "created_at": "2022-02-08T09:14:58+00:00",
      "updated_at": "2022-02-08T09:14:58+00:00",
      "first_name": "Bobba",
      "last_name": "Reynolds",
      "name": "Bobba Reynolds",
      "email": "sacha_reynolds@reichel-mclaughlin.name",
      "status": "active",
      "customer_id": "94f9660e-a3b7-45c6-a118-0d96f9178e17"
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
    --url 'https://example.booqable.com/api/boomerang/users/97e24139-5ed0-4e87-ac46-c1b5b8d0311d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "97e24139-5ed0-4e87-ac46-c1b5b8d0311d",
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
    "id": "97e24139-5ed0-4e87-ac46-c1b5b8d0311d",
    "type": "users",
    "attributes": {
      "created_at": "2022-02-08T09:14:58+00:00",
      "updated_at": "2022-02-08T09:14:58+00:00",
      "first_name": "Hyon",
      "last_name": "Wisozk",
      "name": "Hyon Wisozk",
      "email": "hyon.wisozk@schowalter.net",
      "status": "active",
      "customer_id": "99b91e37-7f5f-42bb-aadd-8bdec35b959b"
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
    --url 'https://example.booqable.com/api/boomerang/users/e01f7612-a059-49f1-b916-10f21aea003b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e01f7612-a059-49f1-b916-10f21aea003b",
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
    "id": "e01f7612-a059-49f1-b916-10f21aea003b",
    "type": "users",
    "attributes": {
      "created_at": "2022-02-08T09:14:58+00:00",
      "updated_at": "2022-02-08T09:14:58+00:00",
      "first_name": "Helena",
      "last_name": "Shanahan",
      "name": "Helena Shanahan",
      "email": "shanahan_helena@hayes.org",
      "status": "disabled",
      "customer_id": "4d53b1b1-a6a4-45a2-a30d-d2c79b00882e"
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






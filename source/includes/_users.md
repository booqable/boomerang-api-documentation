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
      "id": "3fc1641c-1886-4efc-b6c8-a88193f7a443",
      "type": "users",
      "attributes": {
        "created_at": "2022-04-08T17:53:44+00:00",
        "updated_at": "2022-04-08T17:53:44+00:00",
        "first_name": "Glennis",
        "last_name": "Russel",
        "name": "Glennis Russel",
        "email": "glennis.russel@ankunding-franecki.io",
        "status": "active",
        "customer_id": "a6797127-4b21-4aae-bd11-e3f6b37c1095"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/a6797127-4b21-4aae-bd11-e3f6b37c1095"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=3fc1641c-1886-4efc-b6c8-a88193f7a443&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=134810b7-8831-44e9-aa49-c3e44f8dc489&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "64af4fa1-8ff2-4630-9572-d3024e9c627e",
      "type": "users",
      "attributes": {
        "created_at": "2022-04-08T17:53:44+00:00",
        "updated_at": "2022-04-08T17:53:44+00:00",
        "first_name": "Cesar",
        "last_name": "Ward",
        "name": "Cesar Ward",
        "email": "ward.cesar@hayes-emmerich.org",
        "status": "active",
        "customer_id": "134810b7-8831-44e9-aa49-c3e44f8dc489"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/134810b7-8831-44e9-aa49-c3e44f8dc489"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=64af4fa1-8ff2-4630-9572-d3024e9c627e&filter[owner_type]=users"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T17:51:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/4db96f9a-c368-47ec-993b-4a38abcbf4cc' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4db96f9a-c368-47ec-993b-4a38abcbf4cc",
    "type": "users",
    "attributes": {
      "created_at": "2022-04-08T17:53:44+00:00",
      "updated_at": "2022-04-08T17:53:44+00:00",
      "first_name": "Tyra",
      "last_name": "Kessler",
      "name": "Tyra Kessler",
      "email": "tyra_kessler@boyle-gutmann.biz",
      "status": "active",
      "customer_id": "0db6ae00-6997-4d22-93ac-a4e23a410f1c"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/0db6ae00-6997-4d22-93ac-a4e23a410f1c"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=4db96f9a-c368-47ec-993b-4a38abcbf4cc&filter[owner_type]=users"
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
          "customer_id": "9c2f22cb-038f-4e01-a26b-19ea676d2564"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b910ec0f-4bba-443d-8a4c-63146b1edcd9",
    "type": "users",
    "attributes": {
      "created_at": "2022-04-08T17:53:45+00:00",
      "updated_at": "2022-04-08T17:53:45+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "9c2f22cb-038f-4e01-a26b-19ea676d2564"
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
    --url 'https://example.booqable.com/api/boomerang/users/4db2a985-5a44-4634-aced-ec962621a05e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4db2a985-5a44-4634-aced-ec962621a05e",
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
    "id": "4db2a985-5a44-4634-aced-ec962621a05e",
    "type": "users",
    "attributes": {
      "created_at": "2022-04-08T17:53:45+00:00",
      "updated_at": "2022-04-08T17:53:45+00:00",
      "first_name": "Bobba",
      "last_name": "Emmerich",
      "name": "Bobba Emmerich",
      "email": "emmerich_armida@feest.com",
      "status": "active",
      "customer_id": "093ed10b-3a87-4021-9e4f-28eba4467ba1"
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
    --url 'https://example.booqable.com/api/boomerang/users/f681560c-652b-4e66-962c-789e98831f01' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f681560c-652b-4e66-962c-789e98831f01",
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
    "id": "f681560c-652b-4e66-962c-789e98831f01",
    "type": "users",
    "attributes": {
      "created_at": "2022-04-08T17:53:45+00:00",
      "updated_at": "2022-04-08T17:53:45+00:00",
      "first_name": "Katheryn",
      "last_name": "Funk",
      "name": "Katheryn Funk",
      "email": "katheryn.funk@mills.name",
      "status": "active",
      "customer_id": "5286192d-fbd7-44f9-9830-c984dc14acf4"
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
    --url 'https://example.booqable.com/api/boomerang/users/60e195ff-bc71-4e97-a4c4-d6bb11cbd3e3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "60e195ff-bc71-4e97-a4c4-d6bb11cbd3e3",
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
    "id": "60e195ff-bc71-4e97-a4c4-d6bb11cbd3e3",
    "type": "users",
    "attributes": {
      "created_at": "2022-04-08T17:53:46+00:00",
      "updated_at": "2022-04-08T17:53:46+00:00",
      "first_name": "Sally",
      "last_name": "Harvey",
      "name": "Sally Harvey",
      "email": "sally_harvey@hettinger.info",
      "status": "disabled",
      "customer_id": "0246ae15-d2d5-44ff-94cd-2fb13189f615"
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






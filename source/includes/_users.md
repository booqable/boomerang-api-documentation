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
      "id": "72527c55-823b-42ba-826d-3d274fe39045",
      "type": "users",
      "attributes": {
        "created_at": "2021-12-16T09:39:49+00:00",
        "updated_at": "2021-12-16T09:39:49+00:00",
        "first_name": "Glen",
        "last_name": "Willms",
        "name": "Glen Willms",
        "email": "glen.willms@gleichner.org",
        "status": "active",
        "customer_id": "6cf770da-8ff9-455e-831c-6a152f9ad3ba"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/6cf770da-8ff9-455e-831c-6a152f9ad3ba"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=72527c55-823b-42ba-826d-3d274fe39045&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=c4689b3c-7a5e-45f4-90f1-5eac99e63116&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c2c19a0a-cf1b-49b2-a6ec-413792b628b4",
      "type": "users",
      "attributes": {
        "created_at": "2021-12-16T09:39:50+00:00",
        "updated_at": "2021-12-16T09:39:50+00:00",
        "first_name": "Bernardo",
        "last_name": "Abernathy",
        "name": "Bernardo Abernathy",
        "email": "bernardo_abernathy@kovacek.name",
        "status": "active",
        "customer_id": "c4689b3c-7a5e-45f4-90f1-5eac99e63116"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/c4689b3c-7a5e-45f4-90f1-5eac99e63116"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=c2c19a0a-cf1b-49b2-a6ec-413792b628b4&filter[owner_type]=users"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/users?filter%5Bcustomer_id%5D=c4689b3c-7a5e-45f4-90f1-5eac99e63116&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/users?filter%5Bcustomer_id%5D=c4689b3c-7a5e-45f4-90f1-5eac99e63116&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/users?filter%5Bcustomer_id%5D=c4689b3c-7a5e-45f4-90f1-5eac99e63116&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-16T09:37:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/50fa322e-ec81-42fd-843c-0a998b1a5d6e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "50fa322e-ec81-42fd-843c-0a998b1a5d6e",
    "type": "users",
    "attributes": {
      "created_at": "2021-12-16T09:39:50+00:00",
      "updated_at": "2021-12-16T09:39:50+00:00",
      "first_name": "Rona",
      "last_name": "Feil",
      "name": "Rona Feil",
      "email": "feil_rona@aufderhar.info",
      "status": "active",
      "customer_id": "e66fb7b0-5df4-4898-9d20-3f367a3e2985"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/e66fb7b0-5df4-4898-9d20-3f367a3e2985"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=50fa322e-ec81-42fd-843c-0a998b1a5d6e&filter[owner_type]=users"
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
          "customer_id": "f2cbcd71-42b1-4f3f-98a6-6e60a887abef"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4a6691c8-a099-4832-b3d8-652ae0f4271b",
    "type": "users",
    "attributes": {
      "created_at": "2021-12-16T09:39:50+00:00",
      "updated_at": "2021-12-16T09:39:50+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "f2cbcd71-42b1-4f3f-98a6-6e60a887abef"
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
    "self": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=f2cbcd71-42b1-4f3f-98a6-6e60a887abef&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=f2cbcd71-42b1-4f3f-98a6-6e60a887abef&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=f2cbcd71-42b1-4f3f-98a6-6e60a887abef&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/users/c4fa47da-7591-46ba-a116-760a8e6b1fb4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c4fa47da-7591-46ba-a116-760a8e6b1fb4",
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
    "id": "c4fa47da-7591-46ba-a116-760a8e6b1fb4",
    "type": "users",
    "attributes": {
      "created_at": "2021-12-16T09:39:50+00:00",
      "updated_at": "2021-12-16T09:39:50+00:00",
      "first_name": "Bobba",
      "last_name": "Abshire",
      "name": "Bobba Abshire",
      "email": "neal_abshire@crist.biz",
      "status": "active",
      "customer_id": "6d32c59a-1316-45f0-b8f2-3215cb179cff"
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
    --url 'https://example.booqable.com/api/boomerang/users/eb784199-af02-46cc-9833-907a1a754747' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "eb784199-af02-46cc-9833-907a1a754747",
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
    "id": "eb784199-af02-46cc-9833-907a1a754747",
    "type": "users",
    "attributes": {
      "created_at": "2021-12-16T09:39:51+00:00",
      "updated_at": "2021-12-16T09:39:51+00:00",
      "first_name": "Mohammed",
      "last_name": "Stoltenberg",
      "name": "Mohammed Stoltenberg",
      "email": "stoltenberg_mohammed@barrows.com",
      "status": "active",
      "customer_id": "ede9b469-7810-4026-9258-b9866dfb3264"
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
    --url 'https://example.booqable.com/api/boomerang/users/54a146b9-ff7d-4b68-a661-f8fb964fb41b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "54a146b9-ff7d-4b68-a661-f8fb964fb41b",
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
    "id": "54a146b9-ff7d-4b68-a661-f8fb964fb41b",
    "type": "users",
    "attributes": {
      "created_at": "2021-12-16T09:39:51+00:00",
      "updated_at": "2021-12-16T09:39:51+00:00",
      "first_name": "Elvin",
      "last_name": "Wehner",
      "name": "Elvin Wehner",
      "email": "wehner.elvin@mcclure.com",
      "status": "disabled",
      "customer_id": "3b165e1b-7b30-4df6-a34c-3eacb87a040f"
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






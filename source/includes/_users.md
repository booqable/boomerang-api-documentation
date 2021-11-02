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

`PUT /api/boomerang/users/{id}`

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
`disabled_by` | **Employee** `readonly`<br>Associated Disabled by
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
      "id": "6980c794-e7b1-4a7f-8216-e1507821b5ac",
      "type": "users",
      "attributes": {
        "first_name": "Vito",
        "last_name": "Moen",
        "name": "Vito Moen",
        "email": "vito.moen@daugherty.net",
        "status": "active",
        "customer_id": "620b1c2b-fc71-4237-a0e5-b1acf2224cdc"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/620b1c2b-fc71-4237-a0e5-b1acf2224cdc"
          }
        },
        "disabled_by": {
          "links": {
            "related": null
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=6980c794-e7b1-4a7f-8216-e1507821b5ac&filter[notable_type]=User"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=2ae02de8-4d00-4d7f-98fd-38a4dfd22f15&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c8dc0a08-5b9c-4b32-862f-bad3d4f80e71",
      "type": "users",
      "attributes": {
        "first_name": "Rosina",
        "last_name": "Roob",
        "name": "Rosina Roob",
        "email": "roob_rosina@daniel.info",
        "status": "active",
        "customer_id": "2ae02de8-4d00-4d7f-98fd-38a4dfd22f15"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/2ae02de8-4d00-4d7f-98fd-38a4dfd22f15"
          }
        },
        "disabled_by": {
          "links": {
            "related": null
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=c8dc0a08-5b9c-4b32-862f-bad3d4f80e71&filter[notable_type]=User"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/users?filter%5Bcustomer_id%5D=2ae02de8-4d00-4d7f-98fd-38a4dfd22f15&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/users?filter%5Bcustomer_id%5D=2ae02de8-4d00-4d7f-98fd-38a4dfd22f15&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/users?filter%5Bcustomer_id%5D=2ae02de8-4d00-4d7f-98fd-38a4dfd22f15&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`include` | **String**<br>List of comma seperated relationships `?include=customer,disabled_by,notes`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-02T13:09:46Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


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
    --url 'https://example.booqable.com/api/boomerang/users/b02e0474-f541-451c-b563-c6cf7e309bde' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b02e0474-f541-451c-b563-c6cf7e309bde",
    "type": "users",
    "attributes": {
      "first_name": "Brock",
      "last_name": "Gerlach",
      "name": "Brock Gerlach",
      "email": "gerlach.brock@towne-dooley.org",
      "status": "active",
      "customer_id": "3aab7604-e899-435f-9728-0b99c5d54276"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/3aab7604-e899-435f-9728-0b99c5d54276"
        }
      },
      "disabled_by": {
        "links": {
          "related": null
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[notable_id]=b02e0474-f541-451c-b563-c6cf7e309bde&filter[notable_type]=User"
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
`include` | **String**<br>List of comma seperated relationships `?include=customer,disabled_by,notes`
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
          "customer_id": "3ba96ce8-20d5-4c41-aaaf-22476ee52b31"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5447d578-2b65-4e62-b7ac-ae7318fe4c6a",
    "type": "users",
    "attributes": {
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "3ba96ce8-20d5-4c41-aaaf-22476ee52b31"
    },
    "relationships": {
      "customer": {
        "meta": {
          "included": false
        }
      },
      "disabled_by": {
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
    "self": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=3ba96ce8-20d5-4c41-aaaf-22476ee52b31&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=3ba96ce8-20d5-4c41-aaaf-22476ee52b31&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=3ba96ce8-20d5-4c41-aaaf-22476ee52b31&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`include` | **String**<br>List of comma seperated relationships `?include=customer,disabled_by,notes`
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
    --url 'https://example.booqable.com/api/boomerang/users/4bfd463e-1c5e-4b6e-bb85-a8a5870efe6c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4bfd463e-1c5e-4b6e-bb85-a8a5870efe6c",
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
    "id": "4bfd463e-1c5e-4b6e-bb85-a8a5870efe6c",
    "type": "users",
    "attributes": {
      "first_name": "Bobba",
      "last_name": "Witting",
      "name": "Bobba Witting",
      "email": "witting_freddie@jerde.net",
      "status": "active",
      "customer_id": "3466a6ec-b100-4c0b-a5a9-d278c107e567"
    },
    "relationships": {
      "customer": {
        "meta": {
          "included": false
        }
      },
      "disabled_by": {
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
`include` | **String**<br>List of comma seperated relationships `?include=customer,disabled_by,notes`
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
    --url 'https://example.booqable.com/api/boomerang/users/8b8f1da6-25e7-4e78-8ad6-1aa0df985b1f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8b8f1da6-25e7-4e78-8ad6-1aa0df985b1f",
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
    "id": "8b8f1da6-25e7-4e78-8ad6-1aa0df985b1f",
    "type": "users",
    "attributes": {
      "first_name": "Hobert",
      "last_name": "Reichel",
      "name": "Hobert Reichel",
      "email": "reichel_hobert@abernathy.io",
      "status": "active",
      "customer_id": "e4f71bee-fc05-4e5f-a3a8-b582c56a6ceb"
    },
    "relationships": {
      "customer": {
        "meta": {
          "included": false
        }
      },
      "disabled_by": {
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
`include` | **String**<br>List of comma seperated relationships `?include=customer,disabled_by,notes`
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
    --url 'https://example.booqable.com/api/boomerang/users/d500a484-daa5-4614-b20f-8d9bc09fc98b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d500a484-daa5-4614-b20f-8d9bc09fc98b",
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
    "id": "d500a484-daa5-4614-b20f-8d9bc09fc98b",
    "type": "users",
    "attributes": {
      "first_name": "Salvatore",
      "last_name": "Feeney",
      "name": "Salvatore Feeney",
      "email": "feeney.salvatore@predovic.com",
      "status": "disabled",
      "customer_id": "44e4bae7-2218-46b1-a099-785636a030e1"
    },
    "relationships": {
      "customer": {
        "meta": {
          "included": false
        }
      },
      "disabled_by": {
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
`include` | **String**<br>List of comma seperated relationships `?include=customer,disabled_by,notes`
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






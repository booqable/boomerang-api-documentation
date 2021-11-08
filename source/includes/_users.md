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
      "id": "a209f0f5-8cfe-435f-bd0f-acc6257a6ec7",
      "type": "users",
      "attributes": {
        "first_name": "Cortez",
        "last_name": "Heathcote",
        "name": "Cortez Heathcote",
        "email": "heathcote_cortez@king.co",
        "status": "active",
        "customer_id": "9a178809-5f48-4b10-aa25-085f7e19e41f"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/9a178809-5f48-4b10-aa25-085f7e19e41f"
          }
        },
        "disabled_by": {
          "links": {
            "related": null
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=a209f0f5-8cfe-435f-bd0f-acc6257a6ec7&filter[notable_type]=User"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=acfe7749-548d-417c-9179-10cf5cf987dd&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a38b2ef0-ebac-4561-b615-5e907fb443b2",
      "type": "users",
      "attributes": {
        "first_name": "Laquanda",
        "last_name": "Friesen",
        "name": "Laquanda Friesen",
        "email": "laquanda_friesen@howell.io",
        "status": "active",
        "customer_id": "acfe7749-548d-417c-9179-10cf5cf987dd"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/acfe7749-548d-417c-9179-10cf5cf987dd"
          }
        },
        "disabled_by": {
          "links": {
            "related": null
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=a38b2ef0-ebac-4561-b615-5e907fb443b2&filter[notable_type]=User"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/users?filter%5Bcustomer_id%5D=acfe7749-548d-417c-9179-10cf5cf987dd&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/users?filter%5Bcustomer_id%5D=acfe7749-548d-417c-9179-10cf5cf987dd&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/users?filter%5Bcustomer_id%5D=acfe7749-548d-417c-9179-10cf5cf987dd&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-08T09:21:29Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/241cd9e7-efd0-4180-95a3-311aadf7e654' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "241cd9e7-efd0-4180-95a3-311aadf7e654",
    "type": "users",
    "attributes": {
      "first_name": "Beau",
      "last_name": "Quitzon",
      "name": "Beau Quitzon",
      "email": "quitzon_beau@pagac.name",
      "status": "active",
      "customer_id": "0b14ee1c-a47d-49d6-92e0-66fa7158a27d"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/0b14ee1c-a47d-49d6-92e0-66fa7158a27d"
        }
      },
      "disabled_by": {
        "links": {
          "related": null
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[notable_id]=241cd9e7-efd0-4180-95a3-311aadf7e654&filter[notable_type]=User"
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
          "customer_id": "71d9e6a6-f947-4f75-8244-c3efd7873c0b"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "cbdee536-e39c-4d25-a4d4-7991afc4a7ff",
    "type": "users",
    "attributes": {
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "71d9e6a6-f947-4f75-8244-c3efd7873c0b"
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
    "self": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=71d9e6a6-f947-4f75-8244-c3efd7873c0b&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=71d9e6a6-f947-4f75-8244-c3efd7873c0b&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=71d9e6a6-f947-4f75-8244-c3efd7873c0b&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/users/9fe3c294-d140-43da-bffe-1fd50570a975' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9fe3c294-d140-43da-bffe-1fd50570a975",
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
    "id": "9fe3c294-d140-43da-bffe-1fd50570a975",
    "type": "users",
    "attributes": {
      "first_name": "Bobba",
      "last_name": "Moen",
      "name": "Bobba Moen",
      "email": "moen.harrison@schultz.io",
      "status": "active",
      "customer_id": "0f61d5d1-c236-412a-82b7-2df0b31ddde4"
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
    --url 'https://example.booqable.com/api/boomerang/users/8616ec73-b25d-4475-8ee5-1d53b07b9bd9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8616ec73-b25d-4475-8ee5-1d53b07b9bd9",
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
    "id": "8616ec73-b25d-4475-8ee5-1d53b07b9bd9",
    "type": "users",
    "attributes": {
      "first_name": "Shemika",
      "last_name": "Pouros",
      "name": "Shemika Pouros",
      "email": "shemika.pouros@volkman-dare.biz",
      "status": "active",
      "customer_id": "965d18f3-daf5-408b-a06b-bf955abf0d71"
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
    --url 'https://example.booqable.com/api/boomerang/users/22244831-b6f6-4693-83fa-9f9c38d42dbb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "22244831-b6f6-4693-83fa-9f9c38d42dbb",
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
    "id": "22244831-b6f6-4693-83fa-9f9c38d42dbb",
    "type": "users",
    "attributes": {
      "first_name": "Trevor",
      "last_name": "Kuhic",
      "name": "Trevor Kuhic",
      "email": "trevor_kuhic@farrell.name",
      "status": "disabled",
      "customer_id": "f01ae5d9-39e2-4696-a03a-26882c32faf4"
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






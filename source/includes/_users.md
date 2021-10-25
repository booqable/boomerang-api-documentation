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
`name` | **String** `readonly`<br>The full name of the user (first_name + last_name)
`email` | **String**<br>The email of the user
`status` | **String** `readonly`<br>One of disabled, active, invited, unconfirmed
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
      "id": "a819e4eb-d320-467f-8176-f52ca64f76f5",
      "type": "users",
      "attributes": {
        "first_name": "Corinne",
        "last_name": "Kozey",
        "name": "Corinne Kozey",
        "email": "corinne.kozey@orn-stehr.org",
        "status": "active",
        "customer_id": "b7c7a9e4-ba01-42e3-b444-a56aac37730c"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/b7c7a9e4-ba01-42e3-b444-a56aac37730c"
          }
        },
        "disabled_by": {
          "links": {
            "related": null
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=a819e4eb-d320-467f-8176-f52ca64f76f5&filter[notable_type]=User"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=874feffa-e807-4b80-80a4-cec186304059&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7491600a-bcf1-4659-9329-9f6306aa0b0e",
      "type": "users",
      "attributes": {
        "first_name": "Lady",
        "last_name": "Wunsch",
        "name": "Lady Wunsch",
        "email": "wunsch.lady@gislason.io",
        "status": "active",
        "customer_id": "874feffa-e807-4b80-80a4-cec186304059"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/874feffa-e807-4b80-80a4-cec186304059"
          }
        },
        "disabled_by": {
          "links": {
            "related": null
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=7491600a-bcf1-4659-9329-9f6306aa0b0e&filter[notable_type]=User"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/users?filter%5Bcustomer_id%5D=874feffa-e807-4b80-80a4-cec186304059&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/users?filter%5Bcustomer_id%5D=874feffa-e807-4b80-80a4-cec186304059&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/users?filter%5Bcustomer_id%5D=874feffa-e807-4b80-80a4-cec186304059&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-21T11:45:54Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/dccb110b-7405-4133-a5bf-2988ec0b4f48' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dccb110b-7405-4133-a5bf-2988ec0b4f48",
    "type": "users",
    "attributes": {
      "first_name": "Leonore",
      "last_name": "Ullrich",
      "name": "Leonore Ullrich",
      "email": "ullrich.leonore@walter.name",
      "status": "active",
      "customer_id": "4328eb5b-0ec1-4319-ad5e-4179887f626f"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/4328eb5b-0ec1-4319-ad5e-4179887f626f"
        }
      },
      "disabled_by": {
        "links": {
          "related": null
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[notable_id]=dccb110b-7405-4133-a5bf-2988ec0b4f48&filter[notable_type]=User"
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
          "customer_id": "cb63523a-ce5d-4ff2-a467-2ddd8a34eef3"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d7e08030-3e9c-44ec-820d-4a22acb6988d",
    "type": "users",
    "attributes": {
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "cb63523a-ce5d-4ff2-a467-2ddd8a34eef3"
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
    "self": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=cb63523a-ce5d-4ff2-a467-2ddd8a34eef3&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=cb63523a-ce5d-4ff2-a467-2ddd8a34eef3&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=cb63523a-ce5d-4ff2-a467-2ddd8a34eef3&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/users/a83590c1-2d5b-4aa6-b97f-6eb0123a839e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a83590c1-2d5b-4aa6-b97f-6eb0123a839e",
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
    "id": "a83590c1-2d5b-4aa6-b97f-6eb0123a839e",
    "type": "users",
    "attributes": {
      "first_name": "Bobba",
      "last_name": "Stoltenberg",
      "name": "Bobba Stoltenberg",
      "email": "stoltenberg.trinidad@gottlieb-roob.org",
      "status": "active",
      "customer_id": "f67194f9-aaa6-4a78-8bd1-e6ef4f80defb"
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
    --url 'https://example.booqable.com/api/boomerang/users/c2185a97-ccc7-4c27-b513-e0104a6eb51b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c2185a97-ccc7-4c27-b513-e0104a6eb51b",
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
    "id": "c2185a97-ccc7-4c27-b513-e0104a6eb51b",
    "type": "users",
    "attributes": {
      "first_name": "Ben",
      "last_name": "Emard",
      "name": "Ben Emard",
      "email": "ben.emard@mckenzie.name",
      "status": "active",
      "customer_id": "11a4a5fe-12a4-429f-b6bc-1cbf0a42d96e"
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
    --url 'https://example.booqable.com/api/boomerang/users/44fb56a0-78bc-465e-ac2f-dd4d7404145c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "44fb56a0-78bc-465e-ac2f-dd4d7404145c",
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
    "id": "44fb56a0-78bc-465e-ac2f-dd4d7404145c",
    "type": "users",
    "attributes": {
      "first_name": "Tennille",
      "last_name": "Zulauf",
      "name": "Tennille Zulauf",
      "email": "tennille_zulauf@windler.com",
      "status": "disabled",
      "customer_id": "eee8103e-66c2-468a-a3da-ea20866adfa7"
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
`data[attributes][email]` | **String**<br>The email of the user
`data[attributes][disabled]` | **Boolean**<br>When a user is disabled they cannot log into their account or create orders
`data[attributes][customer_id]` | **Uuid**<br>The associated Customer


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






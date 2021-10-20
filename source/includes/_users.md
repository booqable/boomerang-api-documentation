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
`name` | **String** `readonly`<br>The full name of the user (first_name + last_name)
`email` | **String**<br>The email of the user
`status` | **String** `readonly`<br>One of disabled, active, invited, unconfirmed
`disabled` | **Boolean** `writeonly`<br>When a user is disabled they cannot log into their account or create orders
`customer_id` | **Uuid**<br>The associated Customer


## Relationships
A users has the following relationships:

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
      "id": "df986318-01b0-4d9d-ae91-9a9795d8affe",
      "type": "users",
      "attributes": {
        "first_name": "Cruz",
        "last_name": "Fay",
        "name": "Cruz Fay",
        "email": "cruz.fay@ruecker-spencer.com",
        "status": "active",
        "customer_id": "c5d8e659-cee3-4177-be16-84ed2d9dc32c"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/c5d8e659-cee3-4177-be16-84ed2d9dc32c"
          }
        },
        "disabled_by": {
          "links": {
            "related": null
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=df986318-01b0-4d9d-ae91-9a9795d8affe&filter[notable_type]=User"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=a3d24c69-d4d6-4714-8364-bd9ac4df2dc1&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ae76bc40-392b-4fce-ad41-6e285e4bd2cf",
      "type": "users",
      "attributes": {
        "first_name": "Audrey",
        "last_name": "Rowe",
        "name": "Audrey Rowe",
        "email": "rowe.audrey@brekke-kuhn.biz",
        "status": "active",
        "customer_id": "a3d24c69-d4d6-4714-8364-bd9ac4df2dc1"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/a3d24c69-d4d6-4714-8364-bd9ac4df2dc1"
          },
          "data": {
            "type": "customers",
            "id": "a3d24c69-d4d6-4714-8364-bd9ac4df2dc1"
          }
        },
        "disabled_by": {
          "links": {
            "related": null
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=ae76bc40-392b-4fce-ad41-6e285e4bd2cf&filter[notable_type]=User"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a3d24c69-d4d6-4714-8364-bd9ac4df2dc1",
      "type": "customers",
      "attributes": {
        "number": 1,
        "name": "Glover-Rice",
        "email": "rice_glover@heller-bailey.org",
        "archived": false,
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {
        "merge_suggestion_customer": {
          "links": {
            "related": null
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a3d24c69-d4d6-4714-8364-bd9ac4df2dc1"
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
`include` | **String**<br>List of comma seperated relationships `?include=customer,disabled_by,notes`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[users]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-20T11:12:38Z`
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

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Fetching a user

> How to fetch a user:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/users/4d155456-997e-4e04-9048-bb97b2658e69' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4d155456-997e-4e04-9048-bb97b2658e69",
    "type": "users",
    "attributes": {
      "first_name": "Missy",
      "last_name": "Cruickshank",
      "name": "Missy Cruickshank",
      "email": "missy.cruickshank@kshlerin.io",
      "status": "active",
      "customer_id": "825c43f9-5665-4ce1-97b4-b2c786ae7c29"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/825c43f9-5665-4ce1-97b4-b2c786ae7c29"
        }
      },
      "disabled_by": {
        "links": {
          "related": null
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[notable_id]=4d155456-997e-4e04-9048-bb97b2658e69&filter[notable_type]=User"
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
    --url 'https://example.booqable.com/api/boomerang/users/97c9e16e-e899-4f1b-97e8-d8fe4a2f1e93' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "97c9e16e-e899-4f1b-97e8-d8fe4a2f1e93",
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
    "id": "97c9e16e-e899-4f1b-97e8-d8fe4a2f1e93",
    "type": "users",
    "attributes": {
      "first_name": "Milford",
      "last_name": "Sanford",
      "name": "Milford Sanford",
      "email": "sanford_milford@grant-roob.com",
      "status": "active",
      "customer_id": "3f65eeee-a5d4-43ee-81b0-eb28d0695d90"
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






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
      "id": "0674af46-a94f-4134-8223-6124f2f32040",
      "type": "users",
      "attributes": {
        "created_at": "2021-12-30T11:23:11+00:00",
        "updated_at": "2021-12-30T11:23:11+00:00",
        "first_name": "Colin",
        "last_name": "Grimes",
        "name": "Colin Grimes",
        "email": "colin.grimes@king-kutch.com",
        "status": "active",
        "customer_id": "1fe364fd-86f9-45cb-a56e-442046438e34"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/1fe364fd-86f9-45cb-a56e-442046438e34"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0674af46-a94f-4134-8223-6124f2f32040&filter[owner_type]=users"
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
    --url 'https://example.booqable.com/api/boomerang/users?filter%5Bcustomer_id%5D=404ee7a5-87d0-4753-b343-ca9862669fdd&include=customer' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d8c80aaa-b3fc-47f3-94be-e6f8291f2e3b",
      "type": "users",
      "attributes": {
        "created_at": "2021-12-30T11:23:11+00:00",
        "updated_at": "2021-12-30T11:23:11+00:00",
        "first_name": "Julee",
        "last_name": "Bednar",
        "name": "Julee Bednar",
        "email": "bednar_julee@heaney-prosacco.biz",
        "status": "active",
        "customer_id": "404ee7a5-87d0-4753-b343-ca9862669fdd"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/404ee7a5-87d0-4753-b343-ca9862669fdd"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d8c80aaa-b3fc-47f3-94be-e6f8291f2e3b&filter[owner_type]=users"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/users?filter%5Bcustomer_id%5D=404ee7a5-87d0-4753-b343-ca9862669fdd&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/users?filter%5Bcustomer_id%5D=404ee7a5-87d0-4753-b343-ca9862669fdd&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/users?filter%5Bcustomer_id%5D=404ee7a5-87d0-4753-b343-ca9862669fdd&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-30T11:20:25Z`
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
    --url 'https://example.booqable.com/api/boomerang/users/84aee1d4-f9ad-47b2-9c37-d6df377f60c4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "84aee1d4-f9ad-47b2-9c37-d6df377f60c4",
    "type": "users",
    "attributes": {
      "created_at": "2021-12-30T11:23:12+00:00",
      "updated_at": "2021-12-30T11:23:12+00:00",
      "first_name": "Jonna",
      "last_name": "Goodwin",
      "name": "Jonna Goodwin",
      "email": "jonna.goodwin@stamm.name",
      "status": "active",
      "customer_id": "151e72d0-1b98-4352-88a2-c06294bd79b4"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/151e72d0-1b98-4352-88a2-c06294bd79b4"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=84aee1d4-f9ad-47b2-9c37-d6df377f60c4&filter[owner_type]=users"
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
          "customer_id": "c4c60343-f65b-4226-aff1-b9e3be834fe9"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5c6f8bdd-316c-455d-a91f-334344415b08",
    "type": "users",
    "attributes": {
      "created_at": "2021-12-30T11:23:12+00:00",
      "updated_at": "2021-12-30T11:23:12+00:00",
      "first_name": "Bob",
      "last_name": "Bobsen",
      "name": "Bob Bobsen",
      "email": "bob@booqable.com",
      "status": "invited",
      "customer_id": "c4c60343-f65b-4226-aff1-b9e3be834fe9"
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
    "self": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=c4c60343-f65b-4226-aff1-b9e3be834fe9&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=c4c60343-f65b-4226-aff1-b9e3be834fe9&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/users?data%5Battributes%5D%5Bcustomer_id%5D=c4c60343-f65b-4226-aff1-b9e3be834fe9&data%5Battributes%5D%5Bemail%5D=bob%40booqable.com&data%5Battributes%5D%5Bfirst_name%5D=Bob&data%5Battributes%5D%5Blast_name%5D=Bobsen&data%5Btype%5D=users&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/users/bfa67901-95e4-43e1-9735-f5781ad038fa' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bfa67901-95e4-43e1-9735-f5781ad038fa",
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
    "id": "bfa67901-95e4-43e1-9735-f5781ad038fa",
    "type": "users",
    "attributes": {
      "created_at": "2021-12-30T11:23:13+00:00",
      "updated_at": "2021-12-30T11:23:13+00:00",
      "first_name": "Bobba",
      "last_name": "Johns",
      "name": "Bobba Johns",
      "email": "saran.johns@batz-johns.com",
      "status": "active",
      "customer_id": "a9fa32b7-2dce-4e60-8487-d89bcc8dfde7"
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
    --url 'https://example.booqable.com/api/boomerang/users/eb0f2b47-f71a-451e-adbb-5a99a375bb8b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "eb0f2b47-f71a-451e-adbb-5a99a375bb8b",
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
    "id": "eb0f2b47-f71a-451e-adbb-5a99a375bb8b",
    "type": "users",
    "attributes": {
      "created_at": "2021-12-30T11:23:13+00:00",
      "updated_at": "2021-12-30T11:23:13+00:00",
      "first_name": "Olin",
      "last_name": "Nitzsche",
      "name": "Olin Nitzsche",
      "email": "olin_nitzsche@weimann.info",
      "status": "active",
      "customer_id": "4e8757b2-664e-41a8-bb98-d43c9d477faf"
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
    --url 'https://example.booqable.com/api/boomerang/users/6ee605cb-443a-406e-a29e-4a3f9575440f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6ee605cb-443a-406e-a29e-4a3f9575440f",
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
    "id": "6ee605cb-443a-406e-a29e-4a3f9575440f",
    "type": "users",
    "attributes": {
      "created_at": "2021-12-30T11:23:14+00:00",
      "updated_at": "2021-12-30T11:23:14+00:00",
      "first_name": "Earlean",
      "last_name": "Sporer",
      "name": "Earlean Sporer",
      "email": "earlean.sporer@miller-altenwerth.biz",
      "status": "disabled",
      "customer_id": "3b3e7159-f093-40f4-a91a-4b46c57b57b6"
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






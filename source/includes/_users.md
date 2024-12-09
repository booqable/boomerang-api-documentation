# Users

Users can be used to log into the web shop. They are useful for exposing your shop
to a limited audience or verifiying that a customers can actually be reached via an email.

A user always belongs to a Customer. A customer can have multiple users. This is relevant
for companies where multiple people are allowed to book orders in the name of that company.
Because of this, a user should always be an actual person, not a legal person.

Depending on the setting in your Booqable account, creating a user can actually mean that
you're inviting the user. In that case, the user still needs to confirm their email and
set a password before the account is active. (See *status*)

## Relationships
Name | Description
-- | --
`customer` | **[Customer](#customers)** `required`<br>Customer who owns this account.
`notes` | **[Notes](#notes)** `hasmany`<br>Notes about this user.


Check matching attributes under [Fields](#users-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`customer_id` | **uuid** `readonly-after-create`<br>Customer who owns this account.
`disabled` | **boolean** `writeonly`<br>When a user is disabled they cannot log into their account or create orders.
`email` | **string** `readonly-after-create`<br>The email of the user.
`first_name` | **string** <br>The first name of the user.
`id` | **uuid** `readonly`<br>Primary key.
`last_name` | **string** <br>The last name of the user.
`name` | **string** <br>The full name of the user (first_name + last_name).
`status` | **enum** `readonly`<br>Status.<br>One of: `disabled`, `active`, `invited`, `unconfirmed`.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Listing users


> How to fetch a list of users:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/users'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "ca08d52a-c5d9-433f-8774-bd964a456f31",
        "type": "users",
        "attributes": {
          "created_at": "2028-10-16T13:17:01.000000+00:00",
          "updated_at": "2028-10-16T13:17:01.000000+00:00",
          "first_name": "John",
          "last_name": "Doe",
          "name": "John Doe",
          "email": "john-2@doe.test",
          "status": "active",
          "customer_id": "7e745c70-f3c2-47be-8ac6-3f11e3ce374b"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

> How to find users belonging to a customer:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/users'
       --header 'content-type: application/json'
       --data-urlencode 'filter[customer_id]=fe7b81ca-a0ac-425d-8618-2e1929b46bc8'
       --data-urlencode 'include=customer'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "dbbce813-8d54-47d6-8b4d-eec5b28c878c",
        "type": "users",
        "attributes": {
          "created_at": "2023-08-23T07:33:01.000000+00:00",
          "updated_at": "2023-08-23T07:33:01.000000+00:00",
          "first_name": "John",
          "last_name": "Doe",
          "name": "John Doe",
          "email": "john-3@doe.test",
          "status": "active",
          "customer_id": "fe7b81ca-a0ac-425d-8618-2e1929b46bc8"
        },
        "relationships": {}
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[users]=created_at,updated_at,first_name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **uuid** <br>`eq`, `not_eq`
`email` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`first_name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`id` | **uuid** <br>`eq`, `not_eq`
`last_name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`status` | **string_enum** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a user


> How to fetch a user:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/users/c92780ab-5df7-4cbd-8435-a2c09cee05e8'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "c92780ab-5df7-4cbd-8435-a2c09cee05e8",
      "type": "users",
      "attributes": {
        "created_at": "2023-09-28T12:54:04.000000+00:00",
        "updated_at": "2023-09-28T12:54:04.000000+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-4@doe.test",
        "status": "active",
        "customer_id": "d51b343c-b9f4-4080-8923-80d182b6de87"
      },
      "relationships": {}
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[users]=created_at,updated_at,first_name`
`include` | **string** <br>List of comma seperated relationships `?include=customer,disabled_by,notes`


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Inviting a user


> How to invite a user:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/users'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "users",
           "attributes": {
             "first_name": "Bob",
             "last_name": "Bobsen",
             "email": "bob@booqable.com",
             "customer_id": "dbc90081-f163-4c62-8cb3-5b1ecbb19235"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "75e1d103-6838-433a-8f0d-62737c7a8761",
      "type": "users",
      "attributes": {
        "created_at": "2017-06-05T11:04:00.000000+00:00",
        "updated_at": "2017-06-05T11:04:00.000000+00:00",
        "first_name": "Bob",
        "last_name": "Bobsen",
        "name": "Bob Bobsen",
        "email": "bob@booqable.com",
        "status": "invited",
        "customer_id": "dbc90081-f163-4c62-8cb3-5b1ecbb19235"
      },
      "relationships": {}
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[users]=created_at,updated_at,first_name`
`include` | **string** <br>List of comma seperated relationships `?include=customer,disabled_by,notes`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][customer_id]` | **uuid** <br>Customer who owns this account.
`data[attributes][disabled]` | **boolean** <br>When a user is disabled they cannot log into their account or create orders.
`data[attributes][email]` | **string** <br>The email of the user.
`data[attributes][first_name]` | **string** <br>The first name of the user.
`data[attributes][last_name]` | **string** <br>The last name of the user.
`data[attributes][name]` | **string** <br>The full name of the user (first_name + last_name).


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Updating a user


> How to update a user:

```shell
  curl --request PUT \
       --url 'https://example.booqable.com/api/boomerang/users/c7e240ef-31fa-4e38-8cb7-cafd7719304c'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "c7e240ef-31fa-4e38-8cb7-cafd7719304c",
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
      "id": "c7e240ef-31fa-4e38-8cb7-cafd7719304c",
      "type": "users",
      "attributes": {
        "created_at": "2021-01-03T08:52:01.000000+00:00",
        "updated_at": "2021-01-03T08:52:01.000000+00:00",
        "first_name": "Bobba",
        "last_name": "Doe",
        "name": "Bobba Doe",
        "email": "john-6@doe.test",
        "status": "active",
        "customer_id": "947c2a92-d6bf-4637-860d-17e82c6dbf1b"
      },
      "relationships": {}
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[users]=created_at,updated_at,first_name`
`include` | **string** <br>List of comma seperated relationships `?include=customer,disabled_by,notes`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][customer_id]` | **uuid** <br>Customer who owns this account.
`data[attributes][disabled]` | **boolean** <br>When a user is disabled they cannot log into their account or create orders.
`data[attributes][email]` | **string** <br>The email of the user.
`data[attributes][first_name]` | **string** <br>The first name of the user.
`data[attributes][last_name]` | **string** <br>The last name of the user.
`data[attributes][name]` | **string** <br>The full name of the user (first_name + last_name).


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Enabling a user


> How to enable a user:

```shell
  curl --request PUT \
       --url 'https://example.booqable.com/api/boomerang/users/b20174a8-b59e-4d8b-8ae1-af97052ceaae'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "b20174a8-b59e-4d8b-8ae1-af97052ceaae",
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
      "id": "b20174a8-b59e-4d8b-8ae1-af97052ceaae",
      "type": "users",
      "attributes": {
        "created_at": "2025-07-19T12:22:01.000000+00:00",
        "updated_at": "2025-07-19T12:22:01.000000+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-7@doe.test",
        "status": "active",
        "customer_id": "a6d008aa-b06a-4337-84f0-23b4ce2148a9"
      },
      "relationships": {}
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[users]=created_at,updated_at,first_name`
`include` | **string** <br>List of comma seperated relationships `?include=customer,disabled_by,notes`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][customer_id]` | **uuid** <br>Customer who owns this account.
`data[attributes][disabled]` | **boolean** <br>When a user is disabled they cannot log into their account or create orders.
`data[attributes][email]` | **string** <br>The email of the user.
`data[attributes][first_name]` | **string** <br>The first name of the user.
`data[attributes][last_name]` | **string** <br>The last name of the user.
`data[attributes][name]` | **string** <br>The full name of the user (first_name + last_name).


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






## Disabling a user


> How to disable a user:

```shell
  curl --request PUT \
       --url 'https://example.booqable.com/api/boomerang/users/bf3a537d-192a-4df8-8a92-594008521fef'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "bf3a537d-192a-4df8-8a92-594008521fef",
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
      "id": "bf3a537d-192a-4df8-8a92-594008521fef",
      "type": "users",
      "attributes": {
        "created_at": "2022-03-25T21:54:00.000000+00:00",
        "updated_at": "2022-03-25T21:54:00.000000+00:00",
        "first_name": "John",
        "last_name": "Doe",
        "name": "John Doe",
        "email": "john-8@doe.test",
        "status": "disabled",
        "customer_id": "79211c5b-e26c-49e8-8199-74af44f213df"
      },
      "relationships": {}
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[users]=created_at,updated_at,first_name`
`include` | **string** <br>List of comma seperated relationships `?include=customer,disabled_by,notes`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][customer_id]` | **uuid** <br>Customer who owns this account.
`data[attributes][disabled]` | **boolean** <br>When a user is disabled they cannot log into their account or create orders.
`data[attributes][email]` | **string** <br>The email of the user.
`data[attributes][first_name]` | **string** <br>The first name of the user.
`data[attributes][last_name]` | **string** <br>The last name of the user.
`data[attributes][name]` | **string** <br>The full name of the user (first_name + last_name).


### Includes

This request accepts the following includes:

`customer`


`disabled_by`


`notes`






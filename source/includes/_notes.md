# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes`

`GET /api/boomerang/notes/{id}`

`POST /api/boomerang/notes`

`DELETE /api/boomerang/notes/{id}`

## Fields
Every note has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`body` | **String** <br>The content of the note
`owner_id` | **Uuid** <br>ID of the resource the note is attached to
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `documents`, `product_groups`, `bundles`, `products`, `customers`, `stock_items`, `users`
`employee_id` | **Uuid** `readonly`<br>Associated Employee


## Relationships
Notes have the following relationships:

Name | Description
-- | --
`employee` | **[Employee](#employees)** <br>Associated Employee
`owner` | **[Customer](#customers), [Product](#products), [Product group](#product-groups), [Stock item](#stock-items), [Bundle](#bundles), [Order](#orders), [Document](#documents), [User](#users)** <br>Associated Owner


## Listing notes



> How to fetch a list of notes:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "994f345a-ec2c-41cc-bea7-668b8f5895d2",
      "type": "notes",
      "attributes": {
        "created_at": "2024-12-02T13:05:15.701197+00:00",
        "updated_at": "2024-12-02T13:05:15.701197+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "e52c6c73-a819-4137-90c9-b8002c9437be",
        "owner_type": "customers",
        "employee_id": "cf079ba4-1c19-4ed1-9161-ee858043b577"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/notes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`
`employee_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`employee`


`owner`






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/7081d3d2-12f3-4622-8418-423a4841d47c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7081d3d2-12f3-4622-8418-423a4841d47c",
    "type": "notes",
    "attributes": {
      "created_at": "2024-12-02T13:05:17.107439+00:00",
      "updated_at": "2024-12-02T13:05:17.107439+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "2728fd21-6bf5-400d-b37e-a2906f561c14",
      "owner_type": "customers",
      "employee_id": "61b53135-8c53-4904-a2f6-8081c66626b4"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/notes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`


### Includes

This request accepts the following includes:

`employee`


`owner`






## Creating a note



> How to create a note:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/notes' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "notes",
        "attributes": {
          "body": "Agreed to give this customer a 20% discount on the next order",
          "owner_id": "6270933b-6f28-4361-a0ed-d75bec9eac17",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9c58b895-9d93-46a4-84d4-719ecf31696e",
    "type": "notes",
    "attributes": {
      "created_at": "2024-12-02T13:05:16.530016+00:00",
      "updated_at": "2024-12-02T13:05:16.530016+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "6270933b-6f28-4361-a0ed-d75bec9eac17",
      "owner_type": "customers",
      "employee_id": "96bcae1b-a6ea-4184-9bf4-b0ff39dc1260"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/notes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][body]` | **String** <br>The content of the note
`data[attributes][owner_id]` | **Uuid** <br>ID of the resource the note is attached to
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `documents`, `product_groups`, `bundles`, `products`, `customers`, `stock_items`, `users`


### Includes

This request accepts the following includes:

`employee`


`owner`






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/d1dd391a-eb36-4101-994e-5beb6b700d71' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d1dd391a-eb36-4101-994e-5beb6b700d71",
    "type": "notes",
    "attributes": {
      "created_at": "2024-12-02T13:05:15.097209+00:00",
      "updated_at": "2024-12-02T13:05:15.097209+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "c36b52eb-648a-4998-ba3d-2f08d9683998",
      "owner_type": "customers",
      "employee_id": "e04e7345-0dd3-492e-8be7-04e4c36f636e"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/notes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`


### Includes

This request accepts the following includes:

`employee`


`owner`






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
      "id": "6ce5e967-8e55-4c02-971b-a13ea13620cf",
      "type": "notes",
      "attributes": {
        "created_at": "2024-12-02T09:22:44.313286+00:00",
        "updated_at": "2024-12-02T09:22:44.313286+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "af6675e9-60a6-4567-8ff1-ede590a74fb3",
        "owner_type": "customers",
        "employee_id": "de08ecb7-81c3-4e0b-8ba4-5ce86c9e9f08"
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
    --url 'https://example.booqable.com/api/boomerang/notes/90115bea-a0f8-4026-ab3a-a408fe174a20' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "90115bea-a0f8-4026-ab3a-a408fe174a20",
    "type": "notes",
    "attributes": {
      "created_at": "2024-12-02T09:22:45.402385+00:00",
      "updated_at": "2024-12-02T09:22:45.402385+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "ce18c8cc-999e-429e-92d6-7c23aaf5bfd8",
      "owner_type": "customers",
      "employee_id": "9881722b-48fb-48a4-9d45-e40a748f3d9b"
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
          "owner_id": "e22db86c-e5ef-498d-90f4-9ea8a9f4e4d2",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "39cc60ee-acfe-458f-bd18-42652dfa5fa9",
    "type": "notes",
    "attributes": {
      "created_at": "2024-12-02T09:22:44.849421+00:00",
      "updated_at": "2024-12-02T09:22:44.849421+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "e22db86c-e5ef-498d-90f4-9ea8a9f4e4d2",
      "owner_type": "customers",
      "employee_id": "244ab269-1e36-43ce-a1e5-77190dbd7882"
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
    --url 'https://example.booqable.com/api/boomerang/notes/61d171b4-b614-432e-a622-8d6ea57e5ede' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "61d171b4-b614-432e-a622-8d6ea57e5ede",
    "type": "notes",
    "attributes": {
      "created_at": "2024-12-02T09:22:43.801824+00:00",
      "updated_at": "2024-12-02T09:22:43.801824+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "d72980ed-dfdd-4946-a2c5-48916a5c939c",
      "owner_type": "customers",
      "employee_id": "367ca35a-afa2-400e-9c42-38043a7976a2"
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






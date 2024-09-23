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
`employee_id` | **Uuid** `readonly`<br>The associated Employee


## Relationships
Notes have the following relationships:

Name | Description
-- | --
`employee` | **Employees** `readonly`<br>Associated Employee
`owner` | **Customer, Product, Product group, Stock item, Bundle, Order, Document** <br>Associated Owner


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
      "id": "918dd07e-50de-46b4-80c7-0519ece68211",
      "type": "notes",
      "attributes": {
        "created_at": "2024-09-23T09:27:56.423253+00:00",
        "updated_at": "2024-09-23T09:27:56.423253+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "9ea34659-e11c-446c-b578-04aeb4a63308",
        "owner_type": "customers",
        "employee_id": "d02f99ff-9a04-4c29-90b8-413bbd1be94e"
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
    --url 'https://example.booqable.com/api/boomerang/notes/b566322e-10c2-45b4-bf58-1a41342d83d5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b566322e-10c2-45b4-bf58-1a41342d83d5",
    "type": "notes",
    "attributes": {
      "created_at": "2024-09-23T09:27:57.733691+00:00",
      "updated_at": "2024-09-23T09:27:57.733691+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "41a1e06c-0f4f-44e4-aaba-5c961b31b763",
      "owner_type": "customers",
      "employee_id": "07f0c37f-2472-487f-a520-29d8212112c8"
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
          "owner_id": "790f0621-a4a1-46f2-ace1-5242bf920537",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "130a0107-3c28-4efa-ac5b-0b7b0be5b186",
    "type": "notes",
    "attributes": {
      "created_at": "2024-09-23T09:27:55.806719+00:00",
      "updated_at": "2024-09-23T09:27:55.806719+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "790f0621-a4a1-46f2-ace1-5242bf920537",
      "owner_type": "customers",
      "employee_id": "931bcb37-8dc5-424c-b727-2201986a4f5f"
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
    --url 'https://example.booqable.com/api/boomerang/notes/ade527a6-cd65-4dd8-9743-3bdda883fcc7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ade527a6-cd65-4dd8-9743-3bdda883fcc7",
    "type": "notes",
    "attributes": {
      "created_at": "2024-09-23T09:27:58.197563+00:00",
      "updated_at": "2024-09-23T09:27:58.197563+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "460cd201-1bac-4387-aefd-de5359c0bf65",
      "owner_type": "customers",
      "employee_id": "b82df736-f094-49cf-af74-41ee88e96709"
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






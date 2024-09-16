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
      "id": "2b0a90f1-72f8-43cd-946b-6a297ca3f96b",
      "type": "notes",
      "attributes": {
        "created_at": "2024-09-16T09:26:26.891311+00:00",
        "updated_at": "2024-09-16T09:26:26.891311+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "cc7c4644-237b-4c4f-9cf8-e58dde375bbf",
        "owner_type": "customers",
        "employee_id": "da37da5d-596b-4a75-a44a-8dd2fc42736d"
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
    --url 'https://example.booqable.com/api/boomerang/notes/5b2065c9-1f18-43c2-bb1c-9d3b41a2eb6e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5b2065c9-1f18-43c2-bb1c-9d3b41a2eb6e",
    "type": "notes",
    "attributes": {
      "created_at": "2024-09-16T09:26:25.761272+00:00",
      "updated_at": "2024-09-16T09:26:25.761272+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "84e9ea20-46f6-4915-aacc-10e9dba3da77",
      "owner_type": "customers",
      "employee_id": "6ccd35b2-bd56-482a-872e-958c4cb93d4e"
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
          "owner_id": "1388b836-5ff1-401e-a6e9-93613a53d620",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f632f13d-5bbd-414d-868b-5023557f6a98",
    "type": "notes",
    "attributes": {
      "created_at": "2024-09-16T09:26:26.341213+00:00",
      "updated_at": "2024-09-16T09:26:26.341213+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "1388b836-5ff1-401e-a6e9-93613a53d620",
      "owner_type": "customers",
      "employee_id": "f6bdd5f3-41ab-46af-8e9e-c354b57a6acb"
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
    --url 'https://example.booqable.com/api/boomerang/notes/976e43b5-ffa8-4d17-b2ff-c676ddcd0675' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "976e43b5-ffa8-4d17-b2ff-c676ddcd0675",
    "type": "notes",
    "attributes": {
      "created_at": "2024-09-16T09:26:25.090133+00:00",
      "updated_at": "2024-09-16T09:26:25.090133+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "d96cf2ed-2413-476e-89f3-1e23b8783d27",
      "owner_type": "customers",
      "employee_id": "752684c0-afba-4202-a460-f0fdd4627312"
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






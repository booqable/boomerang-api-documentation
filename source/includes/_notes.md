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
`owner` | **Customer, Product, Product group, Stock item, Bundle, Order, Document**<br>Associated Owner
`employee` | **Employees** `readonly`<br>Associated Employee


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
      "id": "a56665af-685b-4172-962a-bf3e257d591d",
      "type": "notes",
      "attributes": {
        "created_at": "2023-05-15T13:49:19+00:00",
        "updated_at": "2023-05-15T13:49:19+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "adc0f27d-217a-45d2-84fd-87f7b6d1d78e",
        "owner_type": "customers",
        "employee_id": "a6c18cb3-bc8a-42f0-84e3-802e2132a27f"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/adc0f27d-217a-45d2-84fd-87f7b6d1d78e"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/a6c18cb3-bc8a-42f0-84e3-802e2132a27f"
          }
        }
      }
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
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
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

`owner`


`employee`






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/f965f2cc-dc36-4506-bd3a-12b519dc4fd9' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f965f2cc-dc36-4506-bd3a-12b519dc4fd9",
    "type": "notes",
    "attributes": {
      "created_at": "2023-05-15T13:49:19+00:00",
      "updated_at": "2023-05-15T13:49:19+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "637a3c5f-0733-4637-8b2e-5d5beacb80bb",
      "owner_type": "customers",
      "employee_id": "6c7d6f1b-d3e0-43d1-a096-a0f0f2d756c7"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/637a3c5f-0733-4637-8b2e-5d5beacb80bb"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/6c7d6f1b-d3e0-43d1-a096-a0f0f2d756c7"
        }
      }
    }
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
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`


### Includes

This request accepts the following includes:

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
          "owner_id": "911998e7-0969-4f9e-b7a2-725762802f86",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "88ec062b-37fd-4852-883c-19c7f3085641",
    "type": "notes",
    "attributes": {
      "created_at": "2023-05-15T13:49:20+00:00",
      "updated_at": "2023-05-15T13:49:20+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "911998e7-0969-4f9e-b7a2-725762802f86",
      "owner_type": "customers",
      "employee_id": "36702149-bcf7-482e-86dd-4fdcd830d301"
    },
    "relationships": {
      "owner": {
        "meta": {
          "included": false
        }
      },
      "employee": {
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

`POST /api/boomerang/notes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
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

`owner`






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/1c33fe16-3ca7-493d-9c80-e01267736856' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/notes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`


### Includes

This request does not accept any includes
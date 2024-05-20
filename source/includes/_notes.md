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
      "id": "83bd5089-da68-45fa-9aa3-151aa9faecc6",
      "type": "notes",
      "attributes": {
        "created_at": "2024-05-20T09:28:30+00:00",
        "updated_at": "2024-05-20T09:28:30+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "2fe1a54c-e07f-4296-88bf-648aafe96a53",
        "owner_type": "customers",
        "employee_id": "416a70a6-b97b-40e0-97db-666c13ab2e76"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/2fe1a54c-e07f-4296-88bf-648aafe96a53"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/416a70a6-b97b-40e0-97db-666c13ab2e76"
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
    --url 'https://example.booqable.com/api/boomerang/notes/64e72d4c-b5ca-4953-9363-6198253d2e29' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "64e72d4c-b5ca-4953-9363-6198253d2e29",
    "type": "notes",
    "attributes": {
      "created_at": "2024-05-20T09:28:30+00:00",
      "updated_at": "2024-05-20T09:28:30+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "bc05a9f8-c141-4635-88e4-d1a47dbf1620",
      "owner_type": "customers",
      "employee_id": "fe213c50-7928-45a1-a50a-fc48ae810d98"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/bc05a9f8-c141-4635-88e4-d1a47dbf1620"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/fe213c50-7928-45a1-a50a-fc48ae810d98"
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
          "owner_id": "f68ccd6e-78e1-4e75-9c4d-0012adc6a7d8",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1aa6506a-93ca-412c-899c-398e316a3049",
    "type": "notes",
    "attributes": {
      "created_at": "2024-05-20T09:28:31+00:00",
      "updated_at": "2024-05-20T09:28:31+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "f68ccd6e-78e1-4e75-9c4d-0012adc6a7d8",
      "owner_type": "customers",
      "employee_id": "2b7700b1-a307-4acb-bb82-83d91c632dc3"
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
    --url 'https://example.booqable.com/api/boomerang/notes/93b74ebb-54ae-435d-ad00-7951531e4593' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "93b74ebb-54ae-435d-ad00-7951531e4593",
    "type": "notes",
    "attributes": {
      "created_at": "2024-05-20T09:28:32+00:00",
      "updated_at": "2024-05-20T09:28:32+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "2f9d139b-315a-4c8a-810c-276cd3ec89a5",
      "owner_type": "customers",
      "employee_id": "a16bb2b8-a258-4879-a270-2823ac319881"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/2f9d139b-315a-4c8a-810c-276cd3ec89a5"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/a16bb2b8-a258-4879-a270-2823ac319881"
        }
      }
    }
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






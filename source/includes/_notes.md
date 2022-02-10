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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`body` | **String**<br>The content of the note
`owner_id` | **Uuid**<br>ID of the resource the note is attached to
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `documents`, `product_groups`, `bundles`, `products`, `customers`, `stock_items`
`employee_id` | **Uuid** `readonly`<br>The associated Employee


## Relationships
Notes have the following relationships:

Name | Description
- | -
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
      "id": "51d7747d-fd59-4c9c-a002-20b8a171983a",
      "type": "notes",
      "attributes": {
        "created_at": "2022-02-10T10:32:12+00:00",
        "updated_at": "2022-02-10T10:32:12+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "85de979c-d1b1-44c1-ba06-64d623434c03",
        "owner_type": "customers",
        "employee_id": "92d444f7-41b8-49d6-b7d5-760924b83750"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/85de979c-d1b1-44c1-ba06-64d623434c03"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/92d444f7-41b8-49d6-b7d5-760924b83750"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-10T10:30:50Z`
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
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`
`employee_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`


`employee`






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/f3c7931a-6a70-43be-9cfe-ad531e456fdd' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f3c7931a-6a70-43be-9cfe-ad531e456fdd",
    "type": "notes",
    "attributes": {
      "created_at": "2022-02-10T10:32:13+00:00",
      "updated_at": "2022-02-10T10:32:13+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "874f7045-443d-4a7f-bfbc-ebc1fb2b0546",
      "owner_type": "customers",
      "employee_id": "de9e45c7-8c51-4155-b87e-efdeb8863f13"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/874f7045-443d-4a7f-bfbc-ebc1fb2b0546"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/de9e45c7-8c51-4155-b87e-efdeb8863f13"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


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
          "owner_id": "6909e9f6-99ab-413e-b682-efd665b2153c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5299629a-f2da-437b-baa8-aba03e6265cd",
    "type": "notes",
    "attributes": {
      "created_at": "2022-02-10T10:32:13+00:00",
      "updated_at": "2022-02-10T10:32:13+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "6909e9f6-99ab-413e-b682-efd665b2153c",
      "owner_type": "customers",
      "employee_id": "05bda222-ab60-40be-af3d-4e9d284d7e71"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][body]` | **String**<br>The content of the note
`data[attributes][owner_id]` | **Uuid**<br>ID of the resource the note is attached to
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `documents`, `product_groups`, `bundles`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/e304aa9a-bfc9-40c9-9f27-e48f56f209df' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


### Includes

This request does not accept any includes
# Operations

Operations are long running tasks that support different actions like mutating data in bulk or generating artifacts (exports, reports, etc).
Once an operation has been started, it cannot be paused or cancelled. It's status however is observable.

An operation required the `operation_data` object to be set during creation. It contains the params required for initiating an operation and is validated quite strictly. The structure of the object looks as follows:

```json
{
  "type": "<operation_type>",
  "data": { ... }
}
```

The operation type determines what kind of operation is initiated. The nested data object also has required keys, but depends a lot on the type of the operation.

The following types & data params are supported:

#### Archive

Only orders that are have the status `stopped` can be archived. The target_ids with an invalid status will be ignored.

**Params**

```json
{
  "type": "archive",
  "data": {
    "target_type": "customer",
    "target_ids": [
      "123",
      "456"
    ]
  }
}
```

| Key                | Type          | Possible values         | Description                                                                                 |
|--------------------|---------------|-------------------------|---------------------------------------------------------------------------------------------|
| `type`             | String        | `archive`               | Required to start this specific operation.                                                  |
| `data.target_type` | String        | `customer`, `order`     | The type of resource that should be archived. Only one resource per operation is supported. |
| `data.target_ids`  | Array\<Uuid\> | `[{id}, {id}]`          | An array of primary keys for the entities that should be archived.                          |

**Artifact**

*None*

#### Consumable Tracking Migration

A one-off migration that converts untracked consumables to bulk tracked ones.

**Params**

```json
{
  "type": "consumable_tracking_migration",
  "data": {
    "target_type": "product_group",
    "target_ids": [
      "123",
      "456"
    ]
  }
}
```

| Key                | Type          | Possible values                   | Description                                                         |
|--------------------|---------------|-----------------------------------|---------------------------------------------------------------------|
| `type`             | String        | `consumable_tracking_migration`   | Required to start this specific operation.                          |
| `data.target_type` | String        | `product_group`                   | The type of resource that should be converted.                      |
| `data.target_ids`  | Array\<Uuid\> | `[{id}, {id}]`                    | An array of primary keys for the entities that should be converted. |

**Artifact**

*None*

#### Generate Barcode

Generates a barcode for all entities that are still missing one. Entities with existing barcodes are not modified and skipped.

**Params**

```json
{
  "type": "generate_barcode",
  "data": {
    "target_type": "customer",
    "target_ids": [
      "123",
      "456"
    ],
    "barcode_type": "code128"
  }
}
```

| Key                 | Type          | Possible values                                                | Description                                                                                                                 |
|---------------------|---------------|----------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| `type`              | String        | `generate_barcode`                                             | Required to start this specific operation.                                                                                  |
| `data.target_type`  | String        | `product`, `stock_item`, `customer`                            | The type of resource that should have its barcodes generated. Only one resource per operation is supported. |
| `data.target_ids`   | Array\<Uuid\> | `[{id}, {id}]`                                                 | An array of primary keys for the entities that should have its barcodes generated.                                          |
| `data.barcode_type` | String        | `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`     | The barcode type that should be generated for all entities.                          |

**Artifact**

*None*

#### Generate Document

Generates documents in bulk, either by a list of documents or all documents for specific orders.

**Params**

```json
{
  "type": "generate_document",
  "data": {
    "target_type": "document",
    "target_ids": [
      "123",
      "456"
    ],
    "document_type": "invoice",
    "document_extension": "pdf"
  }
}
```

| Key                       | Type          | Possible values                                    | Description                                                                                                     |
|---------------------------|---------------|----------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| `type`                    | String        | `generate_document`                                | Required to start this specific operation.                                                                      |
| `data.target_type`        | String        | `order`, `document`                                | The type of resource that should have its documents generated. Only one resource per operation is supported.    |
| `data.target_ids`         | Array\<Uuid\> | `[{id}, {id}]`                                     | An array of primary keys for the entities that should have its documents generated.                             |
| `data.document_type`      | String        | `packing_slip`, `invoice`, `quote`, `contract`     | The document type that should be generated for all entities. Only one document type per operation is supported. |
| `data.document_extension` | String        | `"pdf"`                                            | The filetype for the generated document.                                                                        |

**Artifact**

A zip file with the generated documents of type <document_extension>.

#### Update Category

Updates the categories associated to the entities by mutating them with the action. Other categories already associated to the entity are not modified.

**Params**

```json
{
  "type": "update_category",
  "data": {
    "target_type": "product_group",
    "target_ids": [
      "123",
      "456"
    ],
    "action": "add_entities",
    "category_ids": [
      "789",
      "101"
    ]
  }
}
```

| Key                 | Type          | Possible values                       | Description                                                                                                            |
|---------------------|---------------|---------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| `type`              | String        | `update_category`                     | Required to start this specific operation.                                                                             |
| `data.target_type`  | String        | `product_group`                       | The type of resource that should have the associated categories updated. Only one resource per operation is supported. |
| `data.target_ids`   | Array\<Uuid\> | `[{id}, {id}]`                        | An array of primary keys for the entities that should have the associated categories updated.                          |
| `data.action`       | String        | `add_entities`, `remove_entities`     | The action that should be executed on the categories of the entities.                                                  |
| `data.category_ids` | Array\<Uuid\> | `[{id}, {id}]`                        | The primary keys of the categories that should be used with the action.                                                |

**Artifact**

*None*

#### Update Tag

Updates the tags associated to the entities by mutating them with the action.

**Params**

```json
{
  "type": "update_tag",
  "data": {
    "target_type": "customer",
    "target_ids": [
      "123",
      "456"
    ],
    "action": "replace",
    "tags": [
      "Tag A",
      "Tag B"
    ]
  }
}
```

| Key                 | Type          | Possible values                              | Description                                                                                                      |
|---------------------|---------------|----------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| `type`              | String        | `update_tag`                                 | Required to start this specific operation.                                                                       |
| `data.target_type`  | String        | `product_group`, `customer`, `order`         | The type of resource that should have the associated tags updated. Only one resource per operation is supported. |
| `data.target_ids`   | Array\<Uuid\> | `[{id}, {id}]`                               | An array of primary keys for the entities that should have the associated tags updated.                          |
| `data.action`       | String        | `add`, `replace`, `remove`, `remove_all`     | The action that should be executed on the tags of the entities.                                                  |
| `data.tags`         | Array<String> | `[{tag}, {tag}]`                             | The tags that should be used with the action.                                                                    |

**Artifact**

*None*

#### Update

Updates the attribute of all the entities with the new value(s).

**Params**

```json
{
  "type": "update",
  "data": {
    "target_type": "customer",
    "target_ids": [
      "123",
      "456"
    ],
    "attributes": {
      "discount_percentage": 50,
      "tax_region_id": "789"
    }
  }
}
```

| Key                | Type          | Possible values                 | Description                                                                                 |
|--------------------|---------------|---------------------------------|---------------------------------------------------------------------------------------------|
| `type`             | String        | `update`                        | Required to start this specific operation.                                                  |
| `data.target_type` | String        | `product_group`, `customer`     | The type of resource that should be updated. Only one resource per operation is supported. |
| `data.target_ids`  | Array\<Uuid\> | `[{id}, {id}]`                  | An array of primary keys for the entities that should be updated.                          |
| `data.attributes`  | Object        | `{}`                            | The allowed keys for the attributes are listed below. |

Allowed attribute keys:

**Product group**

- `taxable`
- `tax_category_id`
- `lag_time`
- `lead_time`
- `price_type`
- `price_period`
- `flat_fee_price_in_cents`
- `structure_price_in_cents`
- `base_price_in_cents`
- `price_wrapper_id`
- `show_in_store`
- `discountable`
- `price_ruleset_id`

**Customer**

- `deposit_type`
- `deposit_value`
- `tax_region_id`
- `discount_percentage`

**Artifact**

*None*

## Endpoints
`GET /api/boomerang/operations`

`GET /api/boomerang/operations/{id}`

`POST /api/boomerang/operations`

## Fields
Every operation has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`status` | **String** `readonly`<br>One of `scheduled`, `in_progress`, `finished`, `failed`
`status_message` | **String** `readonly`<br>A UI-friendly string explaining the status & progress of the operation for the user.
`finished_at` | **Datetime** `readonly`<br>The moment when the operation is finished executing.
`description` | **String** `readonly`<br>Explains what the operation is doing in a short sentence.
`artifact` | **Hash** `readonly`<br>An object that returns an optional artifact of the operation. E.g. a file if the operation generates a report.
`error_data` | **Array** `readonly`<br>An array of strings with errors that happened during execution of the operation.
`error_count` | **Integer** `readonly`<br>The number of errors that happened during the execution. See `error_data`.
`employee_id` | **Uuid** `readonly`<br>The associated Employee
`operation_data` | **Hash** `extra`<br>An object with the params used to initiate the operation. See the description of the operation.


## Relationships
Operations have the following relationships:

Name | Description
- | -
`employee` | **Employees** `readonly`<br>Associated Employee


## Listing operations



> How to fetch a list of operations:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/operations' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e4fa7922-e249-40ff-9467-b5d237eaeca0",
      "type": "operations",
      "attributes": {
        "created_at": "2022-03-01T09:36:27+00:00",
        "updated_at": "2022-03-01T09:36:27+00:00",
        "status": "scheduled",
        "status_message": null,
        "finished_at": null,
        "description": null,
        "artifact": {
          "url": null
        },
        "error_data": [],
        "error_count": 0,
        "employee_id": "dfa2993a-1e31-413e-a426-7eb1efecaf8a"
      },
      "relationships": {
        "employee": {
          "links": {
            "related": "api/boomerang/employees/dfa2993a-1e31-413e-a426-7eb1efecaf8a"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/operations`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[operations]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-01T09:34:21Z`
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
`status` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`finished_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`employee_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`employee`






## Fetching an operation



> How to fetch an operation:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/operations/62fccec0-e15c-4ca3-b35c-b1d8b165bf00' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "62fccec0-e15c-4ca3-b35c-b1d8b165bf00",
    "type": "operations",
    "attributes": {
      "created_at": "2022-03-01T09:36:27+00:00",
      "updated_at": "2022-03-01T09:36:27+00:00",
      "status": "scheduled",
      "status_message": null,
      "finished_at": null,
      "description": null,
      "artifact": {
        "url": null
      },
      "error_data": [],
      "error_count": 0,
      "employee_id": "922c722b-cbb3-4a9b-adb3-5e498b7c824a"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/922c722b-cbb3-4a9b-adb3-5e498b7c824a"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/operations/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[operations]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`employee`






## Creating an operation

When creating an operation, it will start running in the background. With the `id` provided in the response, you can poll the `operations/{id}` endpoint to check its status.


> How to create an operation:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/operations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "operations",
        "attributes": {
          "operation_data": {
            "type": "archive",
            "data": {
              "target_type": "customer",
              "target_ids": [
                "123"
              ]
            }
          }
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e7a5a4b6-e3f9-42a3-b0fa-9a8ca3baced3",
    "type": "operations",
    "attributes": {
      "created_at": "2022-03-01T09:36:27+00:00",
      "updated_at": "2022-03-01T09:36:27+00:00",
      "status": "scheduled",
      "status_message": null,
      "finished_at": null,
      "description": "Archiving 0 customers",
      "artifact": {
        "url": null
      },
      "error_data": [],
      "error_count": 0,
      "employee_id": "27874a62-cee4-4c36-80bc-0c1e4a345543"
    },
    "relationships": {
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

`POST /api/boomerang/operations`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[operations]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][operation_data]` | **Hash**<br>An object with the params used to initiate the operation. See the description of the operation.


### Includes

This request accepts the following includes:

`employee`






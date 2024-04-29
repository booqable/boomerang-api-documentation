# Operations

Operations are long running tasks that are used to mutate data in bulk
or to generate artifacts like exports or documents. Once an operation
has been started it cannot be paused or cancelled. However, the status of an
operation status can be requested.

An operation requires the `operation_data` object to be set during creation.
It contains the parameters required for initiating the operation and is validated
strictly. The structure of the object is as follows:

```json
"operation_data": {
  "type": "<operation_type>",
  "data": { ... }
}
```

The operation type determines what kind of operation is started. The nested
data object has required keys, depending on the type of the operation.

The following operation types are supported:

  - `archive`
  - `generate_barcode`
  - `generate_document`
  - `update_category`
  - `update_tag`
  - `export`
  - `update`

## Archive

Only orders that have the status `stopped` can be archived.
Orders with any other status will be ignored.

**Params**

```json
"operation_data": {
  "type": "archive",
  "data": {
    "target_type": "customers",
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
| `data.target_type` | String        | `customers`, `orders`   | The type of resource that should be archived. Only one resource per operation is supported. |
| `data.target_ids`  | Array\<Uuid\> | `[{id}, {id}]`          | An array of primary keys for the entities that should be archived.                          |

**Artifact**

_No artifacts are generated when archiving._

## Generate Barcode

Generates a barcode for all entities that do not have a barcode. Entities that already have a barcode are skipped.

**Params**

```json
"operation_data": {
  "type": "generate_barcode",
  "data": {
    "target_type": "customers",
    "target_ids": [
      "123",
      "456"
    ],
    "barcode_type": "code128"
  }
}
```

| Key                    | Type            | Possible values                                                | Description                                                                                              |
|------------------------|-----------------|----------------------------------------------------------------|----------------------------------------------------------------------------------------------------------|
| `type`                 | String          | `generate_barcode`                                             | Required to start this specific operation.                                                               |
| `data.target_type`     | String          | `customers`, `product_groups`                                  | The type of resource that barcodes should be generated for.                                              |
| `data.for`             | String          | `stock_items`, `products`                                      | For `product_groups` only, this indicates whether to add barcodes to either `products` or `stock_items`. |
| `data.target_ids`      | Array\<Uuid\>   | `[{id}, {id}]`                                                 | An array of primary keys for the entities that should have its barcodes generated.                       |
| `data.barcode_type`    | String          | `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`     | The barcode type that should be generated for all entities.                                              |

**Artifact**

_No artifacts are generated when generating barcodes._

## Generate Document

Generates documents in bulk, either by a list of documents or all documents for specific orders.

**Params**

```json
"operation_data":{
  "type": "generate_document",
  "data": {
    "target_type": "documents",
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
| `data.target_type`        | String        | `orders`, `documents`                              | The type of resource that should have its documents generated. Only one resource per operation is supported.    |
| `data.target_ids`         | Array\<Uuid\> | `[{id}, {id}]`                                     | An array of primary keys for the entities that should have its documents generated.                             |
| `data.document_type`      | String        | `packing_slip`, `invoice`, `quote`, `contract`     | The document type that should be generated for all entities. Only one document type per operation is supported. |
| `data.document_extension` | String        | `"pdf"`                                            | The filetype for the generated document.                                                                        |

**Artifact**

A zip file with the generated documents of type <document_extension>.

## Update Category

Updates the categories associated to the entities by mutating them with the action. Other categories already associated to the entity are not modified.

**Params**

```json
"operation_data": {
  "type": "update_category",
  "data": {
    "target_type": "product_groups",
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
| `data.target_type`  | String        | `product_groups`                      | The type of resource that should have the associated categories updated. Only one resource per operation is supported. |
| `data.target_ids`   | Array\<Uuid\> | `[{id}, {id}]`                        | An array of primary keys for the entities that should have the associated categories updated.                          |
| `data.action`       | String        | `add_entities`, `remove_entities`     | The action that should be executed on the categories of the entities.                                                  |
| `data.category_ids` | Array\<Uuid\> | `[{id}, {id}]`                        | The primary keys of the categories that should be used with the action.                                                |

**Artifact**

_No artifacts are generated when updating categories._

## Update Tag

Updates the tags associated to the entities by mutating them with the action.

**Params**

```json
"operation_data": {
  "type": "update_tag",
  "data": {
    "target_type": "customers",
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
| `data.target_type`  | String        | `product_groups`, `customers`, `orders`      | The type of resource that should have the associated tags updated. Only one resource per operation is supported. |
| `data.target_ids`   | Array\<Uuid\> | `[{id}, {id}]`                               | An array of primary keys for the entities that should have the associated tags updated.                          |
| `data.action`       | String        | `add`, `replace`, `remove`, `remove_all`     | The action that should be executed on the tags of the entities.                                                  |
| `data.tags`         | Array<String> | `[{tag}, {tag}]`                             | The tags that should be used with the action.                                                                    |

**Artifact**

_No artifacts are generated when updating tags._

## Export

Exports data as CSV.

**Params**

```json
"operation_data": {
  "type": "export",
  "data": {
    "target_type": "customers",
    "target_ids": [
      "123",
      "456"
    ]
  }
}
```

| Key                 | Type          | Possible values                                                                                                               | Description                                                                                                      |
|---------------------|---------------|-------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| `type`              | String        | `export`                                                                                                                      | Required to start this specific operation.                                                                       |
| `data.target_type`  | String        | `product_groups`, `bundles`, `customers`, `orders`, `documents`, `report_rentals`, `report_consumables`, 'report_stock_items' | The type of resource that should have the associated tags updated. Only one resource per operation is supported. |
| `data.target_ids`   | Array\<Uuid\> | `[{id}, {id}]`                                                                                                                | An array of primary keys for the entities that should have the associated tags updated.                          |

**Artifact**

A CSV file containing the exported data.

## Update

Updates the attribute of all the entities with the new value(s).

**Params**

```json
"operation_data": {
  "type": "update",
  "data": {
    "target_type": "customers",
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
| `data.target_type` | String        | `product_groups`, `customers`   | The type of resource that should be updated. Only one resource per operation is supported.  |
| `data.target_ids`  | Array\<Uuid\> | `[{id}, {id}]`                  | An array of primary keys for the entities that should be updated.                           |
| `data.attributes`  | Object        | `{}`                            | The allowed keys for the attributes are listed below.                                       |

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
- `price_structure_id`
- `show_in_store`
- `discountable`
- `price_ruleset_id`

**Customer**

- `deposit_type`
- `deposit_value`
- `tax_region_id`
- `discount_percentage`

**Artifacts**

_No artifacts are generated when bullk updating resources._

## Endpoints
`POST /api/boomerang/operations`

`GET /api/boomerang/operations/{id}`

`GET /api/boomerang/operations`

## Fields
Every operation has the following fields:

Name | Description
-- | --
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
`operation_data` | **Hash** <br>An object with the params used to initiate the operation. See the description of the operation.


## Relationships
Operations have the following relationships:

Name | Description
-- | --
`employee` | **Employees** `readonly`<br>Associated Employee


## Creating an operation



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
              "target_type": "customers",
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
    "id": "ef9d4bdd-d8bd-4e62-b428-d26ea2a3c15d",
    "type": "operations",
    "attributes": {
      "created_at": "2024-04-29T09:25:53+00:00",
      "updated_at": "2024-04-29T09:25:53+00:00",
      "status": "scheduled",
      "status_message": null,
      "finished_at": null,
      "description": "Archiving customers",
      "artifact": {
        "url": null
      },
      "error_data": [],
      "error_count": 0,
      "employee_id": "851a227b-9636-4917-93b6-ee9f3f055477"
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[operations]=created_at,updated_at,status`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][operation_data]` | **Hash** <br>An object with the params used to initiate the operation. See the description of the operation.


### Includes

This request accepts the following includes:

`employee`






## Fetching an operation



> How to fetch an operation:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/operations/1d62236a-306f-499c-9a6b-fc061e108946' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1d62236a-306f-499c-9a6b-fc061e108946",
    "type": "operations",
    "attributes": {
      "created_at": "2024-04-29T09:25:55+00:00",
      "updated_at": "2024-04-29T09:25:55+00:00",
      "status": "scheduled",
      "status_message": null,
      "finished_at": null,
      "description": null,
      "artifact": {
        "url": null
      },
      "error_data": [],
      "error_count": 0,
      "employee_id": "13bc20c4-16d6-4359-92d3-ff96e7bb0ef3"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/13bc20c4-16d6-4359-92d3-ff96e7bb0ef3"
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[operations]=created_at,updated_at,status`


### Includes

This request accepts the following includes:

`employee`






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
      "id": "3721fec0-cc0c-4bc4-a1b3-49cf61b9cdf5",
      "type": "operations",
      "attributes": {
        "created_at": "2024-04-29T09:25:56+00:00",
        "updated_at": "2024-04-29T09:25:56+00:00",
        "status": "scheduled",
        "status_message": null,
        "finished_at": null,
        "description": null,
        "artifact": {
          "url": null
        },
        "error_data": [],
        "error_count": 0,
        "employee_id": "05a51314-cb50-4e42-a593-c102369a2f5d"
      },
      "relationships": {
        "employee": {
          "links": {
            "related": "api/boomerang/employees/05a51314-cb50-4e42-a593-c102369a2f5d"
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[operations]=created_at,updated_at,status`
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
`status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`finished_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`employee_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`employee`






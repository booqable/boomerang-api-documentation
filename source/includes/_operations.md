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
  - `update_collections`
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

## Update Collection

Updates the collections associated to the entities by mutating them with the action. Other collections already associated to the entity are not modified.

**Params**

```json
"operation_data": {
  "type": "update_collections",
  "data": {
    "target_type": "product_groups",
    "target_ids": [
      "123",
      "456"
    ],
    "action": "add_entities",
    "collection_ids": [
      "789",
      "101"
    ]
  }
}
```

| Key                   | Type          | Possible values                       | Description                                                                                                             |
|-----------------------|---------------|---------------------------------------|-------------------------------------------------------------------------------------------------------------------------|
| `type`                | String        | `update_collections`                  | Required to start this specific operation.                                                                              |
| `data.target_type`    | String        | `product_groups`                      | The type of resource that should have the associated collections updated. Only one resource per operation is supported. |
| `data.target_ids`     | Array\<Uuid\> | `[{id}, {id}]`                        | An array of primary keys for the entities that should have the associated collections updated.                          |
| `data.action`         | String        | `add_entities`, `remove_entities`     | The action that should be executed on the collections of the entities.                                                  |
| `data.collection_ids` | Array\<Uuid\> | `[{id}, {id}]`                        | The primary keys of the collections that should be used with the action.                                                |

**Artifact**

_No artifacts are generated when updating collections._

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
`GET /api/boomerang/operations`

`GET /api/boomerang/operations/{id}`

`POST /api/boomerang/operations`

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
      "id": "bf01fede-4c3c-41fa-9943-6e74d66e6051",
      "type": "operations",
      "attributes": {
        "created_at": "2024-10-28T09:29:11.480124+00:00",
        "updated_at": "2024-10-28T09:29:11.480124+00:00",
        "status": "scheduled",
        "status_message": null,
        "finished_at": null,
        "description": null,
        "artifact": {
          "url": null
        },
        "error_data": [],
        "error_count": 0,
        "employee_id": "ad139932-b3e7-4d8f-8127-a2391110d3e6"
      },
      "relationships": {}
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






## Fetching an operation



> How to fetch an operation:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/operations/6b41d2ea-b5d0-439e-9307-0457840df1f9' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6b41d2ea-b5d0-439e-9307-0457840df1f9",
    "type": "operations",
    "attributes": {
      "created_at": "2024-10-28T09:29:11.984549+00:00",
      "updated_at": "2024-10-28T09:29:11.984549+00:00",
      "status": "scheduled",
      "status_message": null,
      "finished_at": null,
      "description": null,
      "artifact": {
        "url": null
      },
      "error_data": [],
      "error_count": 0,
      "employee_id": "86218dcf-8208-43a9-9fed-3110b05ea797"
    },
    "relationships": {}
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
    "id": "ffa9e110-efb0-4118-b789-eda02d809e44",
    "type": "operations",
    "attributes": {
      "created_at": "2024-10-28T09:29:12.546853+00:00",
      "updated_at": "2024-10-28T09:29:12.546853+00:00",
      "status": "scheduled",
      "status_message": null,
      "finished_at": null,
      "description": "Archiving customers",
      "artifact": {
        "url": null
      },
      "error_data": [],
      "error_count": 0,
      "employee_id": "c8642d4d-7d40-444c-8802-5ac10e93a381"
    },
    "relationships": {}
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






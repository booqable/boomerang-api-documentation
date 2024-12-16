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

  - [`archive`](#operations-archive)
  - [`generate_barcode`](#operations-generate-barcode)
  - [`generate_document`](#operations-generate-document)
  - [`update_collections`](#operations-update-collections)
  - [`update_tag`](#operations-update-tag)
  - [`export`](#operations-export)
  - [`update`](#operations-update)

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
| `type`             | string        | `archive`               | Required to start this specific operation.                                                  |
| `data.target_type` | string        | `customers`, `orders`   | The type of resource that should be archived. Only one resource per operation is supported. |
| `data.target_ids`  | array[uuid]   | `[{id}, {id}]`          | An array of primary keys for the entities that should be archived.                          |

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
| `type`                 | string          | `generate_barcode`                                             | Required to start this specific operation.                                                               |
| `data.target_type`     | string          | `customers`, `product_groups`                                  | The type of resource that barcodes should be generated for.                                              |
| `data.for`             | string          | `stock_items`, `products`                                      | For `product_groups` only, this indicates whether to add barcodes to either `products` or `stock_items`. |
| `data.target_ids`      | array[uuid]     | `[{id}, {id}]`                                                 | An array of primary keys for the entities that should have its barcodes generated.                       |
| `data.barcode_type`    | string          | `code39`, `code93`, `code128`, `ean8`, `ean13`, `qr_code`     | The barcode type that should be generated for all entities.                                              |

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
| `type`                    | string        | `generate_document`                                | Required to start this specific operation.                                                                      |
| `data.target_type`        | string        | `orders`, `documents`                              | The type of resource that should have its documents generated. Only one resource per operation is supported.    |
| `data.target_ids`         | array[uuid]   | `[{id}, {id}]`                                     | An array of primary keys for the entities that should have its documents generated.                             |
| `data.document_type`      | string        | `packing_slip`, `invoice`, `quote`, `contract`     | The document type that should be generated for all entities. Only one document type per operation is supported. |
| `data.document_extension` | string        | `"pdf"`                                            | The filetype for the generated document.                                                                        |

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
| `type`                | string        | `update_collections`                  | Required to start this specific operation.                                                                              |
| `data.target_type`    | string        | `product_groups`                      | The type of resource that should have the associated collections updated. Only one resource per operation is supported. |
| `data.target_ids`     | array[uuid]   | `[{id}, {id}]`                        | An array of primary keys for the entities that should have the associated collections updated.                          |
| `data.action`         | string        | `add_entities`, `remove_entities`     | The action that should be executed on the collections of the entities.                                                  |
| `data.collection_ids` | array[uuid]   | `[{id}, {id}]`                        | The primary keys of the collections that should be used with the action.                                                |

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
| `type`              | string        | `update_tag`                                 | Required to start this specific operation.                                                                       |
| `data.target_type`  | string        | `product_groups`, `customers`, `orders`      | The type of resource that should have the associated tags updated. Only one resource per operation is supported. |
| `data.target_ids`   | array[uuid]   | `[{id}, {id}]`                               | An array of primary keys for the entities that should have the associated tags updated.                          |
| `data.action`       | string        | `add`, `replace`, `remove`, `remove_all`     | The action that should be executed on the tags of the entities.                                                  |
| `data.tags`         | array[string] | `[{tag}, {tag}]`                             | The tags that should be used with the action.                                                                    |

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
| `type`              | string        | `export`                                                                                                                      | Required to start this specific operation.                                                                       |
| `data.target_type`  | string        | `product_groups`, `bundles`, `customers`, `orders`, `documents`, `report_rentals`, `report_consumables`, 'report_stock_items' | The type of resource that should have the associated tags updated. Only one resource per operation is supported. |
| `data.target_ids`   | array[uuid]   | `[{id}, {id}]`                                                                                                                | An array of primary keys for the entities that should have the associated tags updated.                          |

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
| `type`             | string        | `update`                        | Required to start this specific operation.                                                  |
| `data.target_type` | string        | `product_groups`, `customers`   | The type of resource that should be updated. Only one resource per operation is supported.  |
| `data.target_ids`  | array[uuid]   | `[{id}, {id}]`                  | An array of primary keys for the entities that should be updated.                           |
| `data.attributes`  | hash          | `{}`                            | The allowed keys for the attributes are listed below.                                       |

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

## Relationships
Name | Description
-- | --
`employee` | **[Employee](#employees)** `required`<br>Employee who started this operation.


Check matching attributes under [Fields](#operations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`artifact` | **hash** `readonly`<br>An object that returns an optional artifact of the operation. E.g. a file if the operation generates a report.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`description` | **string** `readonly`<br>Explains what the operation is doing in a short sentence.
`employee_id` | **uuid** `readonly`<br>Employee who started this operation.
`error_count` | **integer** `readonly`<br>The number of errors that happened during the execution. See `error_data`.
`error_data` | **array** `readonly`<br>An array of strings with errors that happened during execution of the operation.
`finished_at` | **datetime** `readonly`<br>The moment when the operation is finished executing.
`id` | **uuid** `readonly`<br>Primary key.
`operation_data` | **hash** `extra`<br>An object with the params used to initiate the operation. See the description of the operation.
`status` | **enum** `readonly`<br>Status of the operation.<br>One of: `scheduled`, `in_progress`, `finished`, `failed`.
`status_message` | **string** `readonly`<br>A UI-friendly string explaining the status & progress of the operation for the user.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Listing operations


> How to fetch a list of operations:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/operations'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "9743db3e-9ee4-4698-8b36-271c5cce0cae",
        "type": "operations",
        "attributes": {
          "created_at": "2028-06-20T00:46:03.000000+00:00",
          "updated_at": "2028-06-20T00:46:03.000000+00:00",
          "status": "scheduled",
          "status_message": null,
          "finished_at": null,
          "description": null,
          "artifact": {
            "url": null
          },
          "error_data": [],
          "error_count": 0,
          "employee_id": "1f72296c-c318-4620-876c-04ded6372403"
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
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[operations]=operation_data`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[operations]=created_at,updated_at,status`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=employee`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`employee_id` | **uuid** <br>`eq`, `not_eq`
`finished_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`status` | **string_enum** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`employee`






## Fetching an operation


> How to fetch an operation:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/operations/21cd9837-0ca6-4027-8d44-f8d6cddf837a'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "21cd9837-0ca6-4027-8d44-f8d6cddf837a",
      "type": "operations",
      "attributes": {
        "created_at": "2025-05-06T18:20:02.000000+00:00",
        "updated_at": "2025-05-06T18:20:02.000000+00:00",
        "status": "scheduled",
        "status_message": null,
        "finished_at": null,
        "description": null,
        "artifact": {
          "url": null
        },
        "error_data": [],
        "error_count": 0,
        "employee_id": "d34a229e-27f9-4c09-8713-c9953f649dec"
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
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[operations]=operation_data`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[operations]=created_at,updated_at,status`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=employee`


### Includes

This request accepts the following includes:

`employee`






## Creating an operation


> How to create an operation:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/operations'
       --header 'content-type: application/json'
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
      "id": "d7d16a03-4906-49e1-86d5-3fb510a8faa2",
      "type": "operations",
      "attributes": {
        "created_at": "2027-06-06T03:49:00.000000+00:00",
        "updated_at": "2027-06-06T03:49:00.000000+00:00",
        "status": "scheduled",
        "status_message": null,
        "finished_at": null,
        "description": "Archiving customers",
        "artifact": {
          "url": null
        },
        "error_data": [],
        "error_count": 0,
        "employee_id": "828bf697-dcfa-4f1f-8d73-6a0f62925dce"
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
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[operations]=operation_data`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[operations]=created_at,updated_at,status`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=employee`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][operation_data]` | **hash** <br>An object with the params used to initiate the operation. See the description of the operation.


### Includes

This request accepts the following includes:

`employee`






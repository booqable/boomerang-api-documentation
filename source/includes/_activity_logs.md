# Activity logs

Activity logs describe an event where changes took place in our database. Examples of such events can be an order that was created or placed, a product name that changed, a custoemr that was added or an e-mail that got sent. 

Activity logs contain `action_key` and `action_args`, which determine the summary line, and `data` which contains a copy of or details about the subject that the event is about, such as a order, product, customer or e-mail.

## Endpoints
`GET /api/boomerang/activity_logs`

`GET /api/boomerang/activity_logs/{id}`

## Fields
Every activity log has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`action_key` | **String** <br>The name of the event that the activity log describes. This determines which translated summary line will be displayed in the web client. Examples are "product.created" or "order.updated".
`action_args` | **Hash** <br>Arguments that can be passed to enrich the summary line of the web client with details, such as a product name.
`has_data` | **Boolean** `readonly`<br>Boolean value flag indicating whether this activity log contains additional data describing the subject of the event.
`owner_id` | **Uuid** <br>ID of the subject the event is about.
`owner_type` | **String** <br>Class of the subject the event is about
`employee_id` | **Uuid** <br>The associated Employee
`data` | **Hash** `readonly`<br>Hash containing (details on) the subject(s) of the event this activity log describes. The subject(s) are contained in individual arrays grouped by their type. For example: { products: [{ id: 1, name: 'Product 1'}] } 


## Relationships
Activity logs have the following relationships:

Name | Description
-- | --
`owner` | **Customer, Product, Product group, Stock item, Bundle, Order, Document, Email**<br>Associated Owner
`employee` | **Employees** `readonly`<br>Associated Employee


## Listing activity logs



> How to fetch a list of activity logs:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/activity_logs' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "668e021e-c1d1-4f29-81c5-f6f04a7c02dd",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-12-18T09:21:15+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "e5b5070f-7dd9-4d81-b343-2bd78fd37bfd",
        "owner_type": "orders",
        "employee_id": "2ae33036-66c8-49c9-9538-9f11a2a12f48"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/e5b5070f-7dd9-4d81-b343-2bd78fd37bfd"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/2ae33036-66c8-49c9-9538-9f11a2a12f48"
          }
        }
      }
    },
    {
      "id": "9f12b766-ab2a-4474-93bb-0c88c104131e",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-12-18T09:21:15+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "8dd8130a-23c9-4214-8f5a-bded1bb3d793",
        "owner_type": "orders",
        "employee_id": "a93db9d7-bb33-44da-8fea-5cd385a2f13f"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/8dd8130a-23c9-4214-8f5a-bded1bb3d793"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/a93db9d7-bb33-44da-8fea-5cd385a2f13f"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/activity_logs`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[activity_logs]=created_at,updated_at,action_key`
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
`action_key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`
`employee_id` | **Uuid** <br>`eq`, `not_eq`
`relation_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`


`employee`






## Fetching an activity log



> How to fetch an activity log:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/activity_logs/a3c66b86-1611-42ea-927c-2000d7559ce2' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a3c66b86-1611-42ea-927c-2000d7559ce2",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-12-18T09:21:16+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "5d9b2724-a791-47f2-ab8d-0f7eb404e329",
            "legacy_id": null,
            "name": "Product 1000077",
            "quantity": 0,
            "created_at": "2023-12-18T09:21:15.970Z",
            "updated_at": "2023-12-18T09:21:15.970Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000080",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000077",
            "has_variations": false,
            "variation": false,
            "variation_name": null,
            "variation_values": [],
            "variation_fields": null,
            "price_type": "simple",
            "price_period": "hour",
            "stock_item_properties": null,
            "archived_at": null,
            "stock_count": 0,
            "extra_information": null,
            "photo": null,
            "photo_url": null,
            "flat_fee_price_in_cents": 0,
            "structure_price_in_cents": 0,
            "deposit_in_cents": 0,
            "company_id": "523e1e00-ebb5-4ad3-8212-711268c86cff",
            "item_group_id": "eafd34e5-f1e1-4983-95dc-192ae312f41c",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000077",
            "description": null,
            "show_in_store": true,
            "product_type": "rental",
            "tracking_type": "bulk",
            "discountable": true,
            "taxable": true,
            "allow_shortage": false,
            "shortage_limit": 0,
            "photo_id": null,
            "price_ruleset_id": null,
            "sorting_weight": 1,
            "price_structure_id": null,
            "seo_title": null,
            "seo_description": null,
            "cached_tag_list": null
          }
        ]
      },
      "owner_id": "f78689a1-6e65-4bf0-ba31-c7f5625b80ea",
      "owner_type": "orders",
      "employee_id": "c5355672-b3a6-44ba-aa5a-975ef926bdd7"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/f78689a1-6e65-4bf0-ba31-c7f5625b80ea"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/c5355672-b3a6-44ba-aa5a-975ef926bdd7"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/activity_logs/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[activity_logs]=created_at,updated_at,action_key`


### Includes

This request accepts the following includes:

`owner`


`employee`






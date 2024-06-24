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
      "id": "a9b2a0ba-2326-47ba-b186-5ad3f2d9f5f2",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-06-24T09:54:38.573145+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "1e978535-a423-4e84-bc4f-12cb4561bb19",
        "owner_type": "orders",
        "employee_id": "a28d3e56-2838-4b52-8234-47c403074f5a"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/1e978535-a423-4e84-bc4f-12cb4561bb19"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/a28d3e56-2838-4b52-8234-47c403074f5a"
          }
        }
      }
    },
    {
      "id": "df9da2aa-c990-4422-9be6-9d6a21b30585",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-06-24T09:54:38.326686+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "5c936de5-9026-4096-9277-0e59f528415a",
        "owner_type": "orders",
        "employee_id": "178e5c3d-b315-41e1-b308-a4d2f2de1daf"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/5c936de5-9026-4096-9277-0e59f528415a"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/178e5c3d-b315-41e1-b308-a4d2f2de1daf"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/e9d1d68e-8980-49ad-8f25-7280f0f3a97f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e9d1d68e-8980-49ad-8f25-7280f0f3a97f",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-06-24T09:54:37.129496+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "b7d70f4c-04e0-41af-8cd9-cfae154cc0b1",
            "legacy_id": null,
            "name": "Product 1000070",
            "quantity": 0,
            "created_at": "2024-06-24T09:54:36.957Z",
            "updated_at": "2024-06-24T09:54:36.957Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000073",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000070",
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
            "company_id": "c1c960f9-6b7b-477d-848c-6e8f2e201a0c",
            "item_group_id": "95db6a4c-2310-4499-a630-2bb73fb301fd",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000070",
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
      "owner_id": "d64bed3a-411f-4714-b3ca-932892ab5dc8",
      "owner_type": "orders",
      "employee_id": "683df7f1-9dd5-44bf-af3a-8a898967299f"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/d64bed3a-411f-4714-b3ca-932892ab5dc8"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/683df7f1-9dd5-44bf-af3a-8a898967299f"
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






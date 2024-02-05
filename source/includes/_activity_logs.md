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
      "id": "bfb4a470-b69e-4870-87b8-110a8488dd1a",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-02-05T09:17:33+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "9a21508c-82ad-4a15-8835-c9ebb2d6f694",
        "owner_type": "orders",
        "employee_id": "06b73718-60af-4920-8924-6b54ff267601"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/9a21508c-82ad-4a15-8835-c9ebb2d6f694"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/06b73718-60af-4920-8924-6b54ff267601"
          }
        }
      }
    },
    {
      "id": "ea66cf16-8a5e-48c2-8334-b87faff0bd27",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-02-05T09:17:33+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "ddf8293d-0de8-4107-b3ab-a0e5d9295831",
        "owner_type": "orders",
        "employee_id": "58785f87-6e0d-45c0-a0c9-b0d303fd6c47"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/ddf8293d-0de8-4107-b3ab-a0e5d9295831"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/58785f87-6e0d-45c0-a0c9-b0d303fd6c47"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/b9428ed3-f043-4992-bf12-89ba7189caa4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b9428ed3-f043-4992-bf12-89ba7189caa4",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-02-05T09:17:34+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "3e89fef7-59d9-488a-9a50-c083a26d2714",
            "legacy_id": null,
            "name": "Product 1000047",
            "quantity": 0,
            "created_at": "2024-02-05T09:17:34.514Z",
            "updated_at": "2024-02-05T09:17:34.514Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000050",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000047",
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
            "company_id": "115ac8bb-ccf4-4665-8532-f7a33e878e41",
            "item_group_id": "ce353973-db11-4f40-b2f1-840d5a6a9fb7",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000047",
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
      "owner_id": "69826e29-c745-416c-89f3-cc1e0f09c9ef",
      "owner_type": "orders",
      "employee_id": "830e1689-655c-4c23-9f43-0441aa75da84"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/69826e29-c745-416c-89f3-cc1e0f09c9ef"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/830e1689-655c-4c23-9f43-0441aa75da84"
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






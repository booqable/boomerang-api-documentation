# Activity logs

Activity logs describe an event where changes took place in our database. Examples of such events can be an order that was created or placed, a product name that changed, a custoemr that was added or an e-mail that got sent. 

Activity logs contain `action_key` and `action_args`, which determine the summary line, and `data` which contains a copy of or details about the subject that the event is about, such as a order, product, customer or e-mail.

## Endpoints
`GET /api/boomerang/activity_logs/{id}`

`GET /api/boomerang/activity_logs`

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


## Fetching an activity log



> How to fetch an activity log:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/activity_logs/65299b90-2103-4c11-b286-a0531ba7311c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "65299b90-2103-4c11-b286-a0531ba7311c",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-12-07T13:55:16+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "987e91de-ae04-4f3c-9af3-5dda998c3dff",
            "legacy_id": null,
            "name": "Product 1000003",
            "quantity": 0,
            "created_at": "2023-12-07T13:55:16.100Z",
            "updated_at": "2023-12-07T13:55:16.100Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000003",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000003",
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
            "company_id": "a0cd7446-9310-4d1c-942a-b07d171332cf",
            "item_group_id": "07662fa7-2796-49f4-8448-6446deac0dbe",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000003",
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
      "owner_id": "10f7ce19-9da5-4160-a723-0ab363ea8ea1",
      "owner_type": "orders",
      "employee_id": "988a6ad9-a222-4afa-a2d4-f3331e7cdfa5"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/10f7ce19-9da5-4160-a723-0ab363ea8ea1"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/988a6ad9-a222-4afa-a2d4-f3331e7cdfa5"
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
      "id": "9aa8fb2e-fdd0-4248-9f93-7995a3385f3d",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-12-07T13:55:17+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "d25f4532-1e80-4b32-8fca-7cef8dd3a4f1",
        "owner_type": "orders",
        "employee_id": "0a88cb12-91d0-4606-8851-b8ed3c319474"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/d25f4532-1e80-4b32-8fca-7cef8dd3a4f1"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/0a88cb12-91d0-4606-8851-b8ed3c319474"
          }
        }
      }
    },
    {
      "id": "fd725ccb-540a-43a8-8160-a47abb2fe85e",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-12-07T13:55:17+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "e03a5b63-33b0-4b41-854c-34d9e913ab56",
        "owner_type": "orders",
        "employee_id": "bd165a25-7281-4f16-af17-7e9046a119ad"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/e03a5b63-33b0-4b41-854c-34d9e913ab56"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/bd165a25-7281-4f16-af17-7e9046a119ad"
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






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
      "id": "103a6a23-c262-4ea2-8505-a88ab97b96b5",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-01-29T09:15:30+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "965f7a30-18ad-48c3-ad48-1fea9c85152a",
        "owner_type": "orders",
        "employee_id": "552d9899-6955-413e-b58a-97464eafb9c1"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/965f7a30-18ad-48c3-ad48-1fea9c85152a"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/552d9899-6955-413e-b58a-97464eafb9c1"
          }
        }
      }
    },
    {
      "id": "dd02f872-c44d-45e9-9ce6-ddf776e93390",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-01-29T09:15:30+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "afda673d-ad74-4f7e-8dc6-613e4d7f95be",
        "owner_type": "orders",
        "employee_id": "84cfcb9a-4062-4875-8362-b659baf22449"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/afda673d-ad74-4f7e-8dc6-613e4d7f95be"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/84cfcb9a-4062-4875-8362-b659baf22449"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/06f5422d-c63f-4e16-9138-83e78baf52db' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "06f5422d-c63f-4e16-9138-83e78baf52db",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-01-29T09:15:31+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "04fc4229-4d15-4db1-a6e1-ca49bb5f33c7",
            "legacy_id": null,
            "name": "Product 1000008",
            "quantity": 0,
            "created_at": "2024-01-29T09:15:31.082Z",
            "updated_at": "2024-01-29T09:15:31.082Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000008",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000008",
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
            "company_id": "53eceb3f-3bf3-4097-b457-b983995dff63",
            "item_group_id": "252b3109-2713-40e0-a33b-7300f0a18ab7",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000008",
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
      "owner_id": "d2a04d84-6245-479a-a901-3ee8c6705179",
      "owner_type": "orders",
      "employee_id": "0183eb09-2630-4af2-880b-9a8af7a09687"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/d2a04d84-6245-479a-a901-3ee8c6705179"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/0183eb09-2630-4af2-880b-9a8af7a09687"
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






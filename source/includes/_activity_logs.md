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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/a0799247-d31c-47b8-8fd6-0ae6602998c9' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a0799247-d31c-47b8-8fd6-0ae6602998c9",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-03-11T09:15:16+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "7ceeeb23-86ae-4845-867e-e93e16aec3dd",
            "legacy_id": null,
            "name": "Product 1000045",
            "quantity": 0,
            "created_at": "2024-03-11T09:15:16.561Z",
            "updated_at": "2024-03-11T09:15:16.561Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000045",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000045",
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
            "company_id": "d6cea1c2-89c9-4ee9-87cb-cb31fb5e6466",
            "item_group_id": "9254ce21-39c1-4456-b438-ab007e7f1460",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000045",
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
      "owner_id": "92c8f54f-c342-4063-8a64-5fe891e1134c",
      "owner_type": "orders",
      "employee_id": "3a55fa41-f1e9-4751-9db0-3832cb88a755"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/92c8f54f-c342-4063-8a64-5fe891e1134c"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/3a55fa41-f1e9-4751-9db0-3832cb88a755"
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
      "id": "89d0cae3-59c8-4736-a872-176244682f57",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-03-11T09:15:18+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "08e35a47-1b2f-40f0-bb8d-b4ae81f4acdd",
        "owner_type": "orders",
        "employee_id": "adb32861-1679-42b8-826b-9521d9672e65"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/08e35a47-1b2f-40f0-bb8d-b4ae81f4acdd"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/adb32861-1679-42b8-826b-9521d9672e65"
          }
        }
      }
    },
    {
      "id": "8a3ba455-531b-40dc-bca6-40782780f7df",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-03-11T09:15:18+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "de07bd8d-b68e-42c3-af1a-b8c03c5a0551",
        "owner_type": "orders",
        "employee_id": "22184fbe-f303-4218-a886-c38c66c34920"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/de07bd8d-b68e-42c3-af1a-b8c03c5a0551"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/22184fbe-f303-4218-a886-c38c66c34920"
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






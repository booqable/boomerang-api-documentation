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
      "id": "4e9d1a2e-a5a0-444f-9a91-2d33765f7d85",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-03-04T09:14:54+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "57086193-f6ef-4efc-b645-a06abe740581",
        "owner_type": "orders",
        "employee_id": "56789c64-eae3-46fa-903a-0e6230eb920b"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/57086193-f6ef-4efc-b645-a06abe740581"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/56789c64-eae3-46fa-903a-0e6230eb920b"
          }
        }
      }
    },
    {
      "id": "96ddff25-c797-43fe-b127-6a5878d69228",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-03-04T09:14:54+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "139eca4d-e6d7-4610-92d2-36145e584a6a",
        "owner_type": "orders",
        "employee_id": "e8b1867c-d1a7-4060-9649-6afe64037b05"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/139eca4d-e6d7-4610-92d2-36145e584a6a"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/e8b1867c-d1a7-4060-9649-6afe64037b05"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/e3c07da2-caee-4b41-a25c-da1a19544a84' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e3c07da2-caee-4b41-a25c-da1a19544a84",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-03-04T09:14:55+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "3f9b7b19-adc1-4eb3-8fb3-7000df3fb38f",
            "legacy_id": null,
            "name": "Product 1000013",
            "quantity": 0,
            "created_at": "2024-03-04T09:14:55.100Z",
            "updated_at": "2024-03-04T09:14:55.100Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000013",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000013",
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
            "company_id": "a6e3d713-f1b0-4de8-9ecd-e635fcd3f21d",
            "item_group_id": "33725a84-3e16-498a-ac83-aa30ed14f5e4",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000013",
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
      "owner_id": "1a44df20-4c8f-46e3-871f-e8d83300bcfb",
      "owner_type": "orders",
      "employee_id": "d26a3292-ad56-4f8e-951f-16cc877b3170"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/1a44df20-4c8f-46e3-871f-e8d83300bcfb"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/d26a3292-ad56-4f8e-951f-16cc877b3170"
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






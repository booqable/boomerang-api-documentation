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
      "id": "e7826b75-3f5a-47a1-a287-8380d0c196b4",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-04-15T09:28:53+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "ca3f2828-44e5-4407-99d0-4004c2aaed96",
        "owner_type": "orders",
        "employee_id": "82d508df-7ea2-449b-be31-76bef99e2882"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/ca3f2828-44e5-4407-99d0-4004c2aaed96"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/82d508df-7ea2-449b-be31-76bef99e2882"
          }
        }
      }
    },
    {
      "id": "7599a823-356e-4935-82cc-980d0082adff",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-04-15T09:28:53+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "7eff0f53-28c7-486f-a766-6e4199009506",
        "owner_type": "orders",
        "employee_id": "00a69d0b-ad57-46f8-b6d0-3df359fc338c"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/7eff0f53-28c7-486f-a766-6e4199009506"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/00a69d0b-ad57-46f8-b6d0-3df359fc338c"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/32fa736e-ad55-4cb8-910d-e0305d74305c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "32fa736e-ad55-4cb8-910d-e0305d74305c",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-04-15T09:28:54+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "75a69d3d-4009-43fa-ad15-96c6f13f5911",
            "legacy_id": null,
            "name": "Product 1000077",
            "quantity": 0,
            "created_at": "2024-04-15T09:28:54.346Z",
            "updated_at": "2024-04-15T09:28:54.346Z",
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
            "company_id": "2986b5a9-9560-43c0-888d-181ca6f52361",
            "item_group_id": "496c0f8a-123e-4c55-aac4-4fc89a022c3b",
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
      "owner_id": "7c434574-c280-423e-840a-dabb00234d1d",
      "owner_type": "orders",
      "employee_id": "c6e8b125-b01d-487c-a175-e348d0b48d89"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/7c434574-c280-423e-840a-dabb00234d1d"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/c6e8b125-b01d-487c-a175-e348d0b48d89"
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






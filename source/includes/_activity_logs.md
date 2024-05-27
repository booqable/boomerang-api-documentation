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
      "id": "cca51bef-07cf-48a3-bb74-b4f85b541e02",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-05-27T09:24:00.722858+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "70acc3da-0314-44d8-9648-2e50a56e9f2c",
        "owner_type": "orders",
        "employee_id": "f18aadc3-c2c6-4992-8d6a-e68cf2f8c0e0"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/70acc3da-0314-44d8-9648-2e50a56e9f2c"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/f18aadc3-c2c6-4992-8d6a-e68cf2f8c0e0"
          }
        }
      }
    },
    {
      "id": "99df1bbd-0cb4-44cb-beb8-7d89fbed5dd2",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-05-27T09:24:00.476909+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "72a111d7-19cc-4c6a-bb0a-9a6789129641",
        "owner_type": "orders",
        "employee_id": "957a3833-ca15-4f25-86c2-8524ee1a9c26"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/72a111d7-19cc-4c6a-bb0a-9a6789129641"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/957a3833-ca15-4f25-86c2-8524ee1a9c26"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/025ef38a-44be-402c-b600-90d8a48279ef' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "025ef38a-44be-402c-b600-90d8a48279ef",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-05-27T09:24:01.864925+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "88b743a9-c6bd-4de2-bf09-5e2076edfb76",
            "legacy_id": null,
            "name": "Product 1000016",
            "quantity": 0,
            "created_at": "2024-05-27T09:24:01.599Z",
            "updated_at": "2024-05-27T09:24:01.599Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000016",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000016",
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
            "company_id": "8df9dd15-dbdd-4a31-ac78-bb8fb6816cc4",
            "item_group_id": "ca369f4a-ac74-47fe-974a-f96a2a8025e9",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000016",
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
      "owner_id": "1227ae26-6d0f-456e-ae55-4eb5a62f0bc1",
      "owner_type": "orders",
      "employee_id": "a006927e-da2e-457f-a76f-71448d463b14"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/1227ae26-6d0f-456e-ae55-4eb5a62f0bc1"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/a006927e-da2e-457f-a76f-71448d463b14"
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






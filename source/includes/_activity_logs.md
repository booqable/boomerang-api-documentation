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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/f3aa955e-0e02-4762-a1e5-89cfe1393c87' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f3aa955e-0e02-4762-a1e5-89cfe1393c87",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-06-03T09:26:03.099257+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "749fb59e-0ce2-41a1-8e71-e6c08bcc7419",
            "legacy_id": null,
            "name": "Product 1000021",
            "quantity": 0,
            "created_at": "2024-06-03T09:26:02.899Z",
            "updated_at": "2024-06-03T09:26:02.899Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000022",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000021",
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
            "company_id": "410b3687-f2d8-4c1e-b02b-39327fadc051",
            "item_group_id": "b080fcab-f726-48d0-a8b0-b9c6e291f017",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000021",
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
      "owner_id": "cab95063-d341-441c-b3fa-9ae75fedd69b",
      "owner_type": "orders",
      "employee_id": "6ee3d2dd-713f-46cd-935f-0962d5a9b3d6"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/cab95063-d341-441c-b3fa-9ae75fedd69b"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/6ee3d2dd-713f-46cd-935f-0962d5a9b3d6"
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
      "id": "8dc7c828-f10d-4567-92f1-4a0840f8c7f0",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-06-03T09:26:04.530789+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "f3e5a18c-187f-406b-b3fa-335a6094af67",
        "owner_type": "orders",
        "employee_id": "e238e259-a55c-4b30-a0e3-a686a2e4bcdf"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/f3e5a18c-187f-406b-b3fa-335a6094af67"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/e238e259-a55c-4b30-a0e3-a686a2e4bcdf"
          }
        }
      }
    },
    {
      "id": "43912a5f-be57-4894-aaa7-35744cb265b6",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-06-03T09:26:04.323364+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "fa7be0d6-75f8-4b4c-b786-ab3113ce3973",
        "owner_type": "orders",
        "employee_id": "dc6e250a-ebf5-46c9-b957-ba865db3d0a0"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/fa7be0d6-75f8-4b4c-b786-ab3113ce3973"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/dc6e250a-ebf5-46c9-b957-ba865db3d0a0"
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






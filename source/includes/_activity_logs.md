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
      "id": "ff630178-7048-4b53-996c-f0a4cd18db35",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-05-15T13:46:53+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "577a0209-3f32-4d68-96eb-df2abde192fa",
        "owner_type": "orders",
        "employee_id": "4955ffc2-6e24-4dd7-aa79-eb6eef33de01"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/577a0209-3f32-4d68-96eb-df2abde192fa"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/4955ffc2-6e24-4dd7-aa79-eb6eef33de01"
          }
        }
      }
    },
    {
      "id": "2799263d-711c-45b6-8365-7669215ce32f",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-05-15T13:46:53+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "e4be8833-5db8-44b3-bca6-634d79bc95c4",
        "owner_type": "orders",
        "employee_id": "d916ec05-62ff-4858-a4ee-4d5b3d8d65d8"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/e4be8833-5db8-44b3-bca6-634d79bc95c4"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/d916ec05-62ff-4858-a4ee-4d5b3d8d65d8"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/b119450f-0142-4ea4-b788-bb1b1136b18b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b119450f-0142-4ea4-b788-bb1b1136b18b",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-05-15T13:46:55+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "ce5f130a-5e4d-45c9-9e42-a2d188848166",
            "legacy_id": null,
            "name": "Product 1000002",
            "quantity": 0,
            "created_at": "2023-05-15T13:46:55.000Z",
            "updated_at": "2023-05-15T13:46:55.000Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000002",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000002",
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
            "company_id": "e6bfa014-d65f-4377-881c-1310831b7903",
            "item_group_id": "6c8c8c11-aebb-4b36-9a50-f5c0b7a904b6",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000002",
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
      "owner_id": "d5460913-12ac-4d23-9aff-74aa89e882c1",
      "owner_type": "orders",
      "employee_id": "b882a5b2-151e-4437-8177-e80b13a6ad0e"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/d5460913-12ac-4d23-9aff-74aa89e882c1"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/b882a5b2-151e-4437-8177-e80b13a6ad0e"
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






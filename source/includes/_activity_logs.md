# Activity logs

Activity logs describe an event where changes took place in our database. Examples of such events can be an order that was created or placed, a product name that changed, a custoemr that was added or an e-mail that got sent. 

Activity logs contain `action_key` and `action_args`, which determine the summary line, and `data` which contains a copy of or details about the subject that the event is about, such as a order, product, customer or e-mail.

## Endpoints
`GET /api/boomerang/activity_logs`

`GET /api/boomerang/activity_logs/{id}`

## Fields
Every activity log has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`action_key` | **String** <br>The name of the event that the activity log describes. This determines which translated summary line will be displayed in the web client. Examples are "product.created" or "order.updated".
`action_args` | **Hash** <br>Arguments that can be passed to enrich the summary line of the web client with details, such as a product name.
`has_data` | **Boolean** `readonly`<br>Boolean value flag indicating whether this activity log contains additional data describing the subject of the event.
`owner_id` | **Uuid** <br>ID of the subject the event is about.
`owner_type` | **String** <br>Class of the subject the event is about
`employee_id` | **Uuid** <br>The associated Employee
`data` | **Hash** `extra` `readonly`<br>Hash containing (details on) the subject(s) of the event this activity log describes. The subject(s) are contained in individual arrays grouped by their type. For example: { products: [{ id: 1, name: 'Product 1'}] } 


## Relationships
Activity logs have the following relationships:

Name | Description
- | -
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
      "id": "6aa80f6c-8558-4991-9c5a-3bf6abb66397",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-01-26T12:15:38+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "69ef098b-20b1-428d-9c4f-528bf47224d0",
        "owner_type": "orders",
        "employee_id": "08f07edd-bab4-4fe8-8791-1e65608b5600"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/69ef098b-20b1-428d-9c4f-528bf47224d0"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/08f07edd-bab4-4fe8-8791-1e65608b5600"
          }
        }
      }
    },
    {
      "id": "e47f91d2-6808-4550-a6b8-2c36a369186f",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-01-26T12:15:38+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "a3321177-502d-480e-a805-28e713f8ec6e",
        "owner_type": "orders",
        "employee_id": "5837af5a-0cc0-4ac1-87b9-ef78c05809a6"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/a3321177-502d-480e-a805-28e713f8ec6e"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/5837af5a-0cc0-4ac1-87b9-ef78c05809a6"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[activity_logs]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-26T12:15:33Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
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
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`


`employee`






## Fetching an activity log



> How to fetch an activity log:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/activity_logs/31836ca8-c402-4c4d-98ca-86e913a5078d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "31836ca8-c402-4c4d-98ca-86e913a5078d",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-01-26T12:15:40+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "4ad89db6-6360-4192-a864-7f785a339725",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-01-26T12:15:40.251Z",
            "updated_at": "2023-01-26T12:15:40.251Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 3",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 3",
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
            "company_id": "2f1706a8-da62-4310-b5a2-c43431099f1e",
            "item_group_id": "18994a13-36a6-434c-a513-7140eea21a1c",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-3",
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
            "cached_tag_list": null,
            "tag_list": null
          }
        ]
      },
      "owner_id": "aee1c8ee-257d-4957-b474-8fed5bec51cd",
      "owner_type": "orders",
      "employee_id": "86a8dfa7-c5bd-4d10-a982-6512d13f77f9"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/aee1c8ee-257d-4957-b474-8fed5bec51cd"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/86a8dfa7-c5bd-4d10-a982-6512d13f77f9"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[activity_logs]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`owner`


`employee`






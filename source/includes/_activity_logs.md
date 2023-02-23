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
`data` | **Hash** `readonly`<br>Hash containing (details on) the subject(s) of the event this activity log describes. The subject(s) are contained in individual arrays grouped by their type. For example: { products: [{ id: 1, name: 'Product 1'}] } 


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
      "id": "f6c641c4-5b82-4a4a-95ef-6c47d68c09fa",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-23T13:35:44+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "91e79692-5eaf-473b-9c0f-40ac0f3a1b0e",
        "owner_type": "orders",
        "employee_id": "ee6309fd-83e2-42bb-9eca-8fccaa02be30"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/91e79692-5eaf-473b-9c0f-40ac0f3a1b0e"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/ee6309fd-83e2-42bb-9eca-8fccaa02be30"
          }
        }
      }
    },
    {
      "id": "64134a9a-d74b-4df4-9d2f-f2ccda9f79e8",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-23T13:35:44+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "260e235f-9f62-40b0-9253-d86d69e5de6f",
        "owner_type": "orders",
        "employee_id": "9697b598-61ca-4844-a3b3-61e33f479760"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/260e235f-9f62-40b0-9253-d86d69e5de6f"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/9697b598-61ca-4844-a3b3-61e33f479760"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-23T13:35:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/6cd3c41f-2a6e-46f2-bb61-9cf2c17155a6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6cd3c41f-2a6e-46f2-bb61-9cf2c17155a6",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-23T13:35:46+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "950a35a6-c33e-4955-aa7d-0dae6e5fdc99",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-23T13:35:45.959Z",
            "updated_at": "2023-02-23T13:35:45.959Z",
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
            "company_id": "0e79b5b4-fd82-45cd-9c58-52590db7a7a9",
            "item_group_id": "ec32f67e-e885-449a-9190-4625130d90c8",
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
            "cached_tag_list": null
          }
        ]
      },
      "owner_id": "c250ad52-d74f-47d1-a148-b8d7d1de53cf",
      "owner_type": "orders",
      "employee_id": "ad403107-9ffc-4867-be2f-c9676e079947"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/c250ad52-d74f-47d1-a148-b8d7d1de53cf"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/ad403107-9ffc-4867-be2f-c9676e079947"
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






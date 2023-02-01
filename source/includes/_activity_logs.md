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
      "id": "9a94d90c-7c10-4177-bccd-2fbffc904cc7",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-01T12:58:52+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "3f98b61d-19a6-4543-98f6-471d7a1fb411",
        "owner_type": "orders",
        "employee_id": "68edc4ad-062b-4ad3-84d0-2a12c8925f82"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/3f98b61d-19a6-4543-98f6-471d7a1fb411"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/68edc4ad-062b-4ad3-84d0-2a12c8925f82"
          }
        }
      }
    },
    {
      "id": "d8c4dc5e-3099-4d47-a7b3-138b155d4e54",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-01T12:58:51+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "f982fdce-8344-48f5-af19-62ce89650962",
        "owner_type": "orders",
        "employee_id": "bac0912b-1c2d-4e21-b85c-cac363bd3d94"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/f982fdce-8344-48f5-af19-62ce89650962"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/bac0912b-1c2d-4e21-b85c-cac363bd3d94"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T12:58:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/6b2df40f-df61-4a1d-9664-2d3eaf0f129b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6b2df40f-df61-4a1d-9664-2d3eaf0f129b",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-01T12:58:54+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "bcf687db-c125-426e-a213-cbaac3f4617b",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-01T12:58:54.063Z",
            "updated_at": "2023-02-01T12:58:54.063Z",
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
            "company_id": "3e8fdbf4-e943-4d5d-8e83-aa4ec5f19350",
            "item_group_id": "5d90a5d9-cced-401e-a039-45098c314d45",
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
      "owner_id": "072c0195-116f-4450-81a8-8947c8b0f7d0",
      "owner_type": "orders",
      "employee_id": "c5fe8041-b860-4202-ba07-adfdf8ee4668"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/072c0195-116f-4450-81a8-8947c8b0f7d0"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/c5fe8041-b860-4202-ba07-adfdf8ee4668"
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






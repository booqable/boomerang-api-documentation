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
      "id": "8a4148b4-d384-4939-bf9f-e7e78e9467b6",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-08T13:50:33+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "64b8e868-29f9-49a2-96fe-8679ab0c5f98",
        "owner_type": "orders",
        "employee_id": "4599f58f-013d-4b20-95c0-6b1d4271cb0b"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/64b8e868-29f9-49a2-96fe-8679ab0c5f98"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/4599f58f-013d-4b20-95c0-6b1d4271cb0b"
          }
        }
      }
    },
    {
      "id": "9cb63feb-3188-4077-a3dc-e1058095450d",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-08T13:50:33+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "e3f77f61-52b3-487e-83f1-e4591f3a049f",
        "owner_type": "orders",
        "employee_id": "0c101626-8a41-4808-9004-eb2d0439e00b"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/e3f77f61-52b3-487e-83f1-e4591f3a049f"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/0c101626-8a41-4808-9004-eb2d0439e00b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T13:50:28Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/3cd0a317-004b-4c6d-88ed-fa29aa80ddbb' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3cd0a317-004b-4c6d-88ed-fa29aa80ddbb",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-08T13:50:35+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "836f2ae5-4f76-41c3-8a42-a11a6eedf34b",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-08T13:50:35.005Z",
            "updated_at": "2023-02-08T13:50:35.005Z",
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
            "company_id": "d1121687-0422-45c3-851d-c75b250377ad",
            "item_group_id": "c14c0363-33c1-46db-930c-f3c58645c61d",
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
      "owner_id": "e85a3f29-197d-498f-a9d0-8cfbd62828f9",
      "owner_type": "orders",
      "employee_id": "a80a779a-d6f9-49a8-98af-627521a5bf03"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/e85a3f29-197d-498f-a9d0-8cfbd62828f9"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/a80a779a-d6f9-49a8-98af-627521a5bf03"
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






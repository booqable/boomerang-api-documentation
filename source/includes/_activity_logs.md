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
      "id": "ca51d0e6-fe50-48f9-8d14-7e54776fea5c",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-09T10:17:23+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "2ce745cc-c955-4a78-9ca1-0b4391cd8b0e",
        "owner_type": "orders",
        "employee_id": "500269b8-1f4d-4595-8dab-358901866727"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/2ce745cc-c955-4a78-9ca1-0b4391cd8b0e"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/500269b8-1f4d-4595-8dab-358901866727"
          }
        }
      }
    },
    {
      "id": "ceeee3c3-975c-4d92-9e91-ecd10d608417",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-09T10:17:23+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "c725f469-8052-45b5-bfa9-cf8b58cd106b",
        "owner_type": "orders",
        "employee_id": "4fd20e31-6109-4930-a1a8-a14541e8253f"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/c725f469-8052-45b5-bfa9-cf8b58cd106b"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/4fd20e31-6109-4930-a1a8-a14541e8253f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:17:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/d91c3fca-73f1-4281-92df-cc78d521b4c6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d91c3fca-73f1-4281-92df-cc78d521b4c6",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-09T10:17:25+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "202d20fb-8806-4907-abed-6a58eab59338",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-09T10:17:25.813Z",
            "updated_at": "2023-02-09T10:17:25.813Z",
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
            "company_id": "1b8cb437-8bae-4b78-a81e-b08b83517027",
            "item_group_id": "b89f4f5f-a78d-4b02-bb3c-25181eb3e982",
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
      "owner_id": "fae8509f-d384-4ce3-983f-03e1ac915c07",
      "owner_type": "orders",
      "employee_id": "8548a1b6-5d49-451e-bc87-951aa6f61bdb"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/fae8509f-d384-4ce3-983f-03e1ac915c07"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/8548a1b6-5d49-451e-bc87-951aa6f61bdb"
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






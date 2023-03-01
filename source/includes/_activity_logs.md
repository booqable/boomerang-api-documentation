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
      "id": "df8d3a2e-8ef9-4bd2-a0d9-379ab87e6a70",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-03-01T17:36:29+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "2b661719-3c7f-441e-8c04-00eb29d880b2",
        "owner_type": "orders",
        "employee_id": "ade370bf-e49c-4ab5-8888-21eeb392ad1b"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/2b661719-3c7f-441e-8c04-00eb29d880b2"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/ade370bf-e49c-4ab5-8888-21eeb392ad1b"
          }
        }
      }
    },
    {
      "id": "9b505d5d-f889-4d32-a318-cb7e12828ba2",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-03-01T17:36:29+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "eaf44350-2b4f-4514-a237-c8bc5f92d62a",
        "owner_type": "orders",
        "employee_id": "655f68f0-4193-4633-862c-84c864776040"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/eaf44350-2b4f-4514-a237-c8bc5f92d62a"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/655f68f0-4193-4633-862c-84c864776040"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T17:36:22Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/2e3e538b-bf00-43ad-a1f8-be673cd09cf9' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2e3e538b-bf00-43ad-a1f8-be673cd09cf9",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-03-01T17:36:30+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "a7c3afdd-8984-44f8-8446-cd61f692edd1",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-03-01T17:36:30.649Z",
            "updated_at": "2023-03-01T17:36:30.649Z",
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
            "company_id": "5c0d49a8-e010-47f4-84a8-f89569544295",
            "item_group_id": "8d3a9e27-e178-4f56-b5d5-e5cf306a01d0",
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
      "owner_id": "215f9c37-06dc-4f90-a6a1-7fe6c25c2fd4",
      "owner_type": "orders",
      "employee_id": "306a289a-7dd8-4b1c-816d-879ae36b9da5"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/215f9c37-06dc-4f90-a6a1-7fe6c25c2fd4"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/306a289a-7dd8-4b1c-816d-879ae36b9da5"
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






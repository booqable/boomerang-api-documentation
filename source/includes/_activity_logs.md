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
      "id": "2409b50d-a059-46af-9862-8c3fbe28ac67",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-03-06T08:22:25+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "798507b6-e949-4c07-8bc1-b97ec1e04d3b",
        "owner_type": "orders",
        "employee_id": "ef8e9d1d-8dee-4367-83b8-11e09c1e79b5"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/798507b6-e949-4c07-8bc1-b97ec1e04d3b"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/ef8e9d1d-8dee-4367-83b8-11e09c1e79b5"
          }
        }
      }
    },
    {
      "id": "f61bcd6f-7ec7-498b-b1a6-0246e4071c2e",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-03-06T08:22:25+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "c86bef0f-21a3-4793-8b50-f7ab0a6885a6",
        "owner_type": "orders",
        "employee_id": "718b51e8-6be3-4573-8155-c40c7cef2199"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/c86bef0f-21a3-4793-8b50-f7ab0a6885a6"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/718b51e8-6be3-4573-8155-c40c7cef2199"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-06T08:22:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/fce14323-c33f-4c30-8b1e-5b96a684ade0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fce14323-c33f-4c30-8b1e-5b96a684ade0",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-03-06T08:22:26+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "a3e27335-613f-4a7b-9a9f-1600ebd56697",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-03-06T08:22:26.556Z",
            "updated_at": "2023-03-06T08:22:26.556Z",
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
            "company_id": "d23f3825-c7a5-4a65-b7af-719165e7ef9f",
            "item_group_id": "bcc88dbb-ace0-403c-b345-a7f0c2c70e20",
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
      "owner_id": "a98bafd4-d6fe-4548-b8ce-c70564c6dcae",
      "owner_type": "orders",
      "employee_id": "a80495e5-618f-4f45-a0fc-5c3cd2ba7a71"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/a98bafd4-d6fe-4548-b8ce-c70564c6dcae"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/a80495e5-618f-4f45-a0fc-5c3cd2ba7a71"
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






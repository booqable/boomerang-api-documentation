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
      "id": "db9c216b-5a0e-48db-ae5c-7a666bbe1d9a",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-13T12:13:12+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "974ec176-c79f-4e6c-b0b6-1d8ea21d6ee2",
        "owner_type": "orders",
        "employee_id": "5a7dc18a-b199-4225-9968-17d0b1a0d66b"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/974ec176-c79f-4e6c-b0b6-1d8ea21d6ee2"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/5a7dc18a-b199-4225-9968-17d0b1a0d66b"
          }
        }
      }
    },
    {
      "id": "710f0f80-785c-468d-93b5-8bf02ff725a6",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-13T12:13:11+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "0219b8cc-594e-4ad7-89bb-feaeec501283",
        "owner_type": "orders",
        "employee_id": "c5104d65-e5fd-40c3-a8a1-29a7ab617bb7"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/0219b8cc-594e-4ad7-89bb-feaeec501283"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/c5104d65-e5fd-40c3-a8a1-29a7ab617bb7"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T12:13:06Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/0ffe9e73-cf1e-4563-9b69-3ab64fbc8460' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0ffe9e73-cf1e-4563-9b69-3ab64fbc8460",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-13T12:13:14+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "ebf1487c-5e11-4c48-8133-2f0d756f7667",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-13T12:13:14.390Z",
            "updated_at": "2023-02-13T12:13:14.390Z",
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
            "company_id": "fd16e0fb-ca90-4bd3-8900-e04f433fe8b0",
            "item_group_id": "2a6659e9-a288-4fda-8d16-f9249a6d2a05",
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
      "owner_id": "56babfd7-6918-455d-ade7-0f23750657a0",
      "owner_type": "orders",
      "employee_id": "c42c604f-35d0-40df-8d71-b663de892350"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/56babfd7-6918-455d-ade7-0f23750657a0"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/c42c604f-35d0-40df-8d71-b663de892350"
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






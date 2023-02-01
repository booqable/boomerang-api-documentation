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
      "id": "996405cc-c864-4ec9-bf5b-a6d8f443c641",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-01T15:17:15+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "80125acb-07af-4815-9dc1-11c47e401ca2",
        "owner_type": "orders",
        "employee_id": "5ab0ded5-3bd4-4619-aa05-78d35cdc7aab"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/80125acb-07af-4815-9dc1-11c47e401ca2"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/5ab0ded5-3bd4-4619-aa05-78d35cdc7aab"
          }
        }
      }
    },
    {
      "id": "05af0313-7c0b-41eb-979b-96135b7b2aa8",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-01T15:17:14+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "a2ae19fd-c12b-42a4-b3f4-87113b5d4c63",
        "owner_type": "orders",
        "employee_id": "7f18e32f-1be8-42d9-86c6-ca80542c2520"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/a2ae19fd-c12b-42a4-b3f4-87113b5d4c63"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/7f18e32f-1be8-42d9-86c6-ca80542c2520"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T15:17:11Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/d7cb4168-9ea1-4d46-84b0-fd5df174f22c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d7cb4168-9ea1-4d46-84b0-fd5df174f22c",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-01T15:17:16+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "5ab09df9-c28e-4143-ae3f-df76ce8206da",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-01T15:17:16.473Z",
            "updated_at": "2023-02-01T15:17:16.473Z",
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
            "company_id": "375ad4a4-70ee-4eaf-9be1-5f5364f933a9",
            "item_group_id": "225b7077-4e24-4983-a404-31ac5c7e3e9a",
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
      "owner_id": "00a3256b-8694-4235-9361-c6ec6cd3c1e8",
      "owner_type": "orders",
      "employee_id": "46430875-d1b5-443a-b27e-878f9ecb899c"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/00a3256b-8694-4235-9361-c6ec6cd3c1e8"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/46430875-d1b5-443a-b27e-878f9ecb899c"
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






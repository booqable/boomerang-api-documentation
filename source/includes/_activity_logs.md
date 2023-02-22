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
      "id": "0474a1de-5174-4727-8aae-db693aa9cd07",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-22T14:12:24+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "96679188-9c09-4843-923b-17b88efeee16",
        "owner_type": "orders",
        "employee_id": "6b8de922-a230-448c-8dfd-f39615530063"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/96679188-9c09-4843-923b-17b88efeee16"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/6b8de922-a230-448c-8dfd-f39615530063"
          }
        }
      }
    },
    {
      "id": "1d47bcd2-cdb2-40cf-8590-76fbedd854a0",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-22T14:12:24+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "d38aecbe-0112-47e6-b5e1-7754248bdd8c",
        "owner_type": "orders",
        "employee_id": "ad8a1c71-b2a6-4de0-8ddf-ad18496eb9ab"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/d38aecbe-0112-47e6-b5e1-7754248bdd8c"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/ad8a1c71-b2a6-4de0-8ddf-ad18496eb9ab"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T14:12:16Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/86defe51-75fd-4ec1-b2f9-3f524c5a291e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "86defe51-75fd-4ec1-b2f9-3f524c5a291e",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-22T14:12:25+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "f38fd5ee-effc-4a89-9319-14d839156439",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-22T14:12:25.758Z",
            "updated_at": "2023-02-22T14:12:25.758Z",
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
            "company_id": "4179f438-7edb-461b-bfdf-74fe75013c4c",
            "item_group_id": "6c1b7525-268c-4299-837d-beab9796bc72",
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
      "owner_id": "b422a3b6-2bf0-4866-91ba-c2e679dcbea4",
      "owner_type": "orders",
      "employee_id": "e2c8c80f-18dd-4ccd-a356-0d7b156550b5"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/b422a3b6-2bf0-4866-91ba-c2e679dcbea4"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/e2c8c80f-18dd-4ccd-a356-0d7b156550b5"
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






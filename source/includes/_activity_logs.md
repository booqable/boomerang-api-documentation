# Activity logs

Activity logs describe an event where changes took place in our database. Examples of such events can be an order that was created or placed, a product name that changed, a custoemr that was added or an e-mail that got sent. 

Activity logs contain `action_key` and `action_args`, which determine the summary line, and `data` which contains a copy of or details about the subject that the event is about, such as a order, product, customer or e-mail.

## Endpoints
`GET /api/boomerang/activity_logs/{id}`

`GET /api/boomerang/activity_logs`

## Fields
Every activity log has the following fields:

Name | Description
-- | --
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
-- | --
`owner` | **Customer, Product, Product group, Stock item, Bundle, Order, Document, Email**<br>Associated Owner
`employee` | **Employees** `readonly`<br>Associated Employee


## Fetching an activity log



> How to fetch an activity log:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/activity_logs/59f32928-d695-45fa-9959-eae1c694f934' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "59f32928-d695-45fa-9959-eae1c694f934",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-02-26T09:18:06+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "cd4ba907-c514-4a67-a524-70f13e331fe1",
            "legacy_id": null,
            "name": "Product 1000034",
            "quantity": 0,
            "created_at": "2024-02-26T09:18:06.149Z",
            "updated_at": "2024-02-26T09:18:06.149Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000035",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000034",
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
            "company_id": "e79c87cb-be85-490b-945e-728abd1f8667",
            "item_group_id": "15455592-5824-4f04-b8d8-0a90c63968e0",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000034",
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
      "owner_id": "54417d0c-1670-423c-a981-03de7bad0d5d",
      "owner_type": "orders",
      "employee_id": "3d3197e3-f60b-4f58-ad55-ffd59b9acd50"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/54417d0c-1670-423c-a981-03de7bad0d5d"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/3d3197e3-f60b-4f58-ad55-ffd59b9acd50"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[activity_logs]=created_at,updated_at,action_key`


### Includes

This request accepts the following includes:

`owner`


`employee`






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
      "id": "e42868af-8852-4387-88a5-7a806a1a42c2",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-02-26T09:18:07+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "c301e663-7c1b-4adc-b5c1-b12a6c1e60f8",
        "owner_type": "orders",
        "employee_id": "efa52c5b-7a34-4cdc-88ba-84bf374a0e7d"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/c301e663-7c1b-4adc-b5c1-b12a6c1e60f8"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/efa52c5b-7a34-4cdc-88ba-84bf374a0e7d"
          }
        }
      }
    },
    {
      "id": "314245b2-436a-4ba7-815d-26f06b13aa80",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-02-26T09:18:07+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "bda144ae-8d4b-480d-afa0-5bb81fd5c1ab",
        "owner_type": "orders",
        "employee_id": "4a43a5ae-d0ca-448f-962b-6d9f3e143a0d"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/bda144ae-8d4b-480d-afa0-5bb81fd5c1ab"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/4a43a5ae-d0ca-448f-962b-6d9f3e143a0d"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[activity_logs]=created_at,updated_at,action_key`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
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
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`


`employee`






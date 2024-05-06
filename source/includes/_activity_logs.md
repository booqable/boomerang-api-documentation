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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/f328c83a-45b9-471c-b4eb-89bd53255338' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f328c83a-45b9-471c-b4eb-89bd53255338",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-05-06T09:22:37+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "2bfefd47-f5b4-42a5-935b-0c7aef502d3b",
            "legacy_id": null,
            "name": "Product 1000012",
            "quantity": 0,
            "created_at": "2024-05-06T09:22:37.079Z",
            "updated_at": "2024-05-06T09:22:37.079Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000014",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000012",
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
            "company_id": "318cfbd8-656c-4df7-8d71-bd67adcedcc7",
            "item_group_id": "7a6a513e-092b-49e7-aa96-8ac9e0c4984b",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000012",
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
      "owner_id": "3532a931-8bfe-4dac-b941-5259de5a96b5",
      "owner_type": "orders",
      "employee_id": "165cf3fa-976c-49d8-a2fd-7bc7e577facc"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/3532a931-8bfe-4dac-b941-5259de5a96b5"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/165cf3fa-976c-49d8-a2fd-7bc7e577facc"
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
      "id": "39841186-40d3-49b0-a173-6dea1617cffd",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-05-06T09:22:38+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "1291c845-491a-49ea-a6fe-a4f7b43e0d41",
        "owner_type": "orders",
        "employee_id": "1bfa1e2f-fe2d-467d-a2e6-b40d06efcd83"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/1291c845-491a-49ea-a6fe-a4f7b43e0d41"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/1bfa1e2f-fe2d-467d-a2e6-b40d06efcd83"
          }
        }
      }
    },
    {
      "id": "37920724-f3e0-4037-89c5-e5de7cf7b46b",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-05-06T09:22:38+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "f60a6a0a-9215-452c-b708-c62b0dfed6b0",
        "owner_type": "orders",
        "employee_id": "a9f3e651-a5f6-41c9-ae71-9a252108d39f"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/f60a6a0a-9215-452c-b708-c62b0dfed6b0"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/a9f3e651-a5f6-41c9-ae71-9a252108d39f"
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






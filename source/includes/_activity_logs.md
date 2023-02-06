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
      "id": "4a2b77ce-7ea6-4c25-b3e2-e049bec45b25",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-06T19:28:15+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "220922dd-1b19-48cd-8d97-bd486f33cead",
        "owner_type": "orders",
        "employee_id": "23761683-fd89-4322-9c0b-dd815494b57d"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/220922dd-1b19-48cd-8d97-bd486f33cead"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/23761683-fd89-4322-9c0b-dd815494b57d"
          }
        }
      }
    },
    {
      "id": "8b874ab7-d0b8-4175-b009-37c48c6a8ece",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-06T19:28:15+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "507f024c-0814-460e-82c1-4b95a04ea58f",
        "owner_type": "orders",
        "employee_id": "94016da1-a4d0-4819-9bac-0522ae6a4ba7"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/507f024c-0814-460e-82c1-4b95a04ea58f"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/94016da1-a4d0-4819-9bac-0522ae6a4ba7"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T19:28:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/44d7e54b-5084-49c3-ba75-2b43121d7d49' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "44d7e54b-5084-49c3-ba75-2b43121d7d49",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-06T19:28:16+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "b3c9897e-afcd-4bbe-b17a-707476d0aea6",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-06T19:28:16.778Z",
            "updated_at": "2023-02-06T19:28:16.778Z",
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
            "company_id": "2f7b8011-20c9-49a6-9d35-a2e07dff72bc",
            "item_group_id": "5ca05d00-5603-4006-9b42-71cbad5d48b5",
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
      "owner_id": "58e05c14-3965-4d29-9618-f2be4bbc52f1",
      "owner_type": "orders",
      "employee_id": "6fcb1c58-daed-47d0-9150-dae1a631e49d"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/58e05c14-3965-4d29-9618-f2be4bbc52f1"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/6fcb1c58-daed-47d0-9150-dae1a631e49d"
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






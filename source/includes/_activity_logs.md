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
      "id": "be5ce546-f881-475c-9984-1a7f8f07c58f",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-24T14:55:52+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "8f546168-9ceb-4a29-b0b7-8472aeadc732",
        "owner_type": "orders",
        "employee_id": "dc5ddb49-1cb8-4b37-9a7a-fc8b32a5c508"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/8f546168-9ceb-4a29-b0b7-8472aeadc732"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/dc5ddb49-1cb8-4b37-9a7a-fc8b32a5c508"
          }
        }
      }
    },
    {
      "id": "788df21c-7c03-485c-88e1-a63906b13c1d",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-24T14:55:52+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "052ae03a-14dd-4d73-955e-9b8da76c07fa",
        "owner_type": "orders",
        "employee_id": "4d61afcb-13dd-4110-ba6b-33b600ccf8f5"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/052ae03a-14dd-4d73-955e-9b8da76c07fa"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/4d61afcb-13dd-4110-ba6b-33b600ccf8f5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T14:55:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/3b3fce64-321f-4b0f-946e-4dc8a173bb75' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3b3fce64-321f-4b0f-946e-4dc8a173bb75",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-24T14:55:57+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "904fd88c-bedb-4913-882b-ebbf591ceb30",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-24T14:55:57.774Z",
            "updated_at": "2023-02-24T14:55:57.774Z",
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
            "company_id": "12dca9f1-a8b7-4e42-b5a6-862e76b2cf8a",
            "item_group_id": "efce3f5b-2949-49f1-a286-2d5135375144",
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
      "owner_id": "73a88289-b1ef-41ee-9e3f-3ef459403b38",
      "owner_type": "orders",
      "employee_id": "9fd5a1b2-d7b7-4e2f-a7c2-3e995f470880"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/73a88289-b1ef-41ee-9e3f-3ef459403b38"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/9fd5a1b2-d7b7-4e2f-a7c2-3e995f470880"
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






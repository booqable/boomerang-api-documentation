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
      "id": "e41ce72f-349f-4366-9a93-18162133b605",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-02T16:27:56+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "0f31bc61-0ba3-4014-8111-bf3cc8b0a070",
        "owner_type": "orders",
        "employee_id": "6dfad0c0-88fe-401a-b0d7-6af2d9992eab"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/0f31bc61-0ba3-4014-8111-bf3cc8b0a070"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/6dfad0c0-88fe-401a-b0d7-6af2d9992eab"
          }
        }
      }
    },
    {
      "id": "72503c23-be3d-4428-b3ec-61c841a7491c",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-02T16:27:55+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "510faf65-44da-448d-a2ea-0ae356e19505",
        "owner_type": "orders",
        "employee_id": "1372144f-d839-47c2-bd11-da1dd9c8bfe5"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/510faf65-44da-448d-a2ea-0ae356e19505"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/1372144f-d839-47c2-bd11-da1dd9c8bfe5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:27:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/71870501-4db5-44bc-b8b8-6868e7adacd4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "71870501-4db5-44bc-b8b8-6868e7adacd4",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-02T16:27:58+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "27e93d29-7974-4471-bce9-a27a45ee6bf6",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-02T16:27:58.399Z",
            "updated_at": "2023-02-02T16:27:58.399Z",
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
            "company_id": "4939ab34-636a-4d62-8e12-7c2ca7962d46",
            "item_group_id": "48fe32f3-e00f-4224-b13f-ee838cddd010",
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
      "owner_id": "2283d52f-c099-42b5-b30c-31fe5054b07c",
      "owner_type": "orders",
      "employee_id": "4ca7b005-71e9-4e26-8660-dc5f36440c9d"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/2283d52f-c099-42b5-b30c-31fe5054b07c"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/4ca7b005-71e9-4e26-8660-dc5f36440c9d"
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






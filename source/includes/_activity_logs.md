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
      "id": "cb9bfde9-8f2a-4e33-9d0d-ca46f37f7994",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-24T09:46:27+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "9d1ece22-150e-4358-a843-02bf129f05c1",
        "owner_type": "orders",
        "employee_id": "1be924fc-f2a1-4eaa-87cb-348646b53beb"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/9d1ece22-150e-4358-a843-02bf129f05c1"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/1be924fc-f2a1-4eaa-87cb-348646b53beb"
          }
        }
      }
    },
    {
      "id": "00aded15-82d2-47de-986c-aa1c03008e2b",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-24T09:46:27+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "27a11891-8a28-4ecd-93fa-f7b8b5027719",
        "owner_type": "orders",
        "employee_id": "bef8ba5a-3310-4482-b609-7cc86ed560a5"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/27a11891-8a28-4ecd-93fa-f7b8b5027719"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/bef8ba5a-3310-4482-b609-7cc86ed560a5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T09:46:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/01440646-e6ba-453d-82b0-ddbc7d25f588' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "01440646-e6ba-453d-82b0-ddbc7d25f588",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-24T09:46:28+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "bce77a84-bc04-4ae7-87f7-4d1931a2f543",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-24T09:46:28.651Z",
            "updated_at": "2023-02-24T09:46:28.651Z",
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
            "company_id": "55ffcee2-676e-4878-bec2-a21b9227f0e3",
            "item_group_id": "9146a499-244b-4818-992d-52acfcb7f8bc",
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
      "owner_id": "0cdf30e2-815f-43f4-91be-9c0505896995",
      "owner_type": "orders",
      "employee_id": "21e19f53-f0d3-4b87-a365-ce503c710a92"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/0cdf30e2-815f-43f4-91be-9c0505896995"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/21e19f53-f0d3-4b87-a365-ce503c710a92"
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






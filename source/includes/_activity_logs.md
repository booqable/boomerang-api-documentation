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
      "id": "824edfee-9ee6-4f4c-99a1-a9f2ee34282d",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-02T14:13:35+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "18a51fc5-5a94-4fb2-af02-5a3d5c31a6ae",
        "owner_type": "orders",
        "employee_id": "17bf001d-d4cc-4875-a0c5-2060cdf25012"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/18a51fc5-5a94-4fb2-af02-5a3d5c31a6ae"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/17bf001d-d4cc-4875-a0c5-2060cdf25012"
          }
        }
      }
    },
    {
      "id": "0fac1819-c840-4581-8c00-18e9b6c9286a",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-02T14:13:34+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "60a47940-8542-4b79-ad4d-25dca033595d",
        "owner_type": "orders",
        "employee_id": "2874fdac-15c7-4c58-96ae-34e44aaa5336"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/60a47940-8542-4b79-ad4d-25dca033595d"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/2874fdac-15c7-4c58-96ae-34e44aaa5336"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T14:13:30Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/c33353e2-d9be-4aa4-80ce-15c5eed76d5b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c33353e2-d9be-4aa4-80ce-15c5eed76d5b",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-02T14:13:37+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "770f637e-a3be-436d-acc8-b9181fe8d4b6",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-02T14:13:37.092Z",
            "updated_at": "2023-02-02T14:13:37.092Z",
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
            "company_id": "79413b31-4c1d-4e21-9841-0cc0fdfe86c6",
            "item_group_id": "781bee1d-f255-4b20-a2f1-a479859c4b30",
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
      "owner_id": "a029c5b6-4112-4952-b96c-2cdae025a01b",
      "owner_type": "orders",
      "employee_id": "cb94de7c-844d-49fd-9a5a-807826e6f836"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/a029c5b6-4112-4952-b96c-2cdae025a01b"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/cb94de7c-844d-49fd-9a5a-807826e6f836"
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






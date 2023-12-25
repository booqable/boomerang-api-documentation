# Activity logs

Activity logs describe an event where changes took place in our database. Examples of such events can be an order that was created or placed, a product name that changed, a custoemr that was added or an e-mail that got sent. 

Activity logs contain `action_key` and `action_args`, which determine the summary line, and `data` which contains a copy of or details about the subject that the event is about, such as a order, product, customer or e-mail.

## Endpoints
`GET /api/boomerang/activity_logs`

`GET /api/boomerang/activity_logs/{id}`

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
      "id": "aa953fda-c3dc-49cf-86bf-db32103e0768",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-12-25T09:14:03+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "f81b3206-1bd2-420b-9776-1a12eb444f75",
        "owner_type": "orders",
        "employee_id": "bd384b99-95c6-4585-ab7c-7e0e0939307b"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/f81b3206-1bd2-420b-9776-1a12eb444f75"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/bd384b99-95c6-4585-ab7c-7e0e0939307b"
          }
        }
      }
    },
    {
      "id": "aab47370-5bce-4b59-b122-94a5ccf11384",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-12-25T09:14:03+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "cd2aa2a1-c6e8-41aa-8e9f-2f621e525350",
        "owner_type": "orders",
        "employee_id": "f0b95ac8-1ef0-42f7-875b-7a1598c361e1"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/cd2aa2a1-c6e8-41aa-8e9f-2f621e525350"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/f0b95ac8-1ef0-42f7-875b-7a1598c361e1"
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






## Fetching an activity log



> How to fetch an activity log:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/activity_logs/c46f8c44-9a7f-440d-b414-0ff08ec0f768' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c46f8c44-9a7f-440d-b414-0ff08ec0f768",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-12-25T09:14:04+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "1ac59fdc-c573-47a1-9f0f-64cbfb984e98",
            "legacy_id": null,
            "name": "Product 1000006",
            "quantity": 0,
            "created_at": "2023-12-25T09:14:03.946Z",
            "updated_at": "2023-12-25T09:14:03.946Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000007",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000006",
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
            "company_id": "5180c0ea-9593-4bfc-bd51-fbaafff5a135",
            "item_group_id": "61c16502-08b4-4599-bb80-3d7c3cfc5c24",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000006",
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
      "owner_id": "6e217c31-28ab-4c26-bc79-261e16ce1abb",
      "owner_type": "orders",
      "employee_id": "8e407116-6775-491f-a4a0-c50072aa8db7"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/6e217c31-28ab-4c26-bc79-261e16ce1abb"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/8e407116-6775-491f-a4a0-c50072aa8db7"
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






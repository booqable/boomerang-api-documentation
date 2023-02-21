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
      "id": "f49d2730-323d-4ece-8e7f-8223318086b0",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-21T10:47:43+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "85a2b2b7-ccdd-40e8-98e0-8ab04764ae1d",
        "owner_type": "orders",
        "employee_id": "0cbd6b8e-6f09-4462-94a5-a2c2148dc769"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/85a2b2b7-ccdd-40e8-98e0-8ab04764ae1d"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/0cbd6b8e-6f09-4462-94a5-a2c2148dc769"
          }
        }
      }
    },
    {
      "id": "3d7ad33b-9216-4c85-a16b-970ecd11f2ec",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-21T10:47:43+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "8f4b48b4-649b-4abf-a7d5-367a1c3f2593",
        "owner_type": "orders",
        "employee_id": "b357d491-fb9a-4659-ab5c-1ca2ad2987b4"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/8f4b48b4-649b-4abf-a7d5-367a1c3f2593"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/b357d491-fb9a-4659-ab5c-1ca2ad2987b4"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T10:47:37Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/eb21173a-d412-494c-90bf-fb023f63ed88' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eb21173a-d412-494c-90bf-fb023f63ed88",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-21T10:47:45+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "3c9f4431-ce30-4dc0-8882-9c0d916c31ab",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-21T10:47:45.450Z",
            "updated_at": "2023-02-21T10:47:45.450Z",
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
            "company_id": "f7322c01-a0c8-42d1-a7f1-3633bf073039",
            "item_group_id": "7f764238-acd6-4971-8f6c-92bcc6e9f4b5",
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
      "owner_id": "68da4f73-87f1-497d-b4f5-022f9961db2b",
      "owner_type": "orders",
      "employee_id": "86c52671-dbb1-43aa-b264-85a6bfaff551"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/68da4f73-87f1-497d-b4f5-022f9961db2b"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/86c52671-dbb1-43aa-b264-85a6bfaff551"
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






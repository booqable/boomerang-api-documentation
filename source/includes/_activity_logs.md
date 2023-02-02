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
      "id": "cc10b616-3d23-4075-9ac6-0b3afda0b05a",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-02T08:00:40+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "37a4c0e7-8cbd-4a58-abbc-379c11374790",
        "owner_type": "orders",
        "employee_id": "134c3522-d16e-4c6b-9fa2-7604b17176cb"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/37a4c0e7-8cbd-4a58-abbc-379c11374790"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/134c3522-d16e-4c6b-9fa2-7604b17176cb"
          }
        }
      }
    },
    {
      "id": "89cab598-3194-4e29-a8c6-b00d89179f55",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-02T08:00:40+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "921daf03-ba11-46df-910f-2a6f061b5be6",
        "owner_type": "orders",
        "employee_id": "5bd96f2a-64ab-4b3b-b3e0-295b752f6981"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/921daf03-ba11-46df-910f-2a6f061b5be6"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/5bd96f2a-64ab-4b3b-b3e0-295b752f6981"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T08:00:35Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/f3523565-4801-4a1f-a9b2-4089c8675690' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f3523565-4801-4a1f-a9b2-4089c8675690",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-02T08:00:42+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "bf7cb82b-543f-4fbc-8798-020fc58e4ced",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-02T08:00:42.436Z",
            "updated_at": "2023-02-02T08:00:42.436Z",
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
            "company_id": "72049e7f-5f5f-4df9-aef1-c3605840c1e1",
            "item_group_id": "061fd7ba-68e6-4c1e-8820-acf05d34fed0",
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
      "owner_id": "5e857016-38e1-4bc2-b8b6-253755125aa9",
      "owner_type": "orders",
      "employee_id": "13582c49-d60a-4cd9-af68-acc3d2a3e5f5"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/5e857016-38e1-4bc2-b8b6-253755125aa9"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/13582c49-d60a-4cd9-af68-acc3d2a3e5f5"
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






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
      "id": "151dba32-054c-426b-9d05-dbdd170ba6b3",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-03-01T14:47:58+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "b17fefb2-5f7a-410c-80de-a2379734a117",
        "owner_type": "orders",
        "employee_id": "b6d762cc-a89c-4904-8d34-848e079aa894"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/b17fefb2-5f7a-410c-80de-a2379734a117"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/b6d762cc-a89c-4904-8d34-848e079aa894"
          }
        }
      }
    },
    {
      "id": "33014f51-ed63-4954-9033-01afddf44aea",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-03-01T14:47:58+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "38c950c1-3555-474a-92a6-6e8c1a4e5408",
        "owner_type": "orders",
        "employee_id": "8ccde978-40c0-4e59-9eec-0d32a3d884d2"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/38c950c1-3555-474a-92a6-6e8c1a4e5408"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/8ccde978-40c0-4e59-9eec-0d32a3d884d2"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T14:47:52Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/9db0220d-3732-4ecc-8ec0-bfd8580976bc' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9db0220d-3732-4ecc-8ec0-bfd8580976bc",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-03-01T14:47:59+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "a0bfe3b0-6ae6-4df0-8d2d-9bccf0ff9567",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-03-01T14:47:59.825Z",
            "updated_at": "2023-03-01T14:47:59.825Z",
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
            "company_id": "4595d611-95c1-4828-a509-bca15bf42835",
            "item_group_id": "1181b15e-ea04-480d-9417-adb1ea550ef7",
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
      "owner_id": "7cb4cd1b-2468-4c4b-8d4c-0a95e8b41d7b",
      "owner_type": "orders",
      "employee_id": "7b039936-5cea-4fee-88b6-13d13f675090"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/7cb4cd1b-2468-4c4b-8d4c-0a95e8b41d7b"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/7b039936-5cea-4fee-88b6-13d13f675090"
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






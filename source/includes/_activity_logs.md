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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/a78241b6-085c-4086-8c6d-07c9e82be2a7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a78241b6-085c-4086-8c6d-07c9e82be2a7",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-05-20T09:29:39+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "bae3e401-8924-4ee7-9a99-cf9649144c2d",
            "legacy_id": null,
            "name": "Product 1000068",
            "quantity": 0,
            "created_at": "2024-05-20T09:29:39.526Z",
            "updated_at": "2024-05-20T09:29:39.526Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000071",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000068",
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
            "company_id": "dcebd184-eecc-4c1a-abb6-d3db9fd41b07",
            "item_group_id": "c63276dd-25a5-43bf-b14c-1b9b32ad0d98",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000068",
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
      "owner_id": "5467f351-5058-4892-84fe-9156fd6dbded",
      "owner_type": "orders",
      "employee_id": "606192be-de6e-4044-97e9-a11217e882b8"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/5467f351-5058-4892-84fe-9156fd6dbded"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/606192be-de6e-4044-97e9-a11217e882b8"
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
      "id": "8cd21d1e-a301-4f41-9860-ca4519b058df",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-05-20T09:29:41+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "2d9dc082-9779-4951-8ddc-3e09952a4d6c",
        "owner_type": "orders",
        "employee_id": "6d6f5455-48b2-48f7-ac44-4793364abd77"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/2d9dc082-9779-4951-8ddc-3e09952a4d6c"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/6d6f5455-48b2-48f7-ac44-4793364abd77"
          }
        }
      }
    },
    {
      "id": "891c55ab-c8f1-49c5-98ef-208ad7524dbc",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-05-20T09:29:40+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "793a106f-ef6d-4f20-a3fa-35cac3a7f391",
        "owner_type": "orders",
        "employee_id": "b2fa79cb-7bff-484b-967c-0731b94d4035"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/793a106f-ef6d-4f20-a3fa-35cac3a7f391"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/b2fa79cb-7bff-484b-967c-0731b94d4035"
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






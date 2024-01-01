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
      "id": "88513aee-1b9d-40c7-a425-250fe5ac823a",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-01-01T09:19:00+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "8f37fdcb-da86-42da-a872-e794f46e2772",
        "owner_type": "orders",
        "employee_id": "51d89e7f-2d9e-4e23-b086-7cedd9a9d259"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/8f37fdcb-da86-42da-a872-e794f46e2772"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/51d89e7f-2d9e-4e23-b086-7cedd9a9d259"
          }
        }
      }
    },
    {
      "id": "62c3d852-bbe8-4aef-86c4-fa920f461460",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-01-01T09:19:00+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "890b98e5-79a4-4c8e-b10a-690e743b1d8f",
        "owner_type": "orders",
        "employee_id": "8603f217-64db-43f4-a1a6-05f95d47817f"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/890b98e5-79a4-4c8e-b10a-690e743b1d8f"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/8603f217-64db-43f4-a1a6-05f95d47817f"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/69126c0e-ab3e-4bfc-8c45-344faac5031c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "69126c0e-ab3e-4bfc-8c45-344faac5031c",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-01-01T09:19:01+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "7f176494-1b1c-4e02-922e-f5398ccbf8f1",
            "legacy_id": null,
            "name": "Product 1000072",
            "quantity": 0,
            "created_at": "2024-01-01T09:19:01.513Z",
            "updated_at": "2024-01-01T09:19:01.513Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000075",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000072",
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
            "company_id": "fbf09449-e83a-4145-8b76-cf94e6e415fc",
            "item_group_id": "7f3db8f3-77a9-4d9c-9615-fb40263430d8",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000072",
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
      "owner_id": "35e29880-6f9a-461a-9852-a18b49d872f1",
      "owner_type": "orders",
      "employee_id": "9b7e8942-0ed6-4be2-adc8-27548c88e59f"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/35e29880-6f9a-461a-9852-a18b49d872f1"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/9b7e8942-0ed6-4be2-adc8-27548c88e59f"
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






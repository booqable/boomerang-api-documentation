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
      "id": "f90c54e3-a65d-4024-9ec9-b52130b9a6d3",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-06-10T09:29:28.624030+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "bd98ae17-4601-402b-b6b8-7f838e74aabb",
        "owner_type": "orders",
        "employee_id": "1ba7375c-4ccc-4bcf-984b-d47980728efe"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/bd98ae17-4601-402b-b6b8-7f838e74aabb"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/1ba7375c-4ccc-4bcf-984b-d47980728efe"
          }
        }
      }
    },
    {
      "id": "9a040f16-094e-4e92-abca-a8431afcabd0",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-06-10T09:29:28.464893+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "6def208b-a2c6-4339-adae-139d3aa9902e",
        "owner_type": "orders",
        "employee_id": "9a2846ea-1984-4afd-85b9-c8b16e337c90"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/6def208b-a2c6-4339-adae-139d3aa9902e"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/9a2846ea-1984-4afd-85b9-c8b16e337c90"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/0ed29c96-41d8-4936-97cb-eb210aa6363c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0ed29c96-41d8-4936-97cb-eb210aa6363c",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-06-10T09:29:29.404104+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "07c0cfb6-6b8a-4607-a29c-8a29c6f90b56",
            "legacy_id": null,
            "name": "Product 1000079",
            "quantity": 0,
            "created_at": "2024-06-10T09:29:29.256Z",
            "updated_at": "2024-06-10T09:29:29.256Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000082",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000079",
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
            "company_id": "8ea078b2-f7cb-4075-acbf-232a2e6b6cd9",
            "item_group_id": "1a31633e-750c-4ad1-aa49-74d3f3baa22c",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000079",
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
      "owner_id": "61ff1215-fb71-4b5d-a28b-6e77aeec8741",
      "owner_type": "orders",
      "employee_id": "bf27a398-3bb7-41c0-987d-d81881a9b1c0"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/61ff1215-fb71-4b5d-a28b-6e77aeec8741"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/bf27a398-3bb7-41c0-987d-d81881a9b1c0"
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






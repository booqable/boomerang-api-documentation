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
      "id": "39dca577-1b49-4562-b606-64524992f144",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-06-24T09:28:46.074653+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "5c7f82c9-2245-4919-bd90-87ac6e1869d2",
        "owner_type": "orders",
        "employee_id": "84040d31-bf99-458f-ac56-757949635e83"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/5c7f82c9-2245-4919-bd90-87ac6e1869d2"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/84040d31-bf99-458f-ac56-757949635e83"
          }
        }
      }
    },
    {
      "id": "d44914f5-4e81-4c23-b174-771d9a2f983c",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-06-24T09:28:45.865400+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "dadbd5b1-6025-4564-a663-14bc33bb8b42",
        "owner_type": "orders",
        "employee_id": "82d606c3-8e48-4b01-9084-4a6958978071"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/dadbd5b1-6025-4564-a663-14bc33bb8b42"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/82d606c3-8e48-4b01-9084-4a6958978071"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/418fde83-1a07-4d99-914e-f2fc97fe70cc' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "418fde83-1a07-4d99-914e-f2fc97fe70cc",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-06-24T09:28:47.019039+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "bfd9de3d-3c6c-4029-9c91-7bc189b7df6a",
            "legacy_id": null,
            "name": "Product 1000052",
            "quantity": 0,
            "created_at": "2024-06-24T09:28:46.812Z",
            "updated_at": "2024-06-24T09:28:46.812Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000054",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000052",
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
            "company_id": "e1d2c7ca-1229-4d58-a3c7-d8d48534fbb5",
            "item_group_id": "6c7abcd7-53f3-4993-82fc-1cbbd4cedea0",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000052",
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
      "owner_id": "fb8df2c7-b2ac-4f22-b8a3-148672e98ef7",
      "owner_type": "orders",
      "employee_id": "9d3a4a7f-2a8b-47fb-bfa7-573917214a2c"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/fb8df2c7-b2ac-4f22-b8a3-148672e98ef7"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/9d3a4a7f-2a8b-47fb-bfa7-573917214a2c"
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






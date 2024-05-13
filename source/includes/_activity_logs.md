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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/a59ce9b4-cac9-4691-ab59-8ef2d50f6258' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a59ce9b4-cac9-4691-ab59-8ef2d50f6258",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-05-13T09:25:04+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "6bec4645-0d59-4e39-8310-840d78c996b9",
            "legacy_id": null,
            "name": "Product 1000031",
            "quantity": 0,
            "created_at": "2024-05-13T09:25:03.806Z",
            "updated_at": "2024-05-13T09:25:03.806Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000032",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000031",
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
            "company_id": "257b9f59-dd24-451a-abef-a8e465f8de3a",
            "item_group_id": "a8b6a8f2-cea2-48cc-8ba7-eaebd8f2c194",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000031",
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
      "owner_id": "ee91587b-5bbd-4285-88ac-c5bb16807cfa",
      "owner_type": "orders",
      "employee_id": "3fdde41c-7b1c-4a71-87db-164d76b77ce3"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/ee91587b-5bbd-4285-88ac-c5bb16807cfa"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/3fdde41c-7b1c-4a71-87db-164d76b77ce3"
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
      "id": "23f84348-a3ca-491c-aec2-c1cf35177ec0",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-05-13T09:25:06+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "eef8dd0a-8ced-46b1-8976-76458f29186b",
        "owner_type": "orders",
        "employee_id": "75ae03c9-63f8-49d4-91dc-d709636d248b"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/eef8dd0a-8ced-46b1-8976-76458f29186b"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/75ae03c9-63f8-49d4-91dc-d709636d248b"
          }
        }
      }
    },
    {
      "id": "789d7c59-1edc-4aab-8d17-d9d6a8bfcbe4",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-05-13T09:25:06+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "9dcdb8b8-8243-4e3f-933f-20b824460466",
        "owner_type": "orders",
        "employee_id": "618fa248-1306-4212-acc1-39bff84caa01"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/9dcdb8b8-8243-4e3f-933f-20b824460466"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/618fa248-1306-4212-acc1-39bff84caa01"
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






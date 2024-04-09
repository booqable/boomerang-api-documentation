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
      "id": "cf7ce3b0-f830-434b-8f3b-99dc56e156ff",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-04-09T07:43:04+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "d976e854-128b-4cdb-ab5b-96468e070467",
        "owner_type": "orders",
        "employee_id": "23eaae69-2365-43ff-8a7a-f12ff71c3904"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/d976e854-128b-4cdb-ab5b-96468e070467"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/23eaae69-2365-43ff-8a7a-f12ff71c3904"
          }
        }
      }
    },
    {
      "id": "6142c257-c8bc-4230-91dd-3db07717d0c8",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-04-09T07:43:04+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "04f0e4e3-702b-4d89-b9fb-19f2899dbe8c",
        "owner_type": "orders",
        "employee_id": "351b918b-3e2f-427d-aeeb-0bf7672fb230"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/04f0e4e3-702b-4d89-b9fb-19f2899dbe8c"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/351b918b-3e2f-427d-aeeb-0bf7672fb230"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/bbaab844-ce52-42d4-aa24-34c900ec5c7e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bbaab844-ce52-42d4-aa24-34c900ec5c7e",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-04-09T07:43:05+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "61772e55-a758-40ed-82ae-121fcfb9daeb",
            "legacy_id": null,
            "name": "Product 1000064",
            "quantity": 0,
            "created_at": "2024-04-09T07:43:05.200Z",
            "updated_at": "2024-04-09T07:43:05.200Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000067",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000064",
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
            "company_id": "72e39146-8215-48e9-af79-ec85cf542b85",
            "item_group_id": "8b14a09f-4be4-41c4-a9b4-474be3ff38bd",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000064",
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
      "owner_id": "ddcc5a61-41be-45e0-ba14-6239ce6a1e25",
      "owner_type": "orders",
      "employee_id": "1d3e8bf3-78c2-4608-bc6b-cfc7788af581"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/ddcc5a61-41be-45e0-ba14-6239ce6a1e25"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/1d3e8bf3-78c2-4608-bc6b-cfc7788af581"
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






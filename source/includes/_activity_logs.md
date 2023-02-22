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
      "id": "5eb76e11-2ed8-4f5a-a602-a79c478d8736",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-22T11:51:24+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "86a60473-159b-4c7e-85f0-681443a1f216",
        "owner_type": "orders",
        "employee_id": "fcd48636-f60b-4770-81bf-471822ad3f03"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/86a60473-159b-4c7e-85f0-681443a1f216"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/fcd48636-f60b-4770-81bf-471822ad3f03"
          }
        }
      }
    },
    {
      "id": "b7f08b3d-8969-4438-bf5d-d7aeb8302684",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-22T11:51:24+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "b5f28f24-f73c-4dbe-9370-3f4c062486ae",
        "owner_type": "orders",
        "employee_id": "469b4db0-0187-4d81-80a2-7d2085e63d05"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/b5f28f24-f73c-4dbe-9370-3f4c062486ae"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/469b4db0-0187-4d81-80a2-7d2085e63d05"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T11:51:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/a14ba944-57e2-49e7-8946-485d1b92ff9a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a14ba944-57e2-49e7-8946-485d1b92ff9a",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-22T11:51:25+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "6706877f-6fed-4385-83f3-46ad76ba50d3",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-22T11:51:25.799Z",
            "updated_at": "2023-02-22T11:51:25.799Z",
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
            "company_id": "4d30b871-2c6a-4f81-8b1b-117d3ca5e924",
            "item_group_id": "3f9655b2-8208-494c-9b9b-ddfc2861d77a",
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
      "owner_id": "183ad9ab-b33e-415a-b79a-6a35fa4f62ae",
      "owner_type": "orders",
      "employee_id": "eb82bc13-db63-448d-b83f-cad6cb443736"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/183ad9ab-b33e-415a-b79a-6a35fa4f62ae"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/eb82bc13-db63-448d-b83f-cad6cb443736"
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






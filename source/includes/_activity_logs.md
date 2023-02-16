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
      "id": "2f5eacef-6a80-453b-8647-d7cd135c85e0",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-16T11:19:15+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "f1fa8888-2496-4b5e-adb0-83a17b50812a",
        "owner_type": "orders",
        "employee_id": "d542b20b-ecb0-4a52-917e-bbb82ea3de4a"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/f1fa8888-2496-4b5e-adb0-83a17b50812a"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/d542b20b-ecb0-4a52-917e-bbb82ea3de4a"
          }
        }
      }
    },
    {
      "id": "7f0a1bb0-1554-4d02-8c9a-d1043bb788dd",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-16T11:19:14+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "3660a2cb-191b-488d-85bd-64ff92f8a321",
        "owner_type": "orders",
        "employee_id": "237043f7-bd9d-4645-83cc-e3f73ce60adf"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/3660a2cb-191b-488d-85bd-64ff92f8a321"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/237043f7-bd9d-4645-83cc-e3f73ce60adf"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T11:19:07Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/fac7a5cb-e92b-4257-a1af-e3fb16e0bcb4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fac7a5cb-e92b-4257-a1af-e3fb16e0bcb4",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-16T11:19:17+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "4b554fdb-8b98-4e16-bc85-b55ce5e8a317",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-16T11:19:17.191Z",
            "updated_at": "2023-02-16T11:19:17.191Z",
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
            "company_id": "ff8bc506-42b2-4809-99ff-0ef1f87a6728",
            "item_group_id": "f5b276e5-1998-46d7-b599-45a481b8ae97",
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
      "owner_id": "dc190d1b-28b8-4b94-9183-064c4940162e",
      "owner_type": "orders",
      "employee_id": "4c01933b-8c25-47a2-8e8b-7e70a0b9b0fd"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/dc190d1b-28b8-4b94-9183-064c4940162e"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/4c01933b-8c25-47a2-8e8b-7e70a0b9b0fd"
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






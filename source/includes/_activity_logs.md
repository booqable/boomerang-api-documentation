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
      "id": "f99bce4f-a3f8-42a5-a59a-5efc9d20d775",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-09T10:17:46+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "b4ff4535-d088-4804-bab7-fd66c73dee9f",
        "owner_type": "orders",
        "employee_id": "4fea4f23-e361-4811-a03a-aa744b26723e"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/b4ff4535-d088-4804-bab7-fd66c73dee9f"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/4fea4f23-e361-4811-a03a-aa744b26723e"
          }
        }
      }
    },
    {
      "id": "c3106bb4-fdc3-473e-9f8b-e0f69daa0712",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-09T10:17:46+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "ff191c88-d44f-4fe8-9983-39059f7dacc4",
        "owner_type": "orders",
        "employee_id": "257efdac-2c34-4839-8ed1-c3807d7354e5"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/ff191c88-d44f-4fe8-9983-39059f7dacc4"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/257efdac-2c34-4839-8ed1-c3807d7354e5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:17:40Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/35bf821c-c060-4de0-93a1-4b0a17409a19' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "35bf821c-c060-4de0-93a1-4b0a17409a19",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-09T10:17:47+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "9cb5eaba-3f4f-4439-8047-1c8ca2de0e0f",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-09T10:17:47.885Z",
            "updated_at": "2023-02-09T10:17:47.885Z",
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
            "company_id": "5a5c9a03-aadb-42f2-8505-ec5b185c1a94",
            "item_group_id": "746b7dae-57e3-41a1-ad43-2238eae9a9b5",
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
      "owner_id": "fd1b9316-bfd9-4cee-a585-c7c8b501b84f",
      "owner_type": "orders",
      "employee_id": "69938426-3c81-443b-a144-555bd42cd1aa"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/fd1b9316-bfd9-4cee-a585-c7c8b501b84f"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/69938426-3c81-443b-a144-555bd42cd1aa"
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






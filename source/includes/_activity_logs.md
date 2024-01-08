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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/99f5b812-364b-40f8-b4f2-119188721d55' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "99f5b812-364b-40f8-b4f2-119188721d55",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-01-08T09:19:22+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "1a07fc6b-e653-496e-93a4-eb6f5937ab08",
            "legacy_id": null,
            "name": "Product 1000042",
            "quantity": 0,
            "created_at": "2024-01-08T09:19:21.820Z",
            "updated_at": "2024-01-08T09:19:21.820Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000045",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000042",
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
            "company_id": "d65d9230-fba3-4ef9-b6a3-397afa5593ec",
            "item_group_id": "596b6a74-3045-46d0-ac52-9b45dc50a307",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000042",
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
      "owner_id": "4f5103fc-ff40-49ad-b05e-5aba37a54ec4",
      "owner_type": "orders",
      "employee_id": "a4ab83b2-1f3b-4251-87ae-8b17e20b135b"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/4f5103fc-ff40-49ad-b05e-5aba37a54ec4"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/a4ab83b2-1f3b-4251-87ae-8b17e20b135b"
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
      "id": "06b66afd-eed7-4413-b444-1be8a15e7f9d",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-01-08T09:19:23+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "f2e4ad81-44ed-4b94-bdfe-c6944699d13f",
        "owner_type": "orders",
        "employee_id": "06f7dc0b-0a2c-48fd-a77f-1e8b8c6a734e"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/f2e4ad81-44ed-4b94-bdfe-c6944699d13f"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/06f7dc0b-0a2c-48fd-a77f-1e8b8c6a734e"
          }
        }
      }
    },
    {
      "id": "7918ca83-ae11-4e3a-9b06-4ad8d9f0072f",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-01-08T09:19:23+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "5c91238e-c403-462e-a659-9693a2a461cb",
        "owner_type": "orders",
        "employee_id": "d984a170-d2d2-47f6-bef6-25cb29ff25c3"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/5c91238e-c403-462e-a659-9693a2a461cb"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/d984a170-d2d2-47f6-bef6-25cb29ff25c3"
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






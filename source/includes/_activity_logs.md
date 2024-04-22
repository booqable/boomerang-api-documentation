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
      "id": "c732c910-c4d4-4730-88f2-f5c64a39bd87",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-04-22T09:28:10+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "92d001cd-b8a6-4d0d-8d3e-e2b224851b7d",
        "owner_type": "orders",
        "employee_id": "ec9b41a1-0a0c-4889-945b-88794309901f"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/92d001cd-b8a6-4d0d-8d3e-e2b224851b7d"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/ec9b41a1-0a0c-4889-945b-88794309901f"
          }
        }
      }
    },
    {
      "id": "95c84f75-a3ed-4405-a597-58121ba7da18",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-04-22T09:28:10+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "80a3ad6d-5b92-47ad-aae3-9e669d01c129",
        "owner_type": "orders",
        "employee_id": "81c91e26-b21d-48b1-8f55-49c948e8ca78"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/80a3ad6d-5b92-47ad-aae3-9e669d01c129"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/81c91e26-b21d-48b1-8f55-49c948e8ca78"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/c20066d5-ed45-461c-a2dc-07c2a2d3dc15' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c20066d5-ed45-461c-a2dc-07c2a2d3dc15",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-04-22T09:28:11+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "14b774c6-e2f7-4957-be2f-25d39b081cb7",
            "legacy_id": null,
            "name": "Product 1000078",
            "quantity": 0,
            "created_at": "2024-04-22T09:28:11.266Z",
            "updated_at": "2024-04-22T09:28:11.266Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000081",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000078",
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
            "company_id": "df7a0b69-4a99-4837-a3d7-4ac60ccd8685",
            "item_group_id": "aaf43c19-42d3-446d-b7b4-1b2534fc5ba7",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000078",
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
      "owner_id": "3f7d5ef8-5833-4939-b7fc-f18abc320904",
      "owner_type": "orders",
      "employee_id": "51f13c0d-baab-4f3b-bc1b-2148cbf9ca00"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/3f7d5ef8-5833-4939-b7fc-f18abc320904"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/51f13c0d-baab-4f3b-bc1b-2148cbf9ca00"
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






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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/1675bd71-790f-468c-bfa8-cb3d3470c5d6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1675bd71-790f-468c-bfa8-cb3d3470c5d6",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-12-07T18:36:05+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "e7ea7602-28d3-4b71-80df-1b3e8518cd77",
            "legacy_id": null,
            "name": "Product 1000000",
            "quantity": 0,
            "created_at": "2023-12-07T18:36:05.363Z",
            "updated_at": "2023-12-07T18:36:05.363Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000000",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000000",
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
            "company_id": "639fb0ee-e36c-473f-b65b-a9104bad4141",
            "item_group_id": "15101da2-b249-4c3c-b26e-00b7ab0eea1f",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000000",
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
      "owner_id": "1d3b3039-b153-4d4e-b8b1-6250b927542c",
      "owner_type": "orders",
      "employee_id": "ac85488f-7449-4f4e-9e4a-5b5eb739ea7f"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/1d3b3039-b153-4d4e-b8b1-6250b927542c"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/ac85488f-7449-4f4e-9e4a-5b5eb739ea7f"
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
      "id": "98f62158-5ae7-4d39-b413-3092cb575c81",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-12-07T18:36:06+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "1f8a3ea1-5cb1-4bb8-9114-9bdc84b807c2",
        "owner_type": "orders",
        "employee_id": "d7d16e12-c9a6-4839-8948-b91323343c1d"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/1f8a3ea1-5cb1-4bb8-9114-9bdc84b807c2"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/d7d16e12-c9a6-4839-8948-b91323343c1d"
          }
        }
      }
    },
    {
      "id": "3b515d57-79e4-4d40-85f4-2aec885aee2a",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-12-07T18:36:06+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "27d3dfb0-d152-4751-aac8-ffe2d30f64cd",
        "owner_type": "orders",
        "employee_id": "082a02ee-2314-487b-a524-cbab6e2b7cfa"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/27d3dfb0-d152-4751-aac8-ffe2d30f64cd"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/082a02ee-2314-487b-a524-cbab6e2b7cfa"
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






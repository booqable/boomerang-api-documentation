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
      "id": "efd89c2c-ad3f-4606-8dc4-0c0010fee3d3",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-02-12T09:14:14+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "336b175a-a8ce-4449-8ce3-e22c45dcafd9",
        "owner_type": "orders",
        "employee_id": "c92f81f8-54f5-479d-a510-f44fcf93021e"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/336b175a-a8ce-4449-8ce3-e22c45dcafd9"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/c92f81f8-54f5-479d-a510-f44fcf93021e"
          }
        }
      }
    },
    {
      "id": "c533fd80-e11f-4fab-ab10-97eff0c24b0b",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-02-12T09:14:13+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "0d536c0e-34ee-4c0f-a7e7-1e0521f83e35",
        "owner_type": "orders",
        "employee_id": "f9366cef-da7a-49b6-a752-ac86d85a99cf"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/0d536c0e-34ee-4c0f-a7e7-1e0521f83e35"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/f9366cef-da7a-49b6-a752-ac86d85a99cf"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/3777f8c0-5edf-4547-9ae6-b438923fb860' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3777f8c0-5edf-4547-9ae6-b438923fb860",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-02-12T09:14:14+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "605357c0-a1cc-4758-bd5b-4cd37d8ff186",
            "legacy_id": null,
            "name": "Product 1000007",
            "quantity": 0,
            "created_at": "2024-02-12T09:14:14.694Z",
            "updated_at": "2024-02-12T09:14:14.694Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000010",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000007",
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
            "company_id": "b69da0e2-86ef-4cbf-9312-8629cb4327e3",
            "item_group_id": "00b8d45f-f1a1-45bd-8c62-c5c10cbd97b4",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000007",
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
      "owner_id": "b133f3ce-acdf-477e-ab97-dc27a1ddd8e0",
      "owner_type": "orders",
      "employee_id": "6ae89e66-6ad0-4cf2-97b9-20eea0428a5a"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/b133f3ce-acdf-477e-ab97-dc27a1ddd8e0"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/6ae89e66-6ad0-4cf2-97b9-20eea0428a5a"
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






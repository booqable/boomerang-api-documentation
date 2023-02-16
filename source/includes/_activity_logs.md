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
      "id": "84e64ead-247c-45cb-af43-7689d07d4bf2",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-16T09:14:05+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "378dddd9-1e5b-4951-b668-d300052d613f",
        "owner_type": "orders",
        "employee_id": "63c3acaf-f7e2-43a9-a1ad-d3e5741b44b2"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/378dddd9-1e5b-4951-b668-d300052d613f"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/63c3acaf-f7e2-43a9-a1ad-d3e5741b44b2"
          }
        }
      }
    },
    {
      "id": "0c80e7a0-d2a1-4e15-a000-619c3286a74d",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-16T09:14:04+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "dfe042ae-0220-4a00-a5bd-6f39ff2aec5e",
        "owner_type": "orders",
        "employee_id": "76ba9829-949a-43ef-88ee-27f249704522"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/dfe042ae-0220-4a00-a5bd-6f39ff2aec5e"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/76ba9829-949a-43ef-88ee-27f249704522"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T09:13:58Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/07d398fc-ab7f-4105-9703-849ad5521dc9' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "07d398fc-ab7f-4105-9703-849ad5521dc9",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-16T09:14:08+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "5061f6c2-b3aa-4124-97b2-ce967076e604",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-16T09:14:07.965Z",
            "updated_at": "2023-02-16T09:14:07.965Z",
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
            "company_id": "cf03e858-6c11-431b-8b01-38315663aacc",
            "item_group_id": "57330cbd-f31c-4ac6-ada3-5e7329e4363c",
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
      "owner_id": "a50d1df2-5875-4330-8c57-5841a84c83a1",
      "owner_type": "orders",
      "employee_id": "c648c4ec-87cd-4439-99ca-5a84c891d510"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/a50d1df2-5875-4330-8c57-5841a84c83a1"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/c648c4ec-87cd-4439-99ca-5a84c891d510"
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






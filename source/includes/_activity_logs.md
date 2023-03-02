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
      "id": "3b4027b9-4f3a-4df8-b689-6e1dbf3bba7b",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-03-02T09:22:50+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "0a113476-2792-4644-a32d-fa3c7edeb7f8",
        "owner_type": "orders",
        "employee_id": "fe71117e-17cd-48c1-8415-8a98d29fc3e6"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/0a113476-2792-4644-a32d-fa3c7edeb7f8"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/fe71117e-17cd-48c1-8415-8a98d29fc3e6"
          }
        }
      }
    },
    {
      "id": "47c575ae-d307-4a5c-af41-ca5d92c1b9d7",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-03-02T09:22:50+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "cc89c71c-621e-43ab-94cc-ff3cce34b53e",
        "owner_type": "orders",
        "employee_id": "2fba1f37-af14-41b1-b194-9d6d2d206d1e"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/cc89c71c-621e-43ab-94cc-ff3cce34b53e"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/2fba1f37-af14-41b1-b194-9d6d2d206d1e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T09:22:41Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/c6281c43-b350-4d74-8919-be455386a82b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c6281c43-b350-4d74-8919-be455386a82b",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-03-02T09:22:53+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "364de4be-5d9a-488c-97b5-3db2034275fa",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-03-02T09:22:53.557Z",
            "updated_at": "2023-03-02T09:22:53.557Z",
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
            "company_id": "d11599c0-347d-4c29-b147-3772610f646c",
            "item_group_id": "e284c874-3029-4d90-a25e-ca4f227392db",
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
      "owner_id": "1423afd9-0c45-4feb-92f6-84014984d7ec",
      "owner_type": "orders",
      "employee_id": "7559dff3-aefa-4d53-b1b5-31da7587022f"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/1423afd9-0c45-4feb-92f6-84014984d7ec"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/7559dff3-aefa-4d53-b1b5-31da7587022f"
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






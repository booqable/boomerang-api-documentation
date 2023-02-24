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
      "id": "143ac1c3-c956-41af-b625-2431be6ba208",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-24T14:55:06+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "1519d546-2685-4ec5-9647-c72dcd028b87",
        "owner_type": "orders",
        "employee_id": "3656f0f4-ed49-4877-9bd0-cdfdfafe081d"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/1519d546-2685-4ec5-9647-c72dcd028b87"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/3656f0f4-ed49-4877-9bd0-cdfdfafe081d"
          }
        }
      }
    },
    {
      "id": "abf4d007-5aef-4446-bb6c-4546503b2e4d",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-02-24T14:55:05+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "7a89e338-3bc4-4d6e-9fc2-770de0f63e67",
        "owner_type": "orders",
        "employee_id": "dc7c21fb-4896-4690-8bb4-38acef9a2eef"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/7a89e338-3bc4-4d6e-9fc2-770de0f63e67"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/dc7c21fb-4896-4690-8bb4-38acef9a2eef"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T14:54:59Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/ff33c684-a1d4-4ae4-b67e-9ed9a2b6c47b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ff33c684-a1d4-4ae4-b67e-9ed9a2b6c47b",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-02-24T14:55:07+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "9b67ff09-7467-42d3-82f6-de054ee83e63",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-02-24T14:55:07.327Z",
            "updated_at": "2023-02-24T14:55:07.327Z",
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
            "company_id": "1357445a-08b5-4dd5-8197-f9c419cb89bf",
            "item_group_id": "7588ff61-72a5-4b90-bb7b-b1f8dca4820c",
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
      "owner_id": "d360798b-5aba-4b9a-8044-9afa27c4231e",
      "owner_type": "orders",
      "employee_id": "12ba297e-835b-47d4-a418-b3e769f08c98"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/d360798b-5aba-4b9a-8044-9afa27c4231e"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/12ba297e-835b-47d4-a418-b3e769f08c98"
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






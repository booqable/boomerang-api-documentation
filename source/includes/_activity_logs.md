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
      "id": "e7c8b809-7b91-4397-8bbe-ae49137c2bb0",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-03-08T09:17:39+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "efffaceb-5a2d-4bc0-8bc0-2a3e0b1f696d",
        "owner_type": "orders",
        "employee_id": "61f847c1-7eea-4b00-9cd5-6daedbe47b5b"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/efffaceb-5a2d-4bc0-8bc0-2a3e0b1f696d"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/61f847c1-7eea-4b00-9cd5-6daedbe47b5b"
          }
        }
      }
    },
    {
      "id": "4b137d57-1d34-4006-8c13-91506e07147c",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-03-08T09:17:39+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "b739da55-190d-4e42-a58d-ba640d278d85",
        "owner_type": "orders",
        "employee_id": "9e91f7db-a963-4341-bca2-92449018b294"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/b739da55-190d-4e42-a58d-ba640d278d85"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/9e91f7db-a963-4341-bca2-92449018b294"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T09:17:33Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/c25d7a98-b71a-46ef-aaa6-d9efad1f3ddb' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c25d7a98-b71a-46ef-aaa6-d9efad1f3ddb",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-03-08T09:17:40+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "2d1cec80-26d6-4b47-9856-cd92d72d6255",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-03-08T09:17:40.598Z",
            "updated_at": "2023-03-08T09:17:40.598Z",
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
            "company_id": "a57a009b-80ca-4b68-a118-2dce38116f65",
            "item_group_id": "af7278f7-a3f7-4e8f-bc10-bba08fd7c56d",
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
      "owner_id": "14ad8dd1-1838-4013-9cd1-0b3849d74e67",
      "owner_type": "orders",
      "employee_id": "ab2fdc06-1866-4064-a279-84718b167564"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/14ad8dd1-1838-4013-9cd1-0b3849d74e67"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/ab2fdc06-1866-4064-a279-84718b167564"
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






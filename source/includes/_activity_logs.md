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
      "id": "7cf668da-77d2-4c9b-b023-148912ad208c",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-03-08T07:51:53+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "1240f8a2-ae51-4cc4-8623-e88e90be9bb2",
        "owner_type": "orders",
        "employee_id": "3be90557-22bb-40e3-b022-ae44bdf1da1f"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/1240f8a2-ae51-4cc4-8623-e88e90be9bb2"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/3be90557-22bb-40e3-b022-ae44bdf1da1f"
          }
        }
      }
    },
    {
      "id": "bd8d6a4d-c10f-4ac7-ac48-ca66fd7131b5",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-03-08T07:51:53+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "a063857d-ee93-48ac-93e2-ee64261c3d0f",
        "owner_type": "orders",
        "employee_id": "cd969673-b500-4489-b7de-f7b16cfc6c04"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/a063857d-ee93-48ac-93e2-ee64261c3d0f"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/cd969673-b500-4489-b7de-f7b16cfc6c04"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T07:51:48Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/0e2042a5-e9dc-4ff0-a3a2-416be86977aa' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0e2042a5-e9dc-4ff0-a3a2-416be86977aa",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-03-08T07:51:55+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "7037a313-2982-4619-8b8d-5dd0a9135c3e",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-03-08T07:51:55.027Z",
            "updated_at": "2023-03-08T07:51:55.027Z",
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
            "company_id": "22184668-8c5a-495b-9084-29379c29fdaf",
            "item_group_id": "43066940-112a-4669-a369-4be8106b07f3",
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
      "owner_id": "914081ff-4bf4-4e6e-8192-433556cd0f53",
      "owner_type": "orders",
      "employee_id": "87b864b9-458d-476b-91e3-d8be01acdab9"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/914081ff-4bf4-4e6e-8192-433556cd0f53"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/87b864b9-458d-476b-91e3-d8be01acdab9"
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






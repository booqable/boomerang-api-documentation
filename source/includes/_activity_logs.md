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
      "id": "7afb3432-c68f-4d56-a64c-b03a37b4785b",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-01-12T14:26:13+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "f405454c-c8cf-49f0-8b86-41bf1d6a8351",
        "owner_type": "orders",
        "employee_id": "7b273cad-3f53-42e8-b081-232e50ae9c89"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/f405454c-c8cf-49f0-8b86-41bf1d6a8351"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/7b273cad-3f53-42e8-b081-232e50ae9c89"
          }
        }
      }
    },
    {
      "id": "55109fb6-8757-42e8-ad2c-6113238e9a50",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-01-12T14:26:13+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "e7a7e3a8-7e4c-49ee-bb5f-23c05a456517",
        "owner_type": "orders",
        "employee_id": "cf023b99-e6d8-41c8-9345-84bde5842209"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/e7a7e3a8-7e4c-49ee-bb5f-23c05a456517"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/cf023b99-e6d8-41c8-9345-84bde5842209"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-12T14:26:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/7685d959-a827-45ae-87bb-1bbee50f1275' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7685d959-a827-45ae-87bb-1bbee50f1275",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-01-12T14:26:14+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "f1d99be8-aebe-4b46-b835-3ee75e86676e",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-01-12T14:26:14.823Z",
            "updated_at": "2023-01-12T14:26:14.823Z",
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
            "company_id": "6b1efdde-c96c-4c99-9e9b-f9fc1783dadc",
            "item_group_id": "e68db87b-c941-4cb1-bdab-38cfafc42c8c",
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
            "tag_list": null
          }
        ]
      },
      "owner_id": "99cb42e5-c9c2-4fe5-b404-975a0a8a266f",
      "owner_type": "orders",
      "employee_id": "d3a70fe3-c3a3-4797-a4ea-5b4543bcb837"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/99cb42e5-c9c2-4fe5-b404-975a0a8a266f"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/d3a70fe3-c3a3-4797-a4ea-5b4543bcb837"
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






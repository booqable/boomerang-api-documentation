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
`employee_id` | **Uuid** <br>The associated Employee
`action_key` | **String** <br>The name of the event that the activity log describes. This determines which translated summary line will be displayed in the web client. Examples are "product.created" or "order.updated".
`action_args` | **Hash** <br>Arguments that can be passed to enrich the summary line of the web client with details, such as a product name.
`has_data` | **Boolean** `readonly`<br>Boolean value flag indicating whether this activity log contains additional data describing the subject of the event.
`owner_id` | **Uuid** <br>ID of the subject the event is about.
`owner_type` | **String** <br>Class of the subject the event is about
`data` | **Hash** `extra` `readonly`<br>Hash containing (details on) the subject(s) of the event this activity log describes. The subject(s) are contained in individual arrays grouped by their type. For example: { products: [{ id: 1, name: 'Product 1'}] } 


## Relationships
Activity logs have the following relationships:

Name | Description
- | -
`owner` | **Customer, Product, Product group, Stock item, Bundle, Order, Document**<br>Associated Owner
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
      "id": "63fe239c-71ea-430c-9517-40bc1d2f013e",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-01-05T13:07:37+00:00",
        "employee_id": "90095e54-cc06-4191-ab79-06c50805eff5",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "1d9d446d-63af-40aa-9659-b460cd56de50",
        "owner_type": "orders"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/1d9d446d-63af-40aa-9659-b460cd56de50"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/90095e54-cc06-4191-ab79-06c50805eff5"
          }
        }
      }
    },
    {
      "id": "772467a7-0c3f-4d13-b19c-dd4bac1e44c0",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2023-01-05T13:07:36+00:00",
        "employee_id": "07739378-644e-4798-89e9-c88886d80de3",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "99e8fd6f-9375-4e0f-bf1d-bef1a124a668",
        "owner_type": "orders"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/99e8fd6f-9375-4e0f-bf1d-bef1a124a668"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/07739378-644e-4798-89e9-c88886d80de3"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:07:31Z`
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
`employee_id` | **Uuid** <br>`eq`, `not_eq`
`action_key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/deb6d503-a370-4298-8df5-6a129ff6c6a4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "deb6d503-a370-4298-8df5-6a129ff6c6a4",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2023-01-05T13:07:39+00:00",
      "employee_id": "d9bcc439-87a3-422f-b341-7e3032d70b67",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "5347bf43-d74c-41a0-8c3d-5c97a15afebb",
            "legacy_id": null,
            "name": "Product 3",
            "quantity": 0,
            "created_at": "2023-01-05T13:07:39.026Z",
            "updated_at": "2023-01-05T13:07:39.026Z",
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
            "company_id": "fce27958-f22c-44e3-8365-314165f90be0",
            "item_group_id": "3b1b7618-1326-4572-adf4-9b58952246c6",
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
      "owner_id": "f5e9066e-f861-4c30-8d43-d3d541a3f21c",
      "owner_type": "orders"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/f5e9066e-f861-4c30-8d43-d3d541a3f21c"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/d9bcc439-87a3-422f-b341-7e3032d70b67"
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






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
      "id": "1e1c67e5-e598-4c7b-b419-9baf21552447",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-06-17T09:26:08.357475+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "bc15f2b6-c798-4693-b883-9d8fb9f5d184",
        "owner_type": "orders",
        "employee_id": "b84f13b2-4a78-419d-9d76-579621be658b"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/bc15f2b6-c798-4693-b883-9d8fb9f5d184"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/b84f13b2-4a78-419d-9d76-579621be658b"
          }
        }
      }
    },
    {
      "id": "9d3ddf06-9ebf-4e3d-9e2d-b15156db55a3",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-06-17T09:26:08.157651+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "45e85553-5eab-4ea2-a7ae-6823f4b95734",
        "owner_type": "orders",
        "employee_id": "5f5bce83-a86c-482e-9763-0c1a258ef657"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/45e85553-5eab-4ea2-a7ae-6823f4b95734"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/5f5bce83-a86c-482e-9763-0c1a258ef657"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/9d61085f-aef5-4498-8bc7-615a5ad26f86' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9d61085f-aef5-4498-8bc7-615a5ad26f86",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-06-17T09:26:07.175285+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "ce98189c-20c6-419c-ba8f-99864ffa690a",
            "legacy_id": null,
            "name": "Product 1000028",
            "quantity": 0,
            "created_at": "2024-06-17T09:26:06.985Z",
            "updated_at": "2024-06-17T09:26:06.985Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000030",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000028",
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
            "company_id": "ed78543a-1e49-4170-af77-1f199343ecbb",
            "item_group_id": "06c51574-29e6-436e-86ce-8eb7b400a8e2",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000028",
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
      "owner_id": "3e2016e0-a89f-4043-822a-f6d8add4532c",
      "owner_type": "orders",
      "employee_id": "23b548cd-d39b-4ee0-9b94-f03ec77091c2"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/3e2016e0-a89f-4043-822a-f6d8add4532c"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/23b548cd-d39b-4ee0-9b94-f03ec77091c2"
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






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
      "id": "46305218-526c-42ca-aa01-592c6c68c3f6",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-01-22T09:15:09+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "4ad2b988-61d5-4ebc-abad-3df664041165",
        "owner_type": "orders",
        "employee_id": "ba7ce6e6-1424-4a87-8459-0d881c050831"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/4ad2b988-61d5-4ebc-abad-3df664041165"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/ba7ce6e6-1424-4a87-8459-0d881c050831"
          }
        }
      }
    },
    {
      "id": "e177c306-d5cb-48ce-b719-d30b1cb7815f",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-01-22T09:15:09+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "5aa1251f-d2ef-435c-809f-686505a72822",
        "owner_type": "orders",
        "employee_id": "6f616bf5-94fa-4632-96f1-a3420b778681"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/orders/5aa1251f-d2ef-435c-809f-686505a72822"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/6f616bf5-94fa-4632-96f1-a3420b778681"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/c3bc8da5-9a26-4345-8a2f-421ef6f427a0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c3bc8da5-9a26-4345-8a2f-421ef6f427a0",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-01-22T09:15:10+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "36986196-4cbf-40d4-85c6-bca8fc2a4de6",
            "legacy_id": null,
            "name": "Product 1000025",
            "quantity": 0,
            "created_at": "2024-01-22T09:15:10.590Z",
            "updated_at": "2024-01-22T09:15:10.590Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000025",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000025",
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
            "company_id": "abc2b1d1-38fc-4351-a6d8-30d6cf53cbd4",
            "item_group_id": "25024fff-ca31-437b-be9f-e93956411e58",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000025",
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
      "owner_id": "6e898432-600f-4604-9068-d83ed92ef58c",
      "owner_type": "orders",
      "employee_id": "88537bae-3289-4a6d-9224-e8445adba01e"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/orders/6e898432-600f-4604-9068-d83ed92ef58c"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/88537bae-3289-4a6d-9224-e8445adba01e"
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






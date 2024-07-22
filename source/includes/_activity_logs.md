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
      "id": "e18e4de1-004a-4055-8b17-ae31cfdd64ea",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-07-22T09:32:38.438882+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "b9b7e194-66bc-43d3-b49b-af6a4b90e594",
        "owner_type": "orders",
        "employee_id": "0ba577d7-77f1-44b8-b0d3-f70912305eb2"
      },
      "relationships": {}
    },
    {
      "id": "d16e0e09-5ed0-4050-bad2-ec0b87aa80ae",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-07-22T09:32:37.918566+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "e6692c16-9c69-430c-a0d6-9ab2e2bb7e54",
        "owner_type": "orders",
        "employee_id": "5a5a1221-6372-4789-bfa7-4d6561edb754"
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/78379808-4c07-47eb-b15a-b0d3e2723327' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "78379808-4c07-47eb-b15a-b0d3e2723327",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-07-22T09:32:35.806901+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "925c58b4-6774-43cf-9297-6c92f9e4953f",
            "legacy_id": null,
            "name": "Product 1000075",
            "quantity": 0,
            "created_at": "2024-07-22T09:32:35.272Z",
            "updated_at": "2024-07-22T09:32:35.272Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000078",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000075",
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
            "company_id": "479d2299-e813-433c-83f4-971ffd109bf8",
            "item_group_id": "7d351ea8-62d0-470d-9ff0-c934a9e3d5ea",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000075",
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
      "owner_id": "eb27a4dc-8113-41c9-97ff-6b1be9cdb829",
      "owner_type": "orders",
      "employee_id": "575360f7-8281-4218-b678-5a0a7705d9f6"
    },
    "relationships": {}
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






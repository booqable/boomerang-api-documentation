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
`created_at` | **Datetime** `readonly`<br>When the activity happened.
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`action_key` | **String** <br>The name of the event that the activity log describes. This determines which translated summary line will be displayed in the web client. Examples are "product.created" or "order.updated".
`action_args` | **Hash** <br>Arguments that can be passed to enrich the summary line of the web client with details, such as a product name.
`has_data` | **Boolean** `readonly`<br>Boolean value flag indicating whether this activity log contains additional data describing the subject of the event.
`owner_id` | **Uuid** <br>ID of the subject the event is about.
`owner_type` | **String** <br>Class of the subject the event is about
`employee_id` | **Uuid** <br>The employee who performed the action.
`data` | **Hash** `readonly`<br>Hash containing (details on) the subject(s) of the event this activity log describes.


## Relationships
Activity logs have the following relationships:

Name | Description
-- | --
`employee` | **Employees** `readonly`<br>The employee who performed the action.
`owner` | **Customer, Product, Product group, Stock item, Bundle, Order, Document, Email** <br>Associated Owner


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
      "id": "307a60be-0313-4c96-a56a-c364afc0bf58",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-11-18T09:26:01.274513+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "914b0d42-29a7-4146-9469-94f43ba3a4c7",
        "owner_type": "orders",
        "employee_id": "48b92bbf-f199-430e-addf-1736fd6c075c"
      },
      "relationships": {}
    },
    {
      "id": "1e56416a-c3cb-4b70-8aff-9649107b93bb",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-11-18T09:26:01.054727+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "owner_id": "5983afef-fe12-42e9-be6c-859a82c61559",
        "owner_type": "orders",
        "employee_id": "87517ff4-0eef-4db4-a4b5-0d6ad2824244"
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/aeedae4b-9fe5-4713-b2ae-38f8234597e0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "aeedae4b-9fe5-4713-b2ae-38f8234597e0",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-11-18T09:26:01.970317+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "95d1397a-2aa8-446a-b042-d49e941794b2",
            "legacy_id": null,
            "name": "Product 1000029",
            "quantity": 0,
            "created_at": "2024-11-18T09:26:01.762Z",
            "updated_at": "2024-11-18T09:26:01.762Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000031",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000029",
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
            "company_id": "f7c5795a-cd27-4c26-b000-2ff85391013f",
            "item_group_id": "290ff3c6-f8f3-46df-8b0a-a512fb08b75f",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000029",
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
            "cached_tag_list": null,
            "excerpt": null
          }
        ]
      },
      "owner_id": "49b216ef-ac52-4398-a7ee-160a0dd54f63",
      "owner_type": "orders",
      "employee_id": "962c91ad-be62-429c-b709-783dbd0fa366"
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






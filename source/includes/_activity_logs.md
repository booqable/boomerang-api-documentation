# Activity logs

Activity logs describe an event where changes took place in our database. Examples of such events can be an order that was created or placed, a product name that changed, a customer that was added or an e-mail that got sent.

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
`action_key` | **String** `readonly`<br>The name of the event that the activity log describes. This determines which translated summary line will be displayed in the web client. Examples are "product.created" or "order.updated".
`action_args` | **Hash** `readonly`<br>Arguments that can be passed to enrich the summary line of the web client with details, such as a product name.
`has_data` | **Boolean** `readonly`<br>Boolean value flag indicating whether this activity log contains additional data describing the subject of the event.
`employee_id` | **Uuid** `nullable` `readonly`<br>The employee who performed the action.
`owner_id` | **Uuid** <br>ID of the subject the event is about.
`owner_type` | **String** <br>Class of the subject the event is about
`data` | **Hash** `readonly`<br>Hash containing (details on) the subject(s) of the event this activity log describes.


## Relationships
Activity logs have the following relationships:

Name | Description
-- | --
`employee` | **[Employee](#employees)** <br>The employee who performed the action.
`owner` | **[Customer](#customers), [Product](#products), [Product group](#product-groups), [Stock item](#stock-items), [Bundle](#bundles), [Order](#orders), [Document](#documents), [Email](#emails)** <br>Associated Owner


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
      "id": "b35fff34-77d0-4821-bf6b-c331158e6f21",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-12-02T13:02:43.856948+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "employee_id": "bc232aa3-8e0e-4688-bd0c-b132eab0a4c6",
        "owner_id": "ac542c91-54e3-492e-af3f-a07175f29b0b",
        "owner_type": "orders"
      },
      "relationships": {}
    },
    {
      "id": "1d53480b-84cf-4a72-aa71-45a0d67e4a3e",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-12-02T13:02:43.570691+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "employee_id": "86eb6249-a8f3-466c-bef2-75da8398dca5",
        "owner_id": "ae9ecf87-62bc-40bf-a313-ba52bea55683",
        "owner_type": "orders"
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[activity_logs]=created_at,action_key,action_args`
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
`action_key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/92eab5b5-01fb-4042-9974-9a6aa05074c4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "92eab5b5-01fb-4042-9974-9a6aa05074c4",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-12-02T13:02:42.482210+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "f4e7f8fa-858d-4eb9-9627-57488b46eb2f",
            "legacy_id": null,
            "name": "Product 1000008",
            "quantity": 0,
            "created_at": "2024-12-02T13:02:42.192Z",
            "updated_at": "2024-12-02T13:02:42.192Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000008",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000008",
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
            "company_id": "5baf25d5-ce4b-43d7-9c6c-b458d2d2f2fb",
            "item_group_id": "beca20ed-5321-4d6d-a3ad-0835874d87b2",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000008",
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
      "employee_id": "c1c1855d-4f9b-440c-b99e-fc44a2a1aa1f",
      "owner_id": "06994c8f-9bb7-41d4-85a2-cae6ecc928fd",
      "owner_type": "orders"
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[activity_logs]=created_at,action_key,action_args`


### Includes

This request accepts the following includes:

`owner`


`employee`






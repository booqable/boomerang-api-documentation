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
      "id": "829c7dca-8ec5-40e4-8474-d7f447e398f6",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-12-02T09:25:02.370650+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "employee_id": "96361741-c485-4980-a46d-f1735e66d5d6",
        "owner_id": "96098947-15af-4eb8-8a92-3169defcc049",
        "owner_type": "orders"
      },
      "relationships": {}
    },
    {
      "id": "96a93067-c7aa-47ee-9424-c36336f7a27b",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-12-02T09:25:02.163042+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "employee_id": "de495a82-284b-4821-a1bd-8e387b917c7c",
        "owner_id": "bb9e7b57-94c7-4b89-abf0-940f9bea93ab",
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/56f05545-e49e-4b00-81f6-c84c5d6cba20' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "56f05545-e49e-4b00-81f6-c84c5d6cba20",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-12-02T09:25:03.057175+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "0dde26e5-f49f-4698-900b-98773b757ff2",
            "legacy_id": null,
            "name": "Product 1000049",
            "quantity": 0,
            "created_at": "2024-12-02T09:25:02.871Z",
            "updated_at": "2024-12-02T09:25:02.871Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000049",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000049",
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
            "company_id": "cc29f7be-fae2-4850-b360-c3fbb8f2633b",
            "item_group_id": "265d86bc-8695-4d8e-809e-5f68fdb35a04",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000049",
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
      "employee_id": "f349d4fc-023f-4c19-a421-6fb579e8f83b",
      "owner_id": "5e88443c-0aa3-4ade-8d66-bff3419c37a1",
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






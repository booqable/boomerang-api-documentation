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
`employee_id` | **Uuid** `readonly`<br>The employee who performed the action.
`owner_id` | **Uuid** <br>ID of the subject the event is about.
`owner_type` | **String** <br>Class of the subject the event is about
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
      "id": "87140ac5-41a2-43dd-9597-ea9f4edc096d",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-11-25T09:24:54.303910+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "employee_id": "047ed4b3-d49f-45c9-93b9-cdf5638169e7",
        "owner_id": "950871e4-b84c-44ff-bcbd-3b8ca0e8ecfa",
        "owner_type": "orders"
      },
      "relationships": {}
    },
    {
      "id": "4fe76f99-f8ce-4cad-ae8b-af2f08e5a174",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2024-11-25T09:24:53.913289+00:00",
        "action_key": "product.created",
        "action_args": {},
        "has_data": true,
        "employee_id": "43fdc50d-eff8-474b-a8eb-1731a4b1395a",
        "owner_id": "2be1c719-a084-417f-a1cc-82cf94f57f27",
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
    --url 'https://example.booqable.com/api/boomerang/activity_logs/450cbaf7-f395-440e-b8ef-cf1f0644687f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "450cbaf7-f395-440e-b8ef-cf1f0644687f",
    "type": "activity_logs",
    "attributes": {
      "created_at": "2024-11-25T09:24:52.420668+00:00",
      "action_key": "product.created",
      "action_args": {},
      "has_data": true,
      "data": {
        "products": [
          {
            "id": "ce823087-0d73-447d-8801-8b7754f492b8",
            "legacy_id": null,
            "name": "Product 1000004",
            "quantity": 0,
            "created_at": "2024-11-25T09:24:52.056Z",
            "updated_at": "2024-11-25T09:24:52.056Z",
            "lag_time": 0,
            "lead_time": 0,
            "always_available": false,
            "trackable": false,
            "sku": "PRODUCT 1000004",
            "type": "Product",
            "base_price_in_cents": 0,
            "group_name": "Product 1000004",
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
            "company_id": "63f0b8ba-e30b-45f5-802b-065905e6274a",
            "item_group_id": "4ccbaee4-7576-448b-bb46-bd2ac65d09fc",
            "price_wrapper_id": null,
            "tax_category_id": null,
            "slug": "product-1000004",
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
      "employee_id": "8570b855-2a7b-4512-b4f2-51df4ab9de6b",
      "owner_id": "23119240-0012-4d60-9e5d-a5443bb86a2d",
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






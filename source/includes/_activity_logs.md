# Activity logs

Activity logs describe an event where changes took place in our database.
Examples of such events can be an order that was created or placed,
a product name that changed, a customer that was added or an e-mail that got sent.

## Relationships
Name | Description
-- | --
`employee` | **[Employee](#employees)** `optional`<br>The employee who performed the action. 
`owner` | **[Customer](#customers), [Product](#products), [Product group](#product-groups), [Stock item](#stock-items), [Bundle](#bundles), [Order](#orders), [Document](#documents), [Email](#emails)** `required`<br>The main subject the activity was about. Most activities related to multiple subjects. Use the `relation_id` filter to search for activities about any subject. 


Check matching attributes under [Fields](#activity-logs-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`action_args` | **hash** `readonly`<br>Hash of arguments that can be interpolated into `action_key` to enrich the summary of the web client with details, such as a product name. 
`action_key` | **string** `readonly`<br>The name of the activity that the activity log describes. This determines which translated summary line will be displayed in the web client. Examples are "product.created" or "order.updated". 
`created_at` | **datetime** `readonly`<br>When the activity happened. 
`data` | **hash** `readonly`<br>Hash containing many more details about the subjects of this activity and the changed data. 
`employee_id` | **uuid** `readonly` `nullable`<br>The employee who performed the action. 
`has_data` | **boolean** `readonly`<br>Boolean value flag indicating whether the `data` attribnute is non-empty. 
`id` | **uuid** `readonly`<br>Primary key.
`owner_id` | **uuid** <br>ID of the subject the activity was about. 
`owner_type` | **string** <br>Resource name of the subject the activity was about. 


## Fetch an activity log


> How to fetch an activity log:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/activity_logs/e69af64b-a3d5-437c-83bd-e54a6d3873ca'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "e69af64b-a3d5-437c-83bd-e54a6d3873ca",
      "type": "activity_logs",
      "attributes": {
        "created_at": "2028-08-04T01:46:00.000000+00:00",
        "action_key": "add_product_group",
        "action_args": {
          "product_group": {
            "id": "56607013-d939-4571-89f4-6a1bcf81836b",
            "name": "Mountainbike Elite"
          }
        },
        "has_data": true,
        "data": {
          "sections": [
            {
              "title_key": "product_group",
              "section_type": "record_capture",
              "record_type": "product_groups",
              "attributes": {
                "id": "56607013-d939-4571-89f4-6a1bcf81836b",
                "legacy_id": null,
                "name": "Mountainbike Elite",
                "quantity": 0,
                "created_at": "2028-08-04T01:46:00.000000+00:00",
                "updated_at": "2028-08-04T01:46:00.000000+00:00",
                "lag_time": 0,
                "lead_time": 0,
                "always_available": false,
                "trackable": false,
                "sku": "MOUNTAINBIKE_ELITE",
                "type": "ProductGroup",
                "base_price_in_cents": 0,
                "group_name": null,
                "has_variations": true,
                "variation": false,
                "variation_name": null,
                "variation_values": null,
                "variation_fields": [],
                "price_type": "simple",
                "price_period": "hour",
                "stock_item_properties": [],
                "archived_at": null,
                "stock_count": 0,
                "extra_information": null,
                "photo": null,
                "photo_url": null,
                "flat_fee_price_in_cents": 0,
                "structure_price_in_cents": 0,
                "deposit_in_cents": 0,
                "slug": "mountainbike-elite",
                "description": null,
                "show_in_store": true,
                "product_type": "rental",
                "tracking_type": "trackable",
                "discountable": true,
                "taxable": true,
                "allow_shortage": false,
                "shortage_limit": 0,
                "sorting_weight": 0,
                "seo_title": null,
                "seo_description": null,
                "cached_tag_list": null,
                "excerpt": null,
                "product_group": null,
                "price_wrapper": null,
                "price_structure": null,
                "price_ruleset": null,
                "tax_category": null,
                "cheapest_product": {
                  "id": "cb36f18a-3074-4d16-8fce-a210f9f04d34",
                  "name": "Mountainbike Elite"
                },
                "barcode": null
              }
            }
          ],
          "metadata": {
            "worker_class": null,
            "event_name": "product_group.created",
            "app_version": null
          }
        },
        "employee_id": "e4507ab6-6038-481c-85be-15945deb81af",
        "owner_id": "56607013-d939-4571-89f4-6a1bcf81836b",
        "owner_type": "product_groups"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[activity_logs]=created_at,action_key,action_args`
`include` | **string** <br>List of comma seperated relationships `?include=owner,employee`


### Includes

This request accepts the following includes:

`owner`


`employee`






## Filter activity logs


> How to filter activity logs by relation and action type:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/activity_logs'
       --header 'content-type: application/json'
       --data-urlencode 'filter[action_key]=change_price_settings_for_product_group'
       --data-urlencode 'filter[relation_id]=bacff37a-326a-44ed-8227-751a2c95d42f'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "53d4ac12-554d-4b83-811a-de6327cc1d5a",
        "type": "activity_logs",
        "attributes": {
          "created_at": "2014-11-22T20:08:01.000000+00:00",
          "action_key": "change_price_settings_for_product_group",
          "action_args": {
            "product_group": {
              "id": "bacff37a-326a-44ed-8227-751a2c95d42f",
              "name": "Mountainbike Elite"
            }
          },
          "has_data": true,
          "employee_id": "ff248409-aa04-4660-8634-3b46a6cf6cf5",
          "owner_id": "bacff37a-326a-44ed-8227-751a2c95d42f",
          "owner_type": "product_groups"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[activity_logs]=created_at,action_key,action_args`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships `?include=owner,employee`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`action_key` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`owner_id` | **uuid** <br>`eq`, `not_eq`
`owner_type` | **string** <br>`eq`, `not_eq`
`relation_id` | **uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`owner`


`employee`






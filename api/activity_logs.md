# Activity logs

Activity logs describe an event where changes took place in our database.

Examples of such events can be an order that was created or placed,
a product name that changed, a customer that was added or an e-mail that got sent.

Most activities are related to multiple subjects. Use the `relation_id`
filter to search for activities about any subject.

## Relationships
Name | Description
-- | --
`employee` | **[Employee](#employees)** `optional`<br>The employee who performed the action. 


Check matching attributes under [Fields](#activity-logs-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`action_args` | **hash** `readonly`<br>Hash of arguments that can be interpolated into `action_key` to enrich the summary of the web client with details, such as a product name. 
`action_key` | **string** `readonly`<br>The name of the activity that the activity log describes. This determines which translated summary line will be displayed in the web client. 
`created_at` | **datetime** `readonly`<br>When the activity happened. 
`data` | **hash** `readonly` `extra`<br>Hash containing details about the subjects of this activity and the changed data. 
`employee_id` | **uuid** `readonly` `nullable`<br>The employee who performed the action. 
`has_data` | **boolean** `readonly`<br>Indicates whether the `data` attribute is non-empty. 
`id` | **uuid** `readonly`<br>Primary key.
`support` | **boolean** `readonly`<br>Indicates whether the activity was performed during a Booqable support session. 


## Fetch an activity log


> How to fetch an activity log:

```shell
  curl --get 'https://example.booqable.com/api/4/activity_logs/e69af64b-a3d5-437c-83bd-e54a6d3873ca'
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
        "support": false,
        "employee_id": "cb36f18a-3074-4d16-8fce-a210f9f04d34"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/activity_logs/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[activity_logs]=data`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[activity_logs]=created_at,action_key,action_args`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=employee`


### Includes

This request accepts the following includes:

<ul>
  <li><code>employee</code></li>
</ul>


## Filter activity logs


> How to filter activity logs by relation and action type:

```shell
  curl --get 'https://example.booqable.com/api/4/activity_logs'
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
          "support": false,
          "employee_id": "ff248409-aa04-4660-8634-3b46a6cf6cf5"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/activity_logs`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[activity_logs]=data`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[activity_logs]=created_at,action_key,action_args`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=employee`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`action_key` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`employee_id` | **uuid** <br>`eq`, `not_eq`
`id` | **uuid** <br>`eq`, `not_eq`
`relation_id` | **uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>employee</code></li>
</ul>


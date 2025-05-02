# Bulk upserts

Bulk upserts are for creating one or more entries of a model in a single request.

The Booqable API does not support official JSON API compliant side posting.
Instead, three alternative solutions are used to create or update multiple resources at once:

  1. Some resources have a writeonly attribute `{child_resource_name}_attributes`.
    This attribute can be used to manage child resources through their parent resource.

  2. BulkUpserts (this resource)

  3. [Sortings](#sortings)

## Relationships
Name | Description
-- | --
`results` | **[Virtuals](#virtuals)** `hasmany`<br>The resources that have been created. 


Check matching attributes under [Fields](#bulk-upserts-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`data` | **array** `writeonly`<br>Array of objects, all objects must contain valid data for the specified type, see documentation for specific resource for more details. 
`id` | **uuid** `readonly`<br>Primary key.
`type` | **enum** `writeonly`<br>Type of data being submitted.<br> One of: `coupons`, `operating_rules`.


## Upsert bulk data


> How to create operating rules in bulk:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/bulk_upserts'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "bulk_upserts",
           "attributes": {
             "type": "operating_rules",
             "data": [
               {
                 "data": {
                   "mon": {
                     "from": "09:00",
                     "till": "13:00"
                   }
                 },
                 "data_type": "hours"
               },
               {
                 "data": {
                   "mon": {
                     "from": "15:00",
                     "till": "17:00"
                   }
                 },
                 "data_type": "hours"
               }
             ]
           }
         },
         "include": "results"
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "ccfea8c4-9251-407e-8fcd-0cc1d303a88f",
      "type": "bulk_upserts",
      "relationships": {
        "results": {
          "data": [
            {
              "type": "operating_rules",
              "id": "9f86e4b9-6229-4d1f-832e-63ddb611a6e7"
            },
            {
              "type": "operating_rules",
              "id": "dbe23fc7-18cd-4ddd-8380-361467ac3712"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "9f86e4b9-6229-4d1f-832e-63ddb611a6e7",
        "type": "operating_rules",
        "attributes": {
          "created_at": "2028-01-16T05:19:00.000000+00:00",
          "updated_at": "2028-01-16T05:19:00.000000+00:00",
          "data_type": "hours",
          "data": {
            "mon": {
              "from": "09:00",
              "till": "13:00"
            }
          }
        }
      },
      {
        "id": "dbe23fc7-18cd-4ddd-8380-361467ac3712",
        "type": "operating_rules",
        "attributes": {
          "created_at": "2028-01-16T05:19:00.000000+00:00",
          "updated_at": "2028-01-16T05:19:00.000000+00:00",
          "data_type": "hours",
          "data": {
            "mon": {
              "from": "15:00",
              "till": "17:00"
            }
          }
        }
      }
    ],
    "meta": {}
  }
```

> How to create coupons in bulk:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/bulk_upserts'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "bulk_upserts",
           "attributes": {
             "type": "coupons",
             "data": [
               {
                 "identifier": "off",
                 "coupon_type": "percentage",
                 "value": 25,
                 "active": true
               },
               {
                 "identifier": "summer-22",
                 "coupon_type": "cents",
                 "value": 2200
               }
             ]
           },
           "include": "results"
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "40dd5470-3d3a-4f6f-8638-d327d8fa16c9",
      "type": "bulk_upserts",
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/bulk_upserts`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=results`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][data][]` | **array** <br>Array of objects, all objects must contain valid data for the specified type, see documentation for specific resource for more details. 
`data[attributes][type]` | **enum** <br>Type of data being submitted.<br> One of: `coupons`, `operating_rules`.


### Includes

This request accepts the following includes:

<ul>
  <li><code>results</code></li>
</ul>


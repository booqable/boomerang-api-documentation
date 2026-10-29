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
`data` | **array** `writeonly`<br>Array of objects, all objects must contain valid data for the specified type, see documentation for specific resource for more details. For `content_translations`, each object has a `key`, the row key the store texts list a text of the merchant's own content under (such as `products.<id>.name`), and either a `value`, where a blank value removes the text, or `needs_review: false` without a value, which marks the text reviewed. `needs_review: true` is ignored. 
`id` | **uuid** `readonly`<br>Primary key.
`language_id` | **uuid** `writeonly`<br>For `translations` and `content_translations` only: the [Language](#languages) the texts belong to. Translations go to the English language when it is left out; content translations need it. 
`type` | **enum** `writeonly`<br>Type of data being submitted.<br> One of: `content_translations`, `coupons`, `operating_rules`, `translations`.


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

> How to upsert content translations in bulk:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/bulk_upserts'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "bulk_upserts",
           "attributes": {
             "type": "content_translations",
             "language_id": "701a40b3-3a29-46de-8d69-276e16fd6ad7",
             "data": [
               {
                 "key": "products.eb098f7f-fbf8-4624-8266-a2f01d1a96ea.name",
                 "value": "Tält"
               },
               {
                 "key": "products.eb098f7f-fbf8-4624-8266-a2f01d1a96ea.description",
                 "value": "<p>Rymmer fyra.</p>"
               }
             ]
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "2e335692-6173-485c-827e-1463f0325fcb",
      "type": "bulk_upserts",
      "relationships": {}
    },
    "meta": {}
  }
```

> How to upsert translations in bulk:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/bulk_upserts'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "bulk_upserts",
           "attributes": {
             "type": "translations",
             "data": [
               {
                 "key": "document.date",
                 "value": "Datum",
                 "namespace": "user"
               },
               {
                 "key": "document.total",
                 "value": "",
                 "namespace": "user"
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
      "id": "095c1df8-c511-4f5c-8f79-7bb7491db4c4",
      "type": "bulk_upserts",
      "relationships": {
        "results": {
          "data": [
            {
              "type": "translations",
              "id": "ed432cae-a28b-4f9b-8e90-124615154f0c"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "ed432cae-a28b-4f9b-8e90-124615154f0c",
        "type": "translations",
        "attributes": {
          "created_at": "2028-11-10T17:32:00.000000+00:00",
          "updated_at": "2028-11-10T17:32:00.000000+00:00",
          "key": "document.date",
          "value": "Datum",
          "namespace": "user",
          "needs_review": false,
          "language_id": "75afc0e9-5d68-420e-8cc2-7eae8ae4d50f"
        },
        "relationships": {}
      }
    ],
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
`data[attributes][data][]` | **array** <br>Array of objects, all objects must contain valid data for the specified type, see documentation for specific resource for more details. For `content_translations`, each object has a `key`, the row key the store texts list a text of the merchant's own content under (such as `products.<id>.name`), and either a `value`, where a blank value removes the text, or `needs_review: false` without a value, which marks the text reviewed. `needs_review: true` is ignored. 
`data[attributes][language_id]` | **uuid** <br>For `translations` and `content_translations` only: the [Language](#languages) the texts belong to. Translations go to the English language when it is left out; content translations need it. 
`data[attributes][type]` | **enum** <br>Type of data being submitted.<br> One of: `content_translations`, `coupons`, `operating_rules`, `translations`.


### Includes

This request accepts the following includes:

<ul>
  <li><code>results</code></li>
</ul>


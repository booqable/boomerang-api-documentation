# App carriers

AppCarriers represent delivery carriers available through third-party delivery apps integrated
with Booqable. These carriers are provided by external delivery applications that extend
Booqable's delivery capabilities beyond the built-in options.

For more information about delivery apps see [the Apps documentation](/apps.html#capabilities-delivery-carriers).

## Relationships
Name | Description
-- | --
`app_subscription` | **[App subscription](#app-subscriptions)** `required`<br>The [AppSubscription](#app-subscriptions) that provides this carrier. 
`tax_category` | **[Tax category](#tax-categories)** `optional`<br>The [TaxCategory](#tax-categories) associated with this carrier for tax calculations. 


Check matching attributes under [Fields](#app-carriers-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`app_subscription_id` | **uuid** `readonly`<br>The [AppSubscription](#app-subscriptions) that provides this carrier. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** <br>Unique identifier for this carrier. 
`rates_url` | **string** <br>URL endpoint for fetching delivery rates from this carrier. 
`tax_category_id` | **uuid** `nullable`<br>The [TaxCategory](#tax-categories) associated with this carrier for tax calculations. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List app carriers


> How to fetch a list of app carriers:

```shell
  curl --get 'https://example.booqable.com/api/4/app_carriers'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "b1c37032-4250-4b3c-85a3-e38618c75e92",
        "type": "app_carriers",
        "attributes": {
          "created_at": "2025-05-14T04:07:06.000000+00:00",
          "updated_at": "2025-05-14T04:07:06.000000+00:00",
          "identifier": "carrier-1",
          "rates_url": "http://deliveries1.test/rates",
          "tax_category_id": null,
          "app_subscription_id": "b3452ba3-cafd-4c4b-8259-e086c1925a49"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/app_carriers`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[app_carriers]=created_at,updated_at,identifier`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`app_subscription_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`identifier` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_id` | **uuid** <br>`eq`, `not_eq`
`rates_url` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tax_category_id` | **uuid** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch an app carrier


> How to fetch an app carrier:

```shell
  curl --get 'https://example.booqable.com/api/4/app_carriers/35747d6a-20da-4e41-884b-63593049abeb'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "35747d6a-20da-4e41-884b-63593049abeb",
      "type": "app_carriers",
      "attributes": {
        "created_at": "2027-07-22T07:28:04.000000+00:00",
        "updated_at": "2027-07-22T07:28:04.000000+00:00",
        "identifier": "carrier-2",
        "rates_url": "http://deliveries2.test/rates",
        "tax_category_id": null,
        "app_subscription_id": "6a483a4e-4a38-41de-89f7-ae6fdbeeab51"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/app_carriers/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[app_carriers]=created_at,updated_at,identifier`


### Includes

This request does not accept any includes
## Create an app carrier

App carriers are typically created by third-party delivery apps through the Booqable Apps API.

> How to create an app carrier:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/app_carriers'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "app_carriers",
           "attributes": {
             "identifier": "my-deliver-express",
             "rates_url": "https://my-deliver-express.example.com/api/rates"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "a6b05d0c-2ee8-45c6-8008-87d0aaa1ff26",
      "type": "app_carriers",
      "attributes": {
        "created_at": "2017-07-07T00:40:10.000000+00:00",
        "updated_at": "2017-07-07T00:40:10.000000+00:00",
        "identifier": "my-deliver-express",
        "rates_url": "https://my-deliver-express.example.com/api/rates",
        "tax_category_id": null,
        "app_subscription_id": "67c8f03d-d36e-4d7d-8c4d-bffa03a309c6"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/app_carriers`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[app_carriers]=created_at,updated_at,identifier`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][identifier]` | **string** <br>Unique identifier for this carrier. 
`data[attributes][rates_url]` | **string** <br>URL endpoint for fetching delivery rates from this carrier. 
`data[attributes][tax_category_id]` | **uuid** <br>The [TaxCategory](#tax-categories) associated with this carrier for tax calculations. 


### Includes

This request does not accept any includes
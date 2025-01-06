# Tax rates

Tax rates are always assigned to either a [TaxRegion](#tax_regions)
or [TaxCategory](#tax_categories). Tax rates define the individual
rates that will be taxed.

## Relationships
Name | Description
-- | --
`owner` | **[Tax category](#tax-categories), [Tax region](#tax-regions)** `required`<br>The TaxRegion or TaxCategory this TaxRate is part of.


Check matching attributes under [Fields](#tax-rates-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** <br>The name of the tax rate.
`owner_id` | **uuid** <br>The TaxRegion or TaxCategory this TaxRate is part of.
`owner_type` | **string** <br>The resource type of the owner.
`position` | **integer** `readonly`<br>Position of the tax rate.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`value` | **float** <br>The percentage value of the rate.


## List tax rates


> How to fetch a list of tax rates:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/tax_rates'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "d39e7448-db31-4b79-82da-4e0c59539ac4",
        "type": "tax_rates",
        "attributes": {
          "created_at": "2016-01-22T07:05:01.000000+00:00",
          "updated_at": "2016-01-22T07:05:01.000000+00:00",
          "name": "VAT",
          "value": 21.0,
          "position": 1,
          "owner_id": "c0ac16c6-1011-4d0d-8a6d-20b0b13763cd",
          "owner_type": "tax_regions"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET api/boomerang/tax_rates`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[tax_rates]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`owner_id` | **uuid** <br>`eq`, `not_eq`
`owner_type` | **string** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetch a tax rate


> How to fetch a tax rate:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/tax_rates/4315e7db-350a-4786-848a-27333157f531'
       --header 'content-type: application/json'
       --data-urlencode 'include=owner'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "4315e7db-350a-4786-848a-27333157f531",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2028-12-26T07:19:00.000000+00:00",
        "updated_at": "2028-12-26T07:19:00.000000+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "bed7a8b1-0fc6-401d-818a-374b416dbbd5",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "tax_regions",
            "id": "bed7a8b1-0fc6-401d-818a-374b416dbbd5"
          }
        }
      }
    },
    "included": [
      {
        "id": "bed7a8b1-0fc6-401d-818a-374b416dbbd5",
        "type": "tax_regions",
        "attributes": {
          "created_at": "2028-12-26T07:19:00.000000+00:00",
          "updated_at": "2028-12-26T07:19:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "name": "Sales Tax",
          "strategy": "add_to",
          "default": false
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[tax_rates]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Includes

This request accepts the following includes:

`owner`






## Create a tax rate


> How to create a tax rate and associate it with an owner:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/tax_rates'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "tax_rates",
           "attributes": {
             "name": "VAT",
             "value": 21,
             "owner_id": "12188347-ab4b-416c-8b2d-44bf5802abbc",
             "owner_type": "tax_regions"
           }
         },
         "include": "owner"
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "87122383-0cc0-4126-8013-a213d1fbb19d",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2021-02-16T04:50:00.000000+00:00",
        "updated_at": "2021-02-16T04:50:00.000000+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "12188347-ab4b-416c-8b2d-44bf5802abbc",
        "owner_type": "tax_regions"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "tax_regions",
            "id": "12188347-ab4b-416c-8b2d-44bf5802abbc"
          }
        }
      }
    },
    "included": [
      {
        "id": "12188347-ab4b-416c-8b2d-44bf5802abbc",
        "type": "tax_regions",
        "attributes": {
          "created_at": "2021-02-16T04:50:00.000000+00:00",
          "updated_at": "2021-02-16T04:50:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "name": "Sales Tax",
          "strategy": "add_to",
          "default": false
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/tax_rates`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[tax_rates]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **string** <br>The name of the tax rate.
`data[attributes][owner_id]` | **uuid** <br>The TaxRegion or TaxCategory this TaxRate is part of.
`data[attributes][owner_type]` | **string** <br>The resource type of the owner.
`data[attributes][value]` | **float** <br>The percentage value of the rate.


### Includes

This request accepts the following includes:

`owner`






## Update a tax rate


> How to update a tax rate:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/tax_rates/85ba8a31-4370-484d-86f2-4da1726975ff'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "85ba8a31-4370-484d-86f2-4da1726975ff",
           "type": "tax_rates",
           "attributes": {
             "value": 9
           }
         },
         "include": "owner"
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "85ba8a31-4370-484d-86f2-4da1726975ff",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2020-08-24T18:48:00.000000+00:00",
        "updated_at": "2020-08-24T18:48:00.000000+00:00",
        "name": "Vat",
        "value": 9.0,
        "position": 1,
        "owner_id": "309c4936-b8c0-4af3-80c5-1659745b4375",
        "owner_type": "tax_categories"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "tax_categories",
            "id": "309c4936-b8c0-4af3-80c5-1659745b4375"
          }
        }
      }
    },
    "included": [
      {
        "id": "309c4936-b8c0-4af3-80c5-1659745b4375",
        "type": "tax_categories",
        "attributes": {
          "created_at": "2020-08-24T18:48:00.000000+00:00",
          "updated_at": "2020-08-24T18:48:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "name": "Sales Tax",
          "default": false
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`PUT /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[tax_rates]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **string** <br>The name of the tax rate.
`data[attributes][owner_id]` | **uuid** <br>The TaxRegion or TaxCategory this TaxRate is part of.
`data[attributes][owner_type]` | **string** <br>The resource type of the owner.
`data[attributes][value]` | **float** <br>The percentage value of the rate.


### Includes

This request accepts the following includes:

`owner`






## Delete a tax rate


> How to delete a tax rate:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/tax_rates/b018f5dc-4f78-414a-8728-22d47be42893'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "b018f5dc-4f78-414a-8728-22d47be42893",
      "type": "tax_rates",
      "attributes": {
        "created_at": "2026-11-02T15:14:02.000000+00:00",
        "updated_at": "2026-11-02T15:14:02.000000+00:00",
        "name": "VAT",
        "value": 21.0,
        "position": 1,
        "owner_id": "6af038f1-d8e7-4001-8ce9-f365ecd2b6e1",
        "owner_type": "tax_regions"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/boomerang/tax_rates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[tax_rates]=created_at,updated_at,name`


### Includes

This request does not accept any includes
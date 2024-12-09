# Tax regions

You can create tax regions for specific customers. Booqable's tax system supports adding, replacing and compounding rates.
A tax region can have one of the following strategies:

- **Add to**: Each tax rate is calculated over the order total and individually added or substracted to/from the order total.
- **Compound**: The tax is calculated over the order total, including product taxes (tax over tax). This method is used in some countries like Canada.
- **Replace**: Removes product taxes and calculates tax over the order total.

## Relationships
Name | Description
-- | --
`tax_rates` | **[Tax rates](#tax-rates)** `hasmany`<br>The different rates that need to be charged. <br/> Rates can be created/updated through the TaxRegion resource by writing the `tax_rates_attributes` attrinute. 


Check matching attributes under [Fields](#tax-regions-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether tax region is archived. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the tax region was archived. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`default` | **boolean** <br>Whether this is the default tax region. Setting this value to `true` will set other tax regions to `false`. 
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** <br>Name of the tax region. 
`strategy` | **enum** <br>The strategy to apply.<br> One of: `add_to`, `replace`, `compound`.
`tax_rates_attributes` | **array** `writeonly`<br>The tax rates to associate. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Listing tax regions


> How to fetch a list of tax regions:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/tax_regions'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "00e98201-6b1e-49d8-8bf0-02d5617ef164",
        "created_at": "2016-02-27T03:13:02.000000+00:00",
        "updated_at": "2016-02-27T03:13:02.000000+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "add_to",
        "default": false
      }
    ]
  }
```

### HTTP Request

`GET /api/boomerang/tax_regions`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[tax_regions]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships `?include=tax_rates`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`default` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`strategy` | **string_enum** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`tax_rates`






## Fetching a tax region


> How to fetch a tax regions with it's tax rates:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/tax_regions/d6cde3c4-b601-40af-8657-a4f48cf21302'
       --header 'content-type: application/json'
       --data-urlencode 'include=tax_rates'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "d6cde3c4-b601-40af-8657-a4f48cf21302",
      "created_at": "2026-01-16T23:41:03.000000+00:00",
      "updated_at": "2026-01-16T23:41:03.000000+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Sales Tax",
      "strategy": "add_to",
      "default": false,
      "tax_rates": [
        {
          "id": "b78c7a18-26c4-4611-8323-3396afeafcb3",
          "created_at": "2026-01-16T23:41:03.000000+00:00",
          "updated_at": "2026-01-16T23:41:03.000000+00:00",
          "name": "VAT",
          "value": 21.0,
          "position": 1,
          "owner_id": "d6cde3c4-b601-40af-8657-a4f48cf21302",
          "owner_type": "tax_regions"
        }
      ]
    }
  }
```

### HTTP Request

`GET /api/boomerang/tax_regions/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[tax_regions]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships `?include=tax_rates`


### Includes

This request accepts the following includes:

`tax_rates`






## Creating a tax region


> How to create a tax region with tax rates:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/tax_regions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "tax_regions",
           "attributes": {
             "name": "Sales Tax",
             "strategy": "compound",
             "tax_rates_attributes": [
               {
                 "name": "VAT",
                 "value": 21
               }
             ]
           }
         },
         "include": "tax_rates"
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "c7843334-9eec-427e-8fb1-5c2602357d6c",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2023-02-08T01:43:00.000000+00:00",
        "updated_at": "2023-02-08T01:43:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "strategy": "compound",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "data": [
            {
              "type": "tax_rates",
              "id": "1efc8ba7-d52e-4ca0-8c8a-bca0577db390"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "1efc8ba7-d52e-4ca0-8c8a-bca0577db390",
        "type": "tax_rates",
        "attributes": {
          "created_at": "2023-02-08T01:43:00.000000+00:00",
          "updated_at": "2023-02-08T01:43:00.000000+00:00",
          "name": "VAT",
          "value": 21.0,
          "position": 1,
          "owner_id": "c7843334-9eec-427e-8fb1-5c2602357d6c",
          "owner_type": "tax_regions"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/tax_regions`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[tax_regions]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships `?include=tax_rates`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][default]` | **boolean** <br>Whether this is the default tax region. Setting this value to `true` will set other tax regions to `false`. 
`data[attributes][name]` | **string** <br>Name of the tax region. 
`data[attributes][strategy]` | **enum** <br>The strategy to apply.<br> One of: `add_to`, `replace`, `compound`.
`data[attributes][tax_rates_attributes][]` | **array** <br>The tax rates to associate. 


### Includes

This request accepts the following includes:

`tax_rates`






## Updating a tax region


> How to update a tax region with tax rates:

```shell
  curl --request PUT \
       --url 'https://example.booqable.com/api/boomerang/tax_regions/88245673-247e-4ecb-80c3-8d7cb31b5e27'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "88245673-247e-4ecb-80c3-8d7cb31b5e27",
           "type": "tax_regions",
           "attributes": {
             "name": "State Tax",
             "tax_rates_attributes": [
               {
                 "name": "VAT",
                 "value": 9
               },
               {
                 "id": "7da9f478-a463-4ff7-847a-e00d08c59d05",
                 "_destroy": true
               }
             ]
           }
         },
         "include": "tax_rates"
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "88245673-247e-4ecb-80c3-8d7cb31b5e27",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2016-06-23T04:51:02.000000+00:00",
        "updated_at": "2016-06-23T04:51:02.000000+00:00",
        "archived": false,
        "archived_at": null,
        "name": "State Tax",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "data": [
            {
              "type": "tax_rates",
              "id": "a5b06e94-dc8d-4b81-81e6-f2ef5d7de6ed"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "a5b06e94-dc8d-4b81-81e6-f2ef5d7de6ed",
        "type": "tax_rates",
        "attributes": {
          "created_at": "2016-06-23T04:51:02.000000+00:00",
          "updated_at": "2016-06-23T04:51:02.000000+00:00",
          "name": "VAT",
          "value": 9.0,
          "position": 2,
          "owner_id": "88245673-247e-4ecb-80c3-8d7cb31b5e27",
          "owner_type": "tax_regions"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`PUT /api/boomerang/tax_regions/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[tax_regions]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships `?include=tax_rates`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][default]` | **boolean** <br>Whether this is the default tax region. Setting this value to `true` will set other tax regions to `false`. 
`data[attributes][name]` | **string** <br>Name of the tax region. 
`data[attributes][strategy]` | **enum** <br>The strategy to apply.<br> One of: `add_to`, `replace`, `compound`.
`data[attributes][tax_rates_attributes][]` | **array** <br>The tax rates to associate. 


### Includes

This request accepts the following includes:

`tax_rates`






## Deleting a tax region


> How to delete a tax region with tax rates:

```shell
  curl --request DELETE \
       --url 'https://example.booqable.com/api/boomerang/tax_regions/e692e29e-ab82-42d7-8347-cb4aa2d665ab'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "e692e29e-ab82-42d7-8347-cb4aa2d665ab",
      "type": "tax_regions",
      "attributes": {
        "created_at": "2016-07-01T20:19:06.000000+00:00",
        "updated_at": "2016-07-01T20:19:06.000000+00:00",
        "archived": true,
        "archived_at": "2016-07-01T20:19:06.000000+00:00",
        "name": "Sales Tax (Deleted)",
        "strategy": "add_to",
        "default": false
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/boomerang/tax_regions/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[tax_regions]=created_at,updated_at,archived`


### Includes

This request does not accept any includes
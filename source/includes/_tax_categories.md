# Tax categories

You can create different tax categories and assign them according to the tax requirements
of a product. The tax rates in the category are charged over a product when it's added to
an order. An order's total tax rate is the sum of all product taxes on that order.

## Relationships
Name | Description
-- | --
`tax_rates` | **[Tax rates](#tax-rates)** `hasmany`<br>The different rates that need to be charged. <br/> Rates can be created/updated through the TaxRate resource by writing the `tax_rates_attributes` attrinute. 


Check matching attributes under [Fields](#tax-categories-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether tax category is archived.
`archived_at` | **datetime** `readonly` `nullable`<br>When the tax category was archived.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`default` | **boolean** <br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`.
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** <br>Name of the tax category.
`tax_rates_attributes` | **array** `writeonly`<br>The tax rates to associate.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List tax categories


> How to fetch a list of tax categories:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/tax_categories'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "eb6ca64a-1783-4ca7-8e92-8ec7ab3ff4eb",
        "type": "tax_categories",
        "attributes": {
          "created_at": "2021-09-13T19:57:01.000000+00:00",
          "updated_at": "2021-09-13T19:57:01.000000+00:00",
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

`GET /api/boomerang/tax_categories`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[tax_categories]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=tax_rates`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`default` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`tax_rates`






## Fetch a tax category


> How to fetch a tax categories with it's tax rates:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/tax_categories/471739b4-dc9f-404d-8324-c61a3de5e2da'
       --header 'content-type: application/json'
       --data-urlencode 'include=tax_rates'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "471739b4-dc9f-404d-8324-c61a3de5e2da",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-02-06T21:30:00.000000+00:00",
        "updated_at": "2021-02-06T21:30:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "data": [
            {
              "type": "tax_rates",
              "id": "2de2a095-6e4a-4ebd-8b21-6bb8dabfd593"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "2de2a095-6e4a-4ebd-8b21-6bb8dabfd593",
        "type": "tax_rates",
        "attributes": {
          "created_at": "2021-02-06T21:30:00.000000+00:00",
          "updated_at": "2021-02-06T21:30:00.000000+00:00",
          "name": "VAT",
          "value": 21.0,
          "position": 1,
          "owner_id": "471739b4-dc9f-404d-8324-c61a3de5e2da",
          "owner_type": "tax_categories"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/tax_categories/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[tax_categories]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=tax_rates`


### Includes

This request accepts the following includes:

`tax_rates`






## Create a tax category


> How to create a tax category with tax rates:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/tax_categories'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "tax_categories",
           "attributes": {
             "name": "Sales Tax",
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
      "id": "a2acf665-e4f1-4f21-8dbc-bc971ddc0930",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2022-01-08T11:51:00.000000+00:00",
        "updated_at": "2022-01-08T11:51:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Sales Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "data": [
            {
              "type": "tax_rates",
              "id": "823436f2-33a3-40d1-8841-d71705ec33f5"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "823436f2-33a3-40d1-8841-d71705ec33f5",
        "type": "tax_rates",
        "attributes": {
          "created_at": "2022-01-08T11:51:00.000000+00:00",
          "updated_at": "2022-01-08T11:51:00.000000+00:00",
          "name": "VAT",
          "value": 21.0,
          "position": 1,
          "owner_id": "a2acf665-e4f1-4f21-8dbc-bc971ddc0930",
          "owner_type": "tax_categories"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/tax_categories`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[tax_categories]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=tax_rates`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][default]` | **boolean** <br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`.
`data[attributes][name]` | **string** <br>Name of the tax category.
`data[attributes][tax_rates_attributes][]` | **array** <br>The tax rates to associate.


### Includes

This request accepts the following includes:

`tax_rates`






## Update a tax category


> How to update a tax category with tax rates:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/tax_categories/e3d7ddaf-e57a-47bb-8eef-839b7f1a4bfd'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "e3d7ddaf-e57a-47bb-8eef-839b7f1a4bfd",
           "type": "tax_categories",
           "attributes": {
             "name": "State Tax",
             "tax_rates_attributes": [
               {
                 "name": "VAT",
                 "value": 9
               },
               {
                 "id": "3341f09b-efc4-4586-8c73-2125fbb05896",
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
      "id": "e3d7ddaf-e57a-47bb-8eef-839b7f1a4bfd",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2021-11-08T05:22:00.000000+00:00",
        "updated_at": "2021-11-08T05:22:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "name": "State Tax",
        "default": false
      },
      "relationships": {
        "tax_rates": {
          "data": [
            {
              "type": "tax_rates",
              "id": "a9588059-d21e-4093-8059-b130c575b763"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "a9588059-d21e-4093-8059-b130c575b763",
        "type": "tax_rates",
        "attributes": {
          "created_at": "2021-11-08T05:22:00.000000+00:00",
          "updated_at": "2021-11-08T05:22:00.000000+00:00",
          "name": "VAT",
          "value": 9.0,
          "position": 2,
          "owner_id": "e3d7ddaf-e57a-47bb-8eef-839b7f1a4bfd",
          "owner_type": "tax_categories"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`PUT /api/boomerang/tax_categories/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[tax_categories]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=tax_rates`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][default]` | **boolean** <br>Whether this is the default tax category. Setting this value to `true` will set other tax categories to `false`.
`data[attributes][name]` | **string** <br>Name of the tax category.
`data[attributes][tax_rates_attributes][]` | **array** <br>The tax rates to associate.


### Includes

This request accepts the following includes:

`tax_rates`






## Delete a tax category


> How to delete a tax category with tax rates:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/tax_categories/c7095ef4-6e5b-42f7-8675-6fd1e233106f'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "c7095ef4-6e5b-42f7-8675-6fd1e233106f",
      "type": "tax_categories",
      "attributes": {
        "created_at": "2027-06-16T04:31:07.000000+00:00",
        "updated_at": "2027-06-16T04:31:07.000000+00:00",
        "archived": true,
        "archived_at": "2027-06-16T04:31:07.000000+00:00",
        "name": "Sales Tax (Deleted)",
        "default": false
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/boomerang/tax_categories/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[tax_categories]=created_at,updated_at,archived`


### Includes

This request does not accept any includes
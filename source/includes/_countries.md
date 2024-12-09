# Countries

The `Country` resource describes countries,
including the information required to validate the format of addresses.

## Relationships
Name | Description
-- | --
`provinces` | **[Provinces](#provinces)** `hasmany`<br>The provinces/states of this country (or any other administrative subdivision). 


Check matching attributes under [Fields](#countries-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`alpha2` | **string** `readonly`<br>ISO 3166-1 alpha-2 code. 
`city_autofill` | **string** `readonly`<br>The value to use for the city when autofilling. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`form_layout` | **string** `readonly`<br>The layout of the address form. 
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** `readonly`<br>Name of the country. 
`province_required` | **boolean** `readonly`<br>Whether a province is required for addresses in this country. 
`province_type` | **string** `readonly`<br>The province type of this country. 
`show_layout` | **string** `readonly`<br>The layout of the address when shown. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`zipcode_autofill` | **string** `readonly`<br>The value to use for the zipcode when autofilling. 
`zipcode_format` | **string** `readonly`<br>The format of the zipcode, as a regular expression. 
`zipcode_placeholder` | **string** `readonly`<br>The placeholder to use for the zipcode. 
`zipcode_required` | **boolean** `readonly`<br>Whether a zipcode is required for addresses in this country. 
`zipcode_type` | **string** `readonly`<br>The zipcode type of this country. 


## Listing countries


> How to fetch a list of countries:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/countries'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "adafbcae-49c4-4209-8932-8b822acb8924",
        "type": "countries",
        "attributes": {
          "created_at": "2028-11-04T19:33:00.000000+00:00",
          "updated_at": "2028-11-04T19:33:00.000000+00:00",
          "name": "Netherlands",
          "alpha2": "NL",
          "province_required": false,
          "province_type": "province",
          "form_layout": "{country}\n{first_name}{last_name}\n{address1}\n{address2}\n{zipcode}{city}",
          "show_layout": "{first_name} {last_name}\n{address1}\n{address2}\n{zipcode} {city}\n{country}",
          "zipcode_required": true,
          "zipcode_autofill": null,
          "zipcode_format": "\\d{4} ?[A-Z]{2}",
          "zipcode_placeholder": "1234 AB",
          "zipcode_type": "postcode",
          "city_autofill": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/countries`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[countries]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships `?include=provinces`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`alpha2` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`provinces`






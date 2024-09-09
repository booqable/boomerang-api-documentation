# Countries

The `Country` resource describes countries, including the information required to validate the format of addresses.

## Fields
Every country has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** `readonly`<br>Name of the country
`alpha2` | **String** `readonly`<br>ISO 3166-1 alpha-2 code
`province_required` | **Boolean** `readonly`<br>Whether a province is required for addresses in this country
`province_type` | **String** `readonly`<br>The province type of this country. One of `county`, `emirate`, `governorate`, `prefecture`, `province`, `region`, `state`, `state_and_territory`
`form_layout` | **String** `readonly`<br>The layout of the address form
`show_layout` | **String** `readonly`<br>The layout of the address when shown
`zipcode_required` | **Boolean** `readonly`<br>Whether a zipcode is required for addresses in this country
`zipcode_autofill` | **String** `readonly`<br>The value to use for the zipcode when autofilling
`zipcode_format` | **String** `readonly`<br>The format of the zipcode, as a regular expression
`zipcode_placeholder` | **String** `readonly`<br>The placeholder to use for the zipcode
`zipcode_type` | **String** `readonly`<br>The zipcode type of this country. One of `eircode`, `pincode`, `postal_code`, `postal_index`, `postcode`, `zipcode`
`city_autofill` | **String** `readonly`<br>The value to use for the city when autofilling


## Listing countries



> How to fetch a list of countries:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/countries' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6f46de7b-0193-4ff3-8656-d8ed7ad01dbb",
      "type": "countries",
      "attributes": {
        "created_at": "2024-09-09T09:23:21.811314+00:00",
        "updated_at": "2024-09-09T09:23:21.811314+00:00",
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
      }
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[countries]=created_at,updated_at,name`
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
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`alpha2` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
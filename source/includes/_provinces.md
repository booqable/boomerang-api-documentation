# Provinces

The `Province` resource describes provinces/states etc. in a country.

## Relationships
Name | Description
-- | --
`country` | **[Country](#countries)** `required`<br>The [Country](#countries) the province/state belongs to.


Check matching attributes under [Fields](#provinces-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`code` | **string** `readonly`<br>The code of the province/state.
`country_id` | **uuid** `readonly`<br>The [Country](#countries) the province/state belongs to.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** `readonly`<br>The name of the province/state.
`position` | **integer** `readonly`<br>The position of the province/state in the list.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List provinces


> How to fetch a list of provinces:

```shell
  curl --get 'https://example.booqable.com/api/4/provinces'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "3026cccd-b110-4086-805e-a014d51387c0",
        "type": "provinces",
        "attributes": {
          "created_at": "2027-04-07T00:26:00.000000+00:00",
          "updated_at": "2027-04-07T00:26:00.000000+00:00",
          "name": "Friesland",
          "code": "FR",
          "position": 0,
          "country_id": "f5f75fb6-0967-4cc7-862d-b277d7a5bd44"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/provinces`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[provinces]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`code` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`country_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`position` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
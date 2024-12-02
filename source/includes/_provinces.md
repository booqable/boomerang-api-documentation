# Provinces

The `Province` resource describes provinces/states etc. in a country.

## Fields
Every province has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** `readonly`<br>The name of the province/state.
`code` | **String** `readonly`<br>The code of the province/state.
`position` | **Integer** `readonly`<br>The position of the province/state in the list.
`country_id` | **Uuid** `readonly`<br>The ID of the country the province/state belongs to.


## Relationships
Provinces have the following relationships:

Name | Description
-- | --
`country` | **[Country](#countries)** <br>Associated Country


## Listing provinces



> How to fetch a list of provinces.:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/provinces' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8fd48290-f2b8-4720-bda1-83461ebb46c5",
      "type": "provinces",
      "attributes": {
        "created_at": "2024-12-02T13:01:06.218136+00:00",
        "updated_at": "2024-12-02T13:01:06.218136+00:00",
        "name": "Friesland",
        "code": "FR",
        "position": 0,
        "country_id": "de2bfd43-e5b3-4ef5-8b14-3d9439889116"
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[provinces]=created_at,updated_at,name`
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
`country_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
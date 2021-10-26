# Login activities

A list of all login attempts for the current employee.
## Endpoints
`GET /api/boomerang/login_activities`

## Fields
Every login activity has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`ip` | **String** `readonly`<br>IP address of the login attempt
`strategy` | **String** `readonly`<br>One of `saml`, `token`, `single_use`, `database_authenticatable`, `rememberable`, `BooqableApp-iOS`
`success` | **Boolean** `readonly`<br>Whether attempt was succesful
`failure_reason` | **String** `nullable` `readonly`<br>Why the login failed, One of `not_found_in_database`, `inactive`, `unconfirmed`, `invalid`, `session_limited`, `invited`
`user_agent` | **String** `readonly`<br>Client application identifier
`city` | **String** `nullable` `readonly`<br>City where login attempt was performed
`region` | **String** `nullable` `readonly`<br>Region where login attempt was performed
`country` | **String** `nullable` `readonly`<br>Country where login attempt was performed


## Listing login activities



> How to fetch a list of login activities

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/login_activities' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ffc50769-1311-46b9-bd6a-542ce6b28c57",
      "type": "login_activities",
      "attributes": {
        "ip": "192.168.1.28",
        "strategy": "saml",
        "success": false,
        "failure_reason": "inactive",
        "user_agent": "Mozilla/5.0 (platform; rv:geckoversion) Gecko/geckotrail Firefox/firefoxversion",
        "city": "Almere",
        "region": "Flevoland",
        "country": "Netherlands"
      }
    }
  ],
  "links": {
    "self": "api/boomerang/login_activities?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/login_activities?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/login_activities?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/login_activities`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[login_activities]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-26T09:51:27Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`ip` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`strategy` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`success` | **Boolean**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
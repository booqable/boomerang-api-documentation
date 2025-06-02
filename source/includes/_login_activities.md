# Login activities

A list of all login attempts for the current employee.

## Fields

 Name | Description
-- | --
`city` | **string** `readonly` `nullable`<br>City from where login attempt was performed. 
`country` | **string** `readonly` `nullable`<br>Country from where login attempt was performed. 
`created_at` | **datetime** `readonly`<br>The time at which the login was attempted. 
`failure_reason` | **enum** `readonly` `nullable`<br>Why the login failed.<br> One of: `not_found_in_database`, `inactive`, `unconfirmed`, `invalid`, `invited`.
`id` | **uuid** `readonly`<br>Primary key.
`ip` | **string** `readonly`<br>IP address of the login attempt. 
`region` | **string** `readonly` `nullable`<br>Region from where login attempt was performed. 
`strategy` | **enum** `readonly`<br>Indicates which login mechanism was used.<br> One of: `database_authenticatable`, `oauth`, `rememberable`, `saml`, `single_use`, `support`, `token`, `BooqableApp-iOS`.
`success` | **boolean** `readonly`<br>Whether attempt was successful. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`user_agent` | **string** `readonly` `nullable`<br>Client application identifier. 


## List login activities


> How to fetch a list of login activities:

```shell
  curl --get 'https://example.booqable.com/api/4/login_activities'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "e1a2d455-15aa-48cc-8314-e5db20769dbf",
        "type": "login_activities",
        "attributes": {
          "created_at": "2016-08-08T16:25:27.000000+00:00",
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
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/login_activities`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[login_activities]=created_at,updated_at,ip`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`city` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`country` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`failure_reason` | **enum** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`ip` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`region` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`strategy` | **enum** <br>`eq`
`success` | **boolean** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`user_agent` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
# Integrations

Integrations store configuration for external services that connect to Booqable.
Each integration has a `name` that identifies its type (e.g., `sso` for Single Sign-On)
and a `data` hash that contains the integration-specific configuration.

## SSO Integration

The SSO integration (`name: "sso"`) stores SAML Single Sign-On configuration:

Name | Description
-- | --
`idp_sso_target_url` | **String**<br>The Identity Provider's login URL
`idp_cert` | **String**<br>The Identity Provider's X.509 certificate (PEM format)
`cert` | **Hash** `readonly`<br>Parsed certificate metadata (issuer, not_before, not_after, error)

When updating the `idp_cert`, the certificate is automatically parsed and metadata
is stored in the `cert` field. If parsing fails, an error message is stored instead.

## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`data` | **hash** <br>Hash containing integration-specific configuration. The structure depends on the integration type. 
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** <br>The integration identifier (e.g., `sso`).
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List integrations


> How to fetch a list of integrations:

```shell
  curl --get 'https://example.booqable.com/api/4/integrations'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "a72f7498-becd-4c3d-8238-b98c19ebc0f9",
        "type": "integrations",
        "attributes": {
          "created_at": "2016-04-07T01:39:00.000000+00:00",
          "updated_at": "2016-04-07T01:39:00.000000+00:00",
          "name": "sso",
          "data": {
            "idp_sso_target_url": "https://idp.example.com/login",
            "cert": {
              "issuer": "Example Corp",
              "not_before": "2024-01-01T00:00:00Z",
              "not_after": "2025-01-01T00:00:00Z"
            }
          }
        }
      }
    ],
    "meta": {}
  }
```

> How to filter integrations by name:

```shell
  curl --get 'https://example.booqable.com/api/4/integrations'
       --header 'content-type: application/json'
       --data-urlencode 'filter[name]=sso'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "81148d1f-7f84-4132-8fc7-039b67dbd92e",
        "type": "integrations",
        "attributes": {
          "created_at": "2028-10-11T19:10:00.000000+00:00",
          "updated_at": "2028-10-11T19:10:00.000000+00:00",
          "name": "sso",
          "data": {
            "idp_sso_target_url": "https://idp.example.com/login",
            "cert": {
              "issuer": "Example Corp",
              "not_before": "2024-01-01T00:00:00Z",
              "not_after": "2025-01-01T00:00:00Z"
            }
          }
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/integrations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[integrations]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`data` | **hash** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch an integration


> How to fetch an integration:

```shell
  curl --get 'https://example.booqable.com/api/4/integrations/2c3b7442-f0de-4570-8fb8-8dfc5386761a'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "2c3b7442-f0de-4570-8fb8-8dfc5386761a",
      "type": "integrations",
      "attributes": {
        "created_at": "2020-03-13T05:04:02.000000+00:00",
        "updated_at": "2020-03-13T05:04:02.000000+00:00",
        "name": "sso",
        "data": {
          "idp_sso_target_url": "https://idp.example.com/login",
          "cert": {
            "issuer": "Example Corp",
            "not_before": "2024-01-01T00:00:00Z",
            "not_after": "2025-01-01T00:00:00Z"
          }
        }
      }
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/integrations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[integrations]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Update an integration


> How to update SSO configuration:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/integrations/b120c196-d8db-4a30-8d58-269c7b9f53bd'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "integrations",
           "id": "b120c196-d8db-4a30-8d58-269c7b9f53bd",
           "attributes": {
             "data": {
               "idp_sso_target_url": "https://new-idp.example.com/sso"
             }
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "b120c196-d8db-4a30-8d58-269c7b9f53bd",
      "type": "integrations",
      "attributes": {
        "created_at": "2022-11-28T08:06:02.000000+00:00",
        "updated_at": "2022-11-28T08:06:02.000000+00:00",
        "name": "sso",
        "data": {
          "idp_sso_target_url": "https://new-idp.example.com/sso",
          "cert": {
            "issuer": "Example Corp",
            "not_before": "2024-01-01T00:00:00Z",
            "not_after": "2025-01-01T00:00:00Z"
          }
        }
      }
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/integrations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[integrations]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][data]` | **hash** <br>Hash containing integration-specific configuration. The structure depends on the integration type. 
`data[attributes][name]` | **string** <br>The integration identifier (e.g., `sso`).


### Includes

This request does not accept any includes
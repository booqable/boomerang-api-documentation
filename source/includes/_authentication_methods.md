# Authentication methods

Authentication methods define ways to authenticate with the API. They are always scoped to the currently signed-in employee. Booqable offers two kinds of strategies for API authentication:

1. `token` Access tokens
2. `single_use` Single-use tokens (request signing)

The following algorithms are supported to sign requests (`single_use`):

- `ES256`
- `RS256`
- `HS256`

See [Authentication](#authentication) for more information on authenticating with the API.

## Endpoints
`GET /api/boomerang/authentication_methods/{id}`

`DELETE /api/boomerang/authentication_methods/{id}`

`POST /api/boomerang/authentication_methods`

`GET /api/boomerang/authentication_methods`

## Fields
Every authentication method has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>Name of the key (for identification)
`kind` | **String** <br>One of `token`, `single_use`, `oauth`
`algorithm` | **String** <br>One of `ES256`, `RS256`, `HS256`
`employee_id` | **Uuid** `readonly`<br>The associated Employee
`company_id` | **Uuid** `readonly`<br>The associated Company
`key` | **String** <br>Key that is being used for authentication strategy


## Relationships
Authentication methods have the following relationships:

Name | Description
-- | --
`employee` | **Employees** `readonly`<br>Associated Employee
`company` | **Companies** `readonly`<br>Associated Company


## Fetching an authentication method



> How to fetch an authentication method:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/3164114e-5e06-4ac2-8415-b17a19fe8eb5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3164114e-5e06-4ac2-8415-b17a19fe8eb5",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-05-27T09:27:31.064715+00:00",
      "updated_at": "2024-05-27T09:27:31.064715+00:00",
      "name": "Segment integration",
      "key": "9ae7d8955a87e6865da4973d30bd56e38b12704c4d26e56b69638da28b885b12",
      "kind": "token",
      "algorithm": null,
      "employee_id": "a4bfd0d4-4479-40cf-85c5-edeb145f4eed",
      "company_id": "3cdfab4f-043c-4079-99c9-68fa9bc0efbf"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/a4bfd0d4-4479-40cf-85c5-edeb145f4eed"
        }
      },
      "company": {
        "links": {
          "related": "api/boomerang/companies/3cdfab4f-043c-4079-99c9-68fa9bc0efbf"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/authentication_methods/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[authentication_methods]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Deleting an authentication method



> How to delete an authentication method:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/d04ab5ba-bb6e-4f27-8b92-5effabac8391' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d04ab5ba-bb6e-4f27-8b92-5effabac8391",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-05-27T09:27:32.325572+00:00",
      "updated_at": "2024-05-27T09:27:32.382548+00:00",
      "name": "Segment integration",
      "key": "2bdcff1a30a2c33b8154d2007da7a6d3ef10529569bfab37868d9c6b6f9f8558",
      "kind": "token",
      "algorithm": null,
      "employee_id": "8728ab9c-d70d-46e4-956a-c0f3d4c2b581",
      "company_id": "fba45512-0fdb-4da1-91eb-eb95de3851bf"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/8728ab9c-d70d-46e4-956a-c0f3d4c2b581"
        }
      },
      "company": {
        "links": {
          "related": "api/boomerang/companies/fba45512-0fdb-4da1-91eb-eb95de3851bf"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/authentication_methods/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[authentication_methods]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Creating an authentication method



> How to create a token authentication method:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/authentication_methods' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "authentication_methods",
        "attributes": {
          "name": "Segment integration"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2198fd4d-11de-45c9-8086-308e1297361c",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-05-27T09:27:33.729353+00:00",
      "updated_at": "2024-05-27T09:27:33.729353+00:00",
      "name": "Segment integration",
      "key": "13b9059237167fc843343cac5b5d8734b797a9daae03d3ec2df2f70359765a15",
      "kind": "token",
      "algorithm": null,
      "employee_id": "27e2c198-1062-45bf-81c7-949beb31cefe",
      "company_id": "4a7e5cdd-9d3e-4758-bd1f-ea1a6ae988a8"
    },
    "relationships": {
      "employee": {
        "meta": {
          "included": false
        }
      },
      "company": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> How to create a single_use authentication method (with HS256 strategy):

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/authentication_methods' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "authentication_methods",
        "attributes": {
          "name": "Segment integration",
          "kind": "single_use",
          "algorithm": "HS256"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "bd009c1c-9858-469b-b9f1-ff7eaa1d7219",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-05-27T09:27:35.092089+00:00",
      "updated_at": "2024-05-27T09:27:35.092089+00:00",
      "name": "Segment integration",
      "key": "197b9841bb85b539b8854bbe093cfdd26ca4a7875627629427710c2313d31963",
      "kind": "single_use",
      "algorithm": "HS256",
      "employee_id": "477af73b-7371-429d-94ac-75191484c928",
      "company_id": "adaf8d25-06dd-4f77-bc12-c52e2572d14d"
    },
    "relationships": {
      "employee": {
        "meta": {
          "included": false
        }
      },
      "company": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> How to create a single_use authentication method (with ES256 strategy):

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/authentication_methods' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "authentication_methods",
        "attributes": {
          "name": "Segment integration",
          "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
          "kind": "single_use",
          "algorithm": "ES256"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "cae64f28-3ba1-4d5e-b24e-597b96251a94",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-05-27T09:27:37.158572+00:00",
      "updated_at": "2024-05-27T09:27:37.158572+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256",
      "employee_id": "f38e6770-19d5-4b9f-a20b-7cffe0581cc2",
      "company_id": "71b006b6-fa69-45e9-a036-1357492a46e1"
    },
    "relationships": {
      "employee": {
        "meta": {
          "included": false
        }
      },
      "company": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> How to create a single_use authentication method (with RS256 strategy):

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/authentication_methods' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "authentication_methods",
        "attributes": {
          "name": "Segment integration",
          "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
          "kind": "single_use",
          "algorithm": "RS256"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c58f5333-501a-4777-b7b8-7cb6d0dd1011",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-05-27T09:27:38.445283+00:00",
      "updated_at": "2024-05-27T09:27:38.445283+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256",
      "employee_id": "509ed47e-3b5d-4163-b650-ee80874f61e2",
      "company_id": "fb5346f8-bd9e-4e34-a702-d378c11a4de2"
    },
    "relationships": {
      "employee": {
        "meta": {
          "included": false
        }
      },
      "company": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/authentication_methods`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee,company`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[authentication_methods]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the key (for identification)
`data[attributes][kind]` | **String** <br>One of `token`, `single_use`, `oauth`
`data[attributes][algorithm]` | **String** <br>One of `ES256`, `RS256`, `HS256`
`data[attributes][key]` | **String** <br>Key that is being used for authentication strategy


### Includes

This request accepts the following includes:

`employee`


`company`






## Listing authentication methods



> How to fetch a list of authentication methods:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/authentication_methods' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dad3e6a5-fb94-46dc-8d3a-fa67c987a6d7",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2024-05-27T09:27:39.804313+00:00",
        "updated_at": "2024-05-27T09:27:39.804313+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "employee_id": "8e3e4ed0-2e0d-43ee-9dcb-526b2fd43a51",
        "company_id": "3812a3db-18dd-4989-8c02-fcc7ab89c0d7"
      },
      "relationships": {
        "employee": {
          "links": {
            "related": "api/boomerang/employees/8e3e4ed0-2e0d-43ee-9dcb-526b2fd43a51"
          }
        },
        "company": {
          "links": {
            "related": "api/boomerang/companies/3812a3db-18dd-4989-8c02-fcc7ab89c0d7"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/authentication_methods`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[authentication_methods]=created_at,updated_at,name`
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
`kind` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`algorithm` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`employee_id` | **Uuid** <br>`eq`, `not_eq`
`company_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
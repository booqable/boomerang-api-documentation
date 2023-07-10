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
`GET /api/boomerang/authentication_methods`

`GET /api/boomerang/authentication_methods/{id}`

`POST /api/boomerang/authentication_methods`

`DELETE /api/boomerang/authentication_methods/{id}`

## Fields
Every authentication method has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>Name of the key (for identification)
`kind` | **String** <br>One of `token`, `single_use`
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
      "id": "a482a1c3-a6c0-43a3-a698-656425ca94f5",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2023-07-10T09:15:42+00:00",
        "updated_at": "2023-07-10T09:15:42+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "employee_id": "acdc825f-9e30-4d47-b366-69701f53d93e",
        "company_id": "3636eb60-f940-4a95-a2cf-2ef2b2ef7a09"
      },
      "relationships": {
        "employee": {
          "links": {
            "related": "api/boomerang/employees/acdc825f-9e30-4d47-b366-69701f53d93e"
          }
        },
        "company": {
          "links": {
            "related": "api/boomerang/companies/3636eb60-f940-4a95-a2cf-2ef2b2ef7a09"
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
## Fetching an authentication method



> How to fetch an authentication method:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/2acc4bfc-05d3-404d-90a6-9d441f4e2fae' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2acc4bfc-05d3-404d-90a6-9d441f4e2fae",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2023-07-10T09:15:43+00:00",
      "updated_at": "2023-07-10T09:15:43+00:00",
      "name": "Segment integration",
      "key": "641e71a2aa0fb226c97c7030796be5ca0eec342a56bae313041cd95ff933b4e2",
      "kind": "token",
      "algorithm": null,
      "employee_id": "979d87e9-b0f4-4617-83d7-1312dd7f93c8",
      "company_id": "da248031-cba9-4270-83b9-bd8cc6a80951"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/979d87e9-b0f4-4617-83d7-1312dd7f93c8"
        }
      },
      "company": {
        "links": {
          "related": "api/boomerang/companies/da248031-cba9-4270-83b9-bd8cc6a80951"
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
    "id": "1ebe1955-6ada-4395-a9b4-00415fff345c",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2023-07-10T09:15:44+00:00",
      "updated_at": "2023-07-10T09:15:44+00:00",
      "name": "Segment integration",
      "key": "9b5f9a1f5d78afae8ddd314b6798ad994fbd84f5963d4f65d60d4c79dd030162",
      "kind": "token",
      "algorithm": null,
      "employee_id": "b2a01045-9a8f-49d6-af88-c80b4dc87839",
      "company_id": "de613b1a-c3bd-4511-897b-f4b95c76b9d0"
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
    "id": "1da4bab4-1d2e-45a7-bbba-e2863a81214e",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2023-07-10T09:15:45+00:00",
      "updated_at": "2023-07-10T09:15:45+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256",
      "employee_id": "178fbc29-fcb3-49ef-978f-5de09f2a3d54",
      "company_id": "84a8badb-f5e3-4ad6-a427-8103cbe9da52"
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
    "id": "2fa8b503-654f-45c5-87eb-e01b295f8703",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2023-07-10T09:15:45+00:00",
      "updated_at": "2023-07-10T09:15:45+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256",
      "employee_id": "4c094464-e499-4470-b711-6ae6c2442aa2",
      "company_id": "5c9a1aba-3668-4c96-bb74-1b39b789e71b"
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
    "id": "c3709900-820d-48ca-8415-6d9965103e7d",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2023-07-10T09:15:46+00:00",
      "updated_at": "2023-07-10T09:15:46+00:00",
      "name": "Segment integration",
      "key": "64bb6acb02e9c16557972cb1d82c4c93b4c3ebcfadb0b77cacc4a12c36fc18af",
      "kind": "single_use",
      "algorithm": "HS256",
      "employee_id": "7b577b30-9ecf-40b3-9a42-e4667159e130",
      "company_id": "a7a45404-2fd6-4d3c-8144-e12213ec9e27"
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
`data[attributes][kind]` | **String** <br>One of `token`, `single_use`
`data[attributes][algorithm]` | **String** <br>One of `ES256`, `RS256`, `HS256`
`data[attributes][key]` | **String** <br>Key that is being used for authentication strategy


### Includes

This request accepts the following includes:

`employee`


`company`






## Deleting an authentication method



> How to delete an authentication method:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/b20968ae-6bcf-44a4-8c7e-20644f7dabe7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
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
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
      "id": "54c1a2b7-33d7-41e6-88f5-d268e709d94c",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2024-06-10T09:23:52.980676+00:00",
        "updated_at": "2024-06-10T09:23:52.980676+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "employee_id": "12285a11-bfa4-45bf-9112-a55b8d1df2af",
        "company_id": "e47dbd0d-ae7b-4bf2-bc5b-2d1d7ac078f7"
      },
      "relationships": {
        "employee": {
          "links": {
            "related": "api/boomerang/employees/12285a11-bfa4-45bf-9112-a55b8d1df2af"
          }
        },
        "company": {
          "links": {
            "related": "api/boomerang/companies/e47dbd0d-ae7b-4bf2-bc5b-2d1d7ac078f7"
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/5f636da4-d33c-4b7a-b16f-859bad31a969' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5f636da4-d33c-4b7a-b16f-859bad31a969",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-06-10T09:24:01.882373+00:00",
      "updated_at": "2024-06-10T09:24:01.882373+00:00",
      "name": "Segment integration",
      "key": "ed24576ac1b604a6f5b18db3aaa317f5a05c014af272a220dbbf57f207fdc65a",
      "kind": "token",
      "algorithm": null,
      "employee_id": "ccda146a-ea44-4b57-ae27-d5ce58cac98d",
      "company_id": "3c51a03b-fcd4-4fcc-a0ce-d230f8ef2bfd"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/ccda146a-ea44-4b57-ae27-d5ce58cac98d"
        }
      },
      "company": {
        "links": {
          "related": "api/boomerang/companies/3c51a03b-fcd4-4fcc-a0ce-d230f8ef2bfd"
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
    "id": "14790124-701c-458c-a681-e8eaac180911",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-06-10T09:23:54.269045+00:00",
      "updated_at": "2024-06-10T09:23:54.269045+00:00",
      "name": "Segment integration",
      "key": "8b0ac9db6aa2cd02a55e28531fa7343bfd2b9c1f4003d7e81c47b65c6efb471c",
      "kind": "token",
      "algorithm": null,
      "employee_id": "408876af-148a-45e0-a632-c54b0cd99eb0",
      "company_id": "12f7f4b0-01b7-4b72-b746-64f512931c91"
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
    "id": "2ec99df0-a3c7-4756-8912-12ee98da3691",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-06-10T09:23:59.077732+00:00",
      "updated_at": "2024-06-10T09:23:59.077732+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256",
      "employee_id": "cb250900-f39d-4f1d-ad39-85f15566d177",
      "company_id": "710526a3-114f-4258-b6bc-fe6aa5306758"
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
    "id": "80384ac8-4dfb-403c-b733-62601fd0acea",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-06-10T09:23:57.777879+00:00",
      "updated_at": "2024-06-10T09:23:57.777879+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256",
      "employee_id": "aeb5c592-ebe3-4244-adb8-46a617038daf",
      "company_id": "3cf690c3-c708-4634-9182-9c6b33de46c7"
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
    "id": "b369ca9b-a1bd-437a-aa32-c3e38fcd02f8",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-06-10T09:23:56.066560+00:00",
      "updated_at": "2024-06-10T09:23:56.066560+00:00",
      "name": "Segment integration",
      "key": "fb766f6c2ee93d2f213727c90770837d0cc8ec7fae69a0b21d5e2e527912d619",
      "kind": "single_use",
      "algorithm": "HS256",
      "employee_id": "82ea0811-c94b-4a50-9786-d8980c9d49ac",
      "company_id": "14a4abfa-5676-4565-87df-ab39fe76a194"
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






## Deleting an authentication method



> How to delete an authentication method:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/33801256-edfe-45a3-aefe-463067c9b6d1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "33801256-edfe-45a3-aefe-463067c9b6d1",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-06-10T09:24:00.401556+00:00",
      "updated_at": "2024-06-10T09:24:00.457752+00:00",
      "name": "Segment integration",
      "key": "bbb517d321846c6b5f0989da5b1c3df1dae86be5c1d5507a9a9fadbadc16cd1d",
      "kind": "token",
      "algorithm": null,
      "employee_id": "f47143aa-443a-44dc-b3e6-733c088dc78e",
      "company_id": "8470555c-c535-470d-bbe9-b241d8daf587"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/f47143aa-443a-44dc-b3e6-733c088dc78e"
        }
      },
      "company": {
        "links": {
          "related": "api/boomerang/companies/8470555c-c535-470d-bbe9-b241d8daf587"
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
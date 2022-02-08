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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>Name of the key (for identification)
`kind` | **String**<br>One of `token`, `single_use`
`algorithm` | **String**<br>One of `ES256`, `RS256`, `HS256`
`employee_id` | **Uuid** `readonly`<br>The associated Employee
`company_id` | **Uuid** `readonly`<br>The associated Company
`key` | **String** `extra`<br>Key that is being used for authentication strategy


## Relationships
Authentication methods have the following relationships:

Name | Description
- | -
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
      "id": "0a93f0a9-8dad-4381-9270-7c8d63877a19",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2022-02-08T09:12:31+00:00",
        "updated_at": "2022-02-08T09:12:31+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "employee_id": "576cfc7c-fe1b-4ea9-9db1-89dd1fe503f8",
        "company_id": "ed22d610-5e16-46d9-86a7-4c00d910961c"
      },
      "relationships": {
        "employee": {
          "links": {
            "related": "api/boomerang/employees/576cfc7c-fe1b-4ea9-9db1-89dd1fe503f8"
          }
        },
        "company": {
          "links": {
            "related": "api/boomerang/companies/ed22d610-5e16-46d9-86a7-4c00d910961c"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=employee,company`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[authentication_methods]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-08T09:12:26Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`kind` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`algorithm` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`employee_id` | **Uuid**<br>`eq`, `not_eq`
`company_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching an authentication method



> How to fetch an authentication method:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/9f96e4dd-c983-4c9b-812f-418360b19373' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9f96e4dd-c983-4c9b-812f-418360b19373",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-02-08T09:12:32+00:00",
      "updated_at": "2022-02-08T09:12:32+00:00",
      "name": "Segment integration",
      "key": "1ef7e1a9d8b5e4d464b19ade703c3cfdb9788dc72ad0f375816546aee0b20322",
      "kind": "token",
      "algorithm": null,
      "employee_id": "3c7628e4-a0cb-4472-9f31-180928e42f33",
      "company_id": "0ec187f2-18f7-432b-9848-685069ed6c25"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/3c7628e4-a0cb-4472-9f31-180928e42f33"
        }
      },
      "company": {
        "links": {
          "related": "api/boomerang/companies/0ec187f2-18f7-432b-9848-685069ed6c25"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=employee,company`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[authentication_methods]=id,created_at,updated_at`


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
    "id": "cbeb27f8-ad85-4d33-b271-e564e118eb23",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-02-08T09:12:33+00:00",
      "updated_at": "2022-02-08T09:12:33+00:00",
      "name": "Segment integration",
      "key": "b66d141101799fb71b9aee261f9dcd35dafc2f78062b6dd1281dd11e861c9dd6",
      "kind": "token",
      "algorithm": null,
      "employee_id": "3119c591-3366-4003-b210-9552aa32e4f0",
      "company_id": "9a898760-6c9e-44a1-8101-900128fac0f4"
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
    "id": "d202a3d7-85f2-4966-978e-fdb8ab534101",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-02-08T09:12:34+00:00",
      "updated_at": "2022-02-08T09:12:34+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256",
      "employee_id": "6b1cbd03-43e3-4f92-9532-15e7a56a6f8f",
      "company_id": "b45c9b1b-e404-45a4-8e99-9133b0c95be5"
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
    "id": "65f5ed5c-a0af-4756-b294-646b8240ee4c",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-02-08T09:12:35+00:00",
      "updated_at": "2022-02-08T09:12:35+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256",
      "employee_id": "27c17b1b-7a5a-4e22-a1e8-c19a8ee74e81",
      "company_id": "6a5dab82-ebeb-4396-a94c-33b7db97705c"
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
    "id": "a946b606-537e-4b1b-a1d7-0d6142b5b9ce",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-02-08T09:12:36+00:00",
      "updated_at": "2022-02-08T09:12:36+00:00",
      "name": "Segment integration",
      "key": "5e4a762e08a68bfdd67bbba435ea93a066b68fbb054703f34ed8c9f5e4e0a7f1",
      "kind": "single_use",
      "algorithm": "HS256",
      "employee_id": "ee349c86-bbee-413e-a62e-03ca9409df4a",
      "company_id": "4ee7deb7-f1a5-43c3-9080-97346a5e7115"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=employee,company`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[authentication_methods]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the key (for identification)
`data[attributes][kind]` | **String**<br>One of `token`, `single_use`
`data[attributes][algorithm]` | **String**<br>One of `ES256`, `RS256`, `HS256`
`data[attributes][key]` | **String**<br>Key that is being used for authentication strategy


### Includes

This request accepts the following includes:

`employee`


`company`






## Deleting an authentication method



> How to delete an authentication method:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/b066fb66-8e30-45e1-9c0f-d99bbefa4d8e' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=employee,company`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[authentication_methods]=id,created_at,updated_at`


### Includes

This request does not accept any includes
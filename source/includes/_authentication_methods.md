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
      "id": "508dbb9d-6a4e-4507-822b-52144d72b8e1",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2022-06-16T19:29:37+00:00",
        "updated_at": "2022-06-16T19:29:37+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "employee_id": "7aca6d35-6119-4ec0-8c3c-2478361c73cf",
        "company_id": "ef9b0d15-cf39-4471-ad6d-dbf1c3cb983f"
      },
      "relationships": {
        "employee": {
          "links": {
            "related": "api/boomerang/employees/7aca6d35-6119-4ec0-8c3c-2478361c73cf"
          }
        },
        "company": {
          "links": {
            "related": "api/boomerang/companies/ef9b0d15-cf39-4471-ad6d-dbf1c3cb983f"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-16T19:29:29Z`
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/55b78b62-71dd-4e45-ab0f-c3c9acea9b8b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "55b78b62-71dd-4e45-ab0f-c3c9acea9b8b",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-06-16T19:29:38+00:00",
      "updated_at": "2022-06-16T19:29:38+00:00",
      "name": "Segment integration",
      "key": "940398d7bb50bb779fc1de32293e18471718c1e61242e40346127fce544512ca",
      "kind": "token",
      "algorithm": null,
      "employee_id": "59561c81-07ce-457f-bbf7-c9d782cd5239",
      "company_id": "2407a78d-b5bf-40ee-bc56-4b97aca64d95"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/59561c81-07ce-457f-bbf7-c9d782cd5239"
        }
      },
      "company": {
        "links": {
          "related": "api/boomerang/companies/2407a78d-b5bf-40ee-bc56-4b97aca64d95"
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
    "id": "45a08e67-b512-4835-8b7b-afb6d01b203f",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-06-16T19:29:39+00:00",
      "updated_at": "2022-06-16T19:29:39+00:00",
      "name": "Segment integration",
      "key": "ea7830321046d276d4fcd8494fe43d4b22fd7bb79900a84508f90609bb464a59",
      "kind": "token",
      "algorithm": null,
      "employee_id": "c08f79c0-cd70-4faa-8de0-35e7a16f3a08",
      "company_id": "957991ab-65f3-4b43-a24a-d567df4308a7"
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
    "id": "665e5290-c4e3-4762-b914-66b6d56779a1",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-06-16T19:29:40+00:00",
      "updated_at": "2022-06-16T19:29:40+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256",
      "employee_id": "786a4bff-d84f-4302-a0e7-5a2046088089",
      "company_id": "1c11801a-b367-48b8-8875-bd20393dc277"
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
    "id": "fd343f7c-81d4-40e8-b970-45b6d087ea0b",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-06-16T19:29:41+00:00",
      "updated_at": "2022-06-16T19:29:41+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256",
      "employee_id": "3cf85f17-930b-47e9-ba90-4072530bd0fe",
      "company_id": "340ef5b9-38f5-4cff-83f2-61551ed3fe34"
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
    "id": "97a8e8c2-fd7d-4921-9752-4542536ad9ef",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-06-16T19:29:42+00:00",
      "updated_at": "2022-06-16T19:29:42+00:00",
      "name": "Segment integration",
      "key": "78b9bc618716ccca9a209636908d3bf1397a63ca03e9867d0bb4132fe2fa468c",
      "kind": "single_use",
      "algorithm": "HS256",
      "employee_id": "fbc5d99f-f6ee-45b6-82db-6bd9eb494937",
      "company_id": "e933a226-10b2-4200-86d1-6a124655b2da"
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/b4f34228-11e6-469a-bfa0-7f97434dea7c' \
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
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
      "id": "9c0aafe6-611d-4dc1-a04b-73db3ecccc43",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2021-12-08T12:33:49+00:00",
        "updated_at": "2021-12-08T12:33:49+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "employee_id": "215d66da-857e-4081-988b-1acaff75f4f0",
        "company_id": "e0bb6599-ae66-41a8-b361-e08cf8b8ebe6"
      },
      "relationships": {
        "employee": {
          "links": {
            "related": "api/boomerang/employees/215d66da-857e-4081-988b-1acaff75f4f0"
          }
        },
        "company": {
          "links": {
            "related": "api/boomerang/companies/e0bb6599-ae66-41a8-b361-e08cf8b8ebe6"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/authentication_methods?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/authentication_methods?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/authentication_methods?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T12:33:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/b40f9701-a277-4093-a584-3a27ad4d9400' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b40f9701-a277-4093-a584-3a27ad4d9400",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-12-08T12:33:51+00:00",
      "updated_at": "2021-12-08T12:33:51+00:00",
      "name": "Segment integration",
      "key": "d0dd577ce0b0d9979f9e16f3c1253444b0c81752900c844f3c58bc5173d9f555",
      "kind": "token",
      "algorithm": null,
      "employee_id": "1116b9e4-14fc-48ee-8f77-84218b7ccfe4",
      "company_id": "4aba231f-cb35-4981-b8d9-19d66e9b8f21"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/1116b9e4-14fc-48ee-8f77-84218b7ccfe4"
        }
      },
      "company": {
        "links": {
          "related": "api/boomerang/companies/4aba231f-cb35-4981-b8d9-19d66e9b8f21"
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
    "id": "8aa2c1c7-1cf1-47da-b611-8076012172e9",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-12-08T12:33:51+00:00",
      "updated_at": "2021-12-08T12:33:51+00:00",
      "name": "Segment integration",
      "key": "69bbb4501f91d1d6c1442cdca92464ea9eb3f27061a7a4ef86f7744d6f9dfe19",
      "kind": "token",
      "algorithm": null,
      "employee_id": "494179b1-904c-41df-80c3-c90d41f26f99",
      "company_id": "029b3e86-1753-400a-99e2-73f08b3a7ce9"
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
  "links": {
    "self": "api/boomerang/authentication_methods?authentication_method%5Bdata%5D%5Battributes%5D%5Bname%5D=Segment+integration&authentication_method%5Bdata%5D%5Btype%5D=authentication_methods&data%5Battributes%5D%5Bname%5D=Segment+integration&data%5Btype%5D=authentication_methods&extra_fields%5Bauthentication_methods%5D=key&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/authentication_methods?authentication_method%5Bdata%5D%5Battributes%5D%5Bname%5D=Segment+integration&authentication_method%5Bdata%5D%5Btype%5D=authentication_methods&data%5Battributes%5D%5Bname%5D=Segment+integration&data%5Btype%5D=authentication_methods&extra_fields%5Bauthentication_methods%5D=key&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/authentication_methods?authentication_method%5Bdata%5D%5Battributes%5D%5Bname%5D=Segment+integration&authentication_method%5Bdata%5D%5Btype%5D=authentication_methods&data%5Battributes%5D%5Bname%5D=Segment+integration&data%5Btype%5D=authentication_methods&extra_fields%5Bauthentication_methods%5D=key&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    "id": "fbee828d-43f0-412e-98a3-9af46f996652",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-12-08T12:33:52+00:00",
      "updated_at": "2021-12-08T12:33:52+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256",
      "employee_id": "962be3e6-9e4a-41ef-aff5-c6643567a05a",
      "company_id": "cee6fe22-705b-4aaa-b419-d352cd115e91"
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
  "links": {
    "self": "api/boomerang/authentication_methods?authentication_method%5Bdata%5D%5Battributes%5D%5Balgorithm%5D=ES256&authentication_method%5Bdata%5D%5Battributes%5D%5Bkey%5D=-----BEGIN+PUBLIC+KEY-----%0AMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL%0AShY0rPpRLfU%2BY96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A%3D%3D%0A-----END+PUBLIC+KEY-----%0A&authentication_method%5Bdata%5D%5Battributes%5D%5Bkind%5D=single_use&authentication_method%5Bdata%5D%5Battributes%5D%5Bname%5D=Segment+integration&authentication_method%5Bdata%5D%5Btype%5D=authentication_methods&data%5Battributes%5D%5Balgorithm%5D=ES256&data%5Battributes%5D%5Bkey%5D=-----BEGIN+PUBLIC+KEY-----%0AMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL%0AShY0rPpRLfU%2BY96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A%3D%3D%0A-----END+PUBLIC+KEY-----%0A&data%5Battributes%5D%5Bkind%5D=single_use&data%5Battributes%5D%5Bname%5D=Segment+integration&data%5Btype%5D=authentication_methods&extra_fields%5Bauthentication_methods%5D=key&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/authentication_methods?authentication_method%5Bdata%5D%5Battributes%5D%5Balgorithm%5D=ES256&authentication_method%5Bdata%5D%5Battributes%5D%5Bkey%5D=-----BEGIN+PUBLIC+KEY-----%0AMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL%0AShY0rPpRLfU%2BY96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A%3D%3D%0A-----END+PUBLIC+KEY-----%0A&authentication_method%5Bdata%5D%5Battributes%5D%5Bkind%5D=single_use&authentication_method%5Bdata%5D%5Battributes%5D%5Bname%5D=Segment+integration&authentication_method%5Bdata%5D%5Btype%5D=authentication_methods&data%5Battributes%5D%5Balgorithm%5D=ES256&data%5Battributes%5D%5Bkey%5D=-----BEGIN+PUBLIC+KEY-----%0AMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL%0AShY0rPpRLfU%2BY96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A%3D%3D%0A-----END+PUBLIC+KEY-----%0A&data%5Battributes%5D%5Bkind%5D=single_use&data%5Battributes%5D%5Bname%5D=Segment+integration&data%5Btype%5D=authentication_methods&extra_fields%5Bauthentication_methods%5D=key&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/authentication_methods?authentication_method%5Bdata%5D%5Battributes%5D%5Balgorithm%5D=ES256&authentication_method%5Bdata%5D%5Battributes%5D%5Bkey%5D=-----BEGIN+PUBLIC+KEY-----%0AMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL%0AShY0rPpRLfU%2BY96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A%3D%3D%0A-----END+PUBLIC+KEY-----%0A&authentication_method%5Bdata%5D%5Battributes%5D%5Bkind%5D=single_use&authentication_method%5Bdata%5D%5Battributes%5D%5Bname%5D=Segment+integration&authentication_method%5Bdata%5D%5Btype%5D=authentication_methods&data%5Battributes%5D%5Balgorithm%5D=ES256&data%5Battributes%5D%5Bkey%5D=-----BEGIN+PUBLIC+KEY-----%0AMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL%0AShY0rPpRLfU%2BY96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A%3D%3D%0A-----END+PUBLIC+KEY-----%0A&data%5Battributes%5D%5Bkind%5D=single_use&data%5Battributes%5D%5Bname%5D=Segment+integration&data%5Btype%5D=authentication_methods&extra_fields%5Bauthentication_methods%5D=key&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    "id": "23ed8b41-87ab-470e-a181-1c34da88860f",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-12-08T12:33:53+00:00",
      "updated_at": "2021-12-08T12:33:53+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256",
      "employee_id": "78cf3d47-cba8-4fba-99f2-f63ddff4c261",
      "company_id": "809e57e4-517f-48e0-a380-cd60c5eed639"
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
  "links": {
    "self": "api/boomerang/authentication_methods?authentication_method%5Bdata%5D%5Battributes%5D%5Balgorithm%5D=RS256&authentication_method%5Bdata%5D%5Battributes%5D%5Bkey%5D=-----BEGIN+PUBLIC+KEY-----%0AMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp%0AjVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64%2Blpo7KWqQIL28dhtNAjImJmzcr04ve%0ARAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe%0A7kPCK%2FNfdiOuFlMjfaY%2B5WmaA1lAZ%2FSSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC%0AIU%2FDO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj%2FIlJiC%0APDEoc1x7b4opEuGp287S%2BDsRRgr6vzVZi4CPQcJJsG%2B07jZQN5K3wboBlx8LW2jT%0AfQIDAQAB%0A-----END+PUBLIC+KEY-----%0A&authentication_method%5Bdata%5D%5Battributes%5D%5Bkind%5D=single_use&authentication_method%5Bdata%5D%5Battributes%5D%5Bname%5D=Segment+integration&authentication_method%5Bdata%5D%5Btype%5D=authentication_methods&data%5Battributes%5D%5Balgorithm%5D=RS256&data%5Battributes%5D%5Bkey%5D=-----BEGIN+PUBLIC+KEY-----%0AMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp%0AjVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64%2Blpo7KWqQIL28dhtNAjImJmzcr04ve%0ARAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe%0A7kPCK%2FNfdiOuFlMjfaY%2B5WmaA1lAZ%2FSSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC%0AIU%2FDO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj%2FIlJiC%0APDEoc1x7b4opEuGp287S%2BDsRRgr6vzVZi4CPQcJJsG%2B07jZQN5K3wboBlx8LW2jT%0AfQIDAQAB%0A-----END+PUBLIC+KEY-----%0A&data%5Battributes%5D%5Bkind%5D=single_use&data%5Battributes%5D%5Bname%5D=Segment+integration&data%5Btype%5D=authentication_methods&extra_fields%5Bauthentication_methods%5D=key&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/authentication_methods?authentication_method%5Bdata%5D%5Battributes%5D%5Balgorithm%5D=RS256&authentication_method%5Bdata%5D%5Battributes%5D%5Bkey%5D=-----BEGIN+PUBLIC+KEY-----%0AMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp%0AjVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64%2Blpo7KWqQIL28dhtNAjImJmzcr04ve%0ARAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe%0A7kPCK%2FNfdiOuFlMjfaY%2B5WmaA1lAZ%2FSSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC%0AIU%2FDO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj%2FIlJiC%0APDEoc1x7b4opEuGp287S%2BDsRRgr6vzVZi4CPQcJJsG%2B07jZQN5K3wboBlx8LW2jT%0AfQIDAQAB%0A-----END+PUBLIC+KEY-----%0A&authentication_method%5Bdata%5D%5Battributes%5D%5Bkind%5D=single_use&authentication_method%5Bdata%5D%5Battributes%5D%5Bname%5D=Segment+integration&authentication_method%5Bdata%5D%5Btype%5D=authentication_methods&data%5Battributes%5D%5Balgorithm%5D=RS256&data%5Battributes%5D%5Bkey%5D=-----BEGIN+PUBLIC+KEY-----%0AMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp%0AjVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64%2Blpo7KWqQIL28dhtNAjImJmzcr04ve%0ARAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe%0A7kPCK%2FNfdiOuFlMjfaY%2B5WmaA1lAZ%2FSSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC%0AIU%2FDO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj%2FIlJiC%0APDEoc1x7b4opEuGp287S%2BDsRRgr6vzVZi4CPQcJJsG%2B07jZQN5K3wboBlx8LW2jT%0AfQIDAQAB%0A-----END+PUBLIC+KEY-----%0A&data%5Battributes%5D%5Bkind%5D=single_use&data%5Battributes%5D%5Bname%5D=Segment+integration&data%5Btype%5D=authentication_methods&extra_fields%5Bauthentication_methods%5D=key&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/authentication_methods?authentication_method%5Bdata%5D%5Battributes%5D%5Balgorithm%5D=RS256&authentication_method%5Bdata%5D%5Battributes%5D%5Bkey%5D=-----BEGIN+PUBLIC+KEY-----%0AMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp%0AjVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64%2Blpo7KWqQIL28dhtNAjImJmzcr04ve%0ARAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe%0A7kPCK%2FNfdiOuFlMjfaY%2B5WmaA1lAZ%2FSSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC%0AIU%2FDO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj%2FIlJiC%0APDEoc1x7b4opEuGp287S%2BDsRRgr6vzVZi4CPQcJJsG%2B07jZQN5K3wboBlx8LW2jT%0AfQIDAQAB%0A-----END+PUBLIC+KEY-----%0A&authentication_method%5Bdata%5D%5Battributes%5D%5Bkind%5D=single_use&authentication_method%5Bdata%5D%5Battributes%5D%5Bname%5D=Segment+integration&authentication_method%5Bdata%5D%5Btype%5D=authentication_methods&data%5Battributes%5D%5Balgorithm%5D=RS256&data%5Battributes%5D%5Bkey%5D=-----BEGIN+PUBLIC+KEY-----%0AMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp%0AjVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64%2Blpo7KWqQIL28dhtNAjImJmzcr04ve%0ARAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe%0A7kPCK%2FNfdiOuFlMjfaY%2B5WmaA1lAZ%2FSSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC%0AIU%2FDO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj%2FIlJiC%0APDEoc1x7b4opEuGp287S%2BDsRRgr6vzVZi4CPQcJJsG%2B07jZQN5K3wboBlx8LW2jT%0AfQIDAQAB%0A-----END+PUBLIC+KEY-----%0A&data%5Battributes%5D%5Bkind%5D=single_use&data%5Battributes%5D%5Bname%5D=Segment+integration&data%5Btype%5D=authentication_methods&extra_fields%5Bauthentication_methods%5D=key&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    "id": "209a6455-d67d-4bec-b56f-9c0654264988",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-12-08T12:33:54+00:00",
      "updated_at": "2021-12-08T12:33:54+00:00",
      "name": "Segment integration",
      "key": "a9d506a447b3267d22192f314de807034a68c83be4c783e4a0a828ac2c74b074",
      "kind": "single_use",
      "algorithm": "HS256",
      "employee_id": "90e3057a-d742-4c97-82d1-5851f7b4af03",
      "company_id": "316fb17d-a87f-4dfb-9cd5-0e4daf982df0"
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
  "links": {
    "self": "api/boomerang/authentication_methods?authentication_method%5Bdata%5D%5Battributes%5D%5Balgorithm%5D=HS256&authentication_method%5Bdata%5D%5Battributes%5D%5Bkind%5D=single_use&authentication_method%5Bdata%5D%5Battributes%5D%5Bname%5D=Segment+integration&authentication_method%5Bdata%5D%5Btype%5D=authentication_methods&data%5Battributes%5D%5Balgorithm%5D=HS256&data%5Battributes%5D%5Bkind%5D=single_use&data%5Battributes%5D%5Bname%5D=Segment+integration&data%5Btype%5D=authentication_methods&extra_fields%5Bauthentication_methods%5D=key&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/authentication_methods?authentication_method%5Bdata%5D%5Battributes%5D%5Balgorithm%5D=HS256&authentication_method%5Bdata%5D%5Battributes%5D%5Bkind%5D=single_use&authentication_method%5Bdata%5D%5Battributes%5D%5Bname%5D=Segment+integration&authentication_method%5Bdata%5D%5Btype%5D=authentication_methods&data%5Battributes%5D%5Balgorithm%5D=HS256&data%5Battributes%5D%5Bkind%5D=single_use&data%5Battributes%5D%5Bname%5D=Segment+integration&data%5Btype%5D=authentication_methods&extra_fields%5Bauthentication_methods%5D=key&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/authentication_methods?authentication_method%5Bdata%5D%5Battributes%5D%5Balgorithm%5D=HS256&authentication_method%5Bdata%5D%5Battributes%5D%5Bkind%5D=single_use&authentication_method%5Bdata%5D%5Battributes%5D%5Bname%5D=Segment+integration&authentication_method%5Bdata%5D%5Btype%5D=authentication_methods&data%5Battributes%5D%5Balgorithm%5D=HS256&data%5Battributes%5D%5Bkind%5D=single_use&data%5Battributes%5D%5Bname%5D=Segment+integration&data%5Btype%5D=authentication_methods&extra_fields%5Bauthentication_methods%5D=key&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/dc39b2e2-a114-4b2b-bcc2-379ad7a71a9b' \
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
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
      "id": "076ab403-e912-4f2e-9592-14da7e1d04b6",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2021-11-24T18:21:00+00:00",
        "updated_at": "2021-11-24T18:21:00+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "employee_id": "8ff5d6e1-2387-4f7e-80ca-07586637c682",
        "company_id": "caa2e997-536b-4c54-b198-58b1a362df87"
      },
      "relationships": {
        "employee": {
          "links": {
            "related": "api/boomerang/employees/8ff5d6e1-2387-4f7e-80ca-07586637c682"
          }
        },
        "company": {
          "links": {
            "related": "api/boomerang/companies/caa2e997-536b-4c54-b198-58b1a362df87"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-24T18:20:55Z`
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/47cc12f1-2257-415e-a248-d72ddf548807' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "47cc12f1-2257-415e-a248-d72ddf548807",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-11-24T18:21:01+00:00",
      "updated_at": "2021-11-24T18:21:01+00:00",
      "name": "Segment integration",
      "key": "1dc16a44433cee457db38c474893e67dcaab0b0f7274e98525b91b5a8935d62f",
      "kind": "token",
      "algorithm": null,
      "employee_id": "82793a93-8855-4a50-8c72-87d342a3d584",
      "company_id": "bcbd34be-4fff-4fb7-a2c1-d34680d604a8"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/82793a93-8855-4a50-8c72-87d342a3d584"
        }
      },
      "company": {
        "links": {
          "related": "api/boomerang/companies/bcbd34be-4fff-4fb7-a2c1-d34680d604a8"
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
    "id": "b4feafa1-a1b1-4314-97fb-4b4d91e63ad0",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-11-24T18:21:02+00:00",
      "updated_at": "2021-11-24T18:21:02+00:00",
      "name": "Segment integration",
      "key": "f51b50a49c9b10a8cf0070598d7685cf77f1fab58ba467d0590e32fafcd1b323",
      "kind": "token",
      "algorithm": null,
      "employee_id": "dc78a852-ad13-4add-86e4-e15f88849dd2",
      "company_id": "e18f8ad2-705d-4567-9c4d-2f43fb77a0f6"
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
    "id": "ae097ab0-50fd-4ddf-bf11-b918b8ca1e92",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-11-24T18:21:02+00:00",
      "updated_at": "2021-11-24T18:21:02+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256",
      "employee_id": "47374dc3-100e-4ada-a101-2380cd0cb0f7",
      "company_id": "a879e7de-ef63-41aa-abdd-1892fa583a9f"
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
    "id": "c3b3ffbd-bc45-4e7f-a2e5-f1ec10ff013e",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-11-24T18:21:03+00:00",
      "updated_at": "2021-11-24T18:21:03+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256",
      "employee_id": "638226c4-df56-418a-b114-5d66be842cb3",
      "company_id": "0f1fe606-cf7c-4996-b960-31e009fac951"
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
    "id": "8808f496-d9fb-4316-84e2-4a2f03b448dd",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-11-24T18:21:04+00:00",
      "updated_at": "2021-11-24T18:21:04+00:00",
      "name": "Segment integration",
      "key": "9424a8de0e84c0b8b0600b5019f62478640a9122bb5825b34e4082c1e41dbf18",
      "kind": "single_use",
      "algorithm": "HS256",
      "employee_id": "b493b321-8e88-4f64-b25f-17ca59a0bcf1",
      "company_id": "d8dd2960-2ea6-4729-af8f-382b36a62a3b"
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/d2fdb62d-b5cf-4efb-8a35-a4bab181ce56' \
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
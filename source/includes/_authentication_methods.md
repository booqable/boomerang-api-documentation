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
      "id": "7212bbaf-076d-4e7f-8f9f-0ab5cf77fbf0",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2021-12-08T11:24:22+00:00",
        "updated_at": "2021-12-08T11:24:22+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "employee_id": "4be1547b-7da7-47e5-adf3-75d991fc82e1",
        "company_id": "ceb6d01d-59bb-4160-844b-e7bb229927b1"
      },
      "relationships": {
        "employee": {
          "links": {
            "related": "api/boomerang/employees/4be1547b-7da7-47e5-adf3-75d991fc82e1"
          }
        },
        "company": {
          "links": {
            "related": "api/boomerang/companies/ceb6d01d-59bb-4160-844b-e7bb229927b1"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T11:24:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/3073fe8d-77cb-40da-b108-7b21ebded66b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3073fe8d-77cb-40da-b108-7b21ebded66b",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-12-08T11:24:23+00:00",
      "updated_at": "2021-12-08T11:24:23+00:00",
      "name": "Segment integration",
      "key": "e3ca76a8a8b9b4d956fb5f42e43392572e83e9311d206e66461523246fd97ed6",
      "kind": "token",
      "algorithm": null,
      "employee_id": "63b7f210-57f5-4484-a783-16ebb50c24c7",
      "company_id": "9f060521-a2fe-4e44-8357-3c2298747b51"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/63b7f210-57f5-4484-a783-16ebb50c24c7"
        }
      },
      "company": {
        "links": {
          "related": "api/boomerang/companies/9f060521-a2fe-4e44-8357-3c2298747b51"
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
    "id": "6554216b-5275-4326-ba03-9759c3d57c0e",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-12-08T11:24:24+00:00",
      "updated_at": "2021-12-08T11:24:24+00:00",
      "name": "Segment integration",
      "key": "2259ea63f7131355dd8e8f11e8d103a5f2295c17a18f9f1e8f3e61f145bfd443",
      "kind": "token",
      "algorithm": null,
      "employee_id": "0dd6731f-72ed-43c0-8da3-a3c5856a4134",
      "company_id": "0a50419a-101a-40dd-86fe-39f80e7f4348"
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
    "id": "0c6dfec5-8ef9-4e2f-a2aa-a78b8898894f",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-12-08T11:24:25+00:00",
      "updated_at": "2021-12-08T11:24:25+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256",
      "employee_id": "513970b5-27f6-4014-a280-1e952b139cf1",
      "company_id": "d241e804-1de6-4868-a2b1-8fd850f4faa1"
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
    "id": "126d3266-b941-47ba-9cd1-5532acc6652a",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-12-08T11:24:26+00:00",
      "updated_at": "2021-12-08T11:24:26+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256",
      "employee_id": "6dad77d7-c22a-4652-898f-1bdc60ed4e76",
      "company_id": "156c4d9e-cc1b-4f8b-a35f-d273bae65525"
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
    "id": "45610138-5490-4b91-a6ed-12ab1d1e5133",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-12-08T11:24:28+00:00",
      "updated_at": "2021-12-08T11:24:28+00:00",
      "name": "Segment integration",
      "key": "fa15d791900432d86f361beb92cec4f4d9304005d80032fec4296e726f16c132",
      "kind": "single_use",
      "algorithm": "HS256",
      "employee_id": "d570a3da-44aa-4343-9b93-05969e6c5f13",
      "company_id": "0b30b0a0-641a-4511-ac02-c68a4918f313"
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/9201bbba-d5ee-41aa-af61-c14b17a6ec6a' \
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
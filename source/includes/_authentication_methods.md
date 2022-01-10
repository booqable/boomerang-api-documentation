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
      "id": "0e9fe103-af53-4f10-b2a3-83ea8723901c",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2022-01-10T13:49:56+00:00",
        "updated_at": "2022-01-10T13:49:56+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "employee_id": "1039803d-4bf3-48a2-bf9a-7d513f226535",
        "company_id": "0c1f7f6f-f826-4680-97ed-ab9b8dbad927"
      },
      "relationships": {
        "employee": {
          "links": {
            "related": "api/boomerang/employees/1039803d-4bf3-48a2-bf9a-7d513f226535"
          }
        },
        "company": {
          "links": {
            "related": "api/boomerang/companies/0c1f7f6f-f826-4680-97ed-ab9b8dbad927"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-10T13:49:50Z`
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/4a19ab60-8862-41c8-b0a6-462e484aefd2' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4a19ab60-8862-41c8-b0a6-462e484aefd2",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-01-10T13:49:58+00:00",
      "updated_at": "2022-01-10T13:49:58+00:00",
      "name": "Segment integration",
      "key": "1b8e94f7798d357c2d8c21c57f3cd6c599e1f3b4f82d30e10e3cb839420e3302",
      "kind": "token",
      "algorithm": null,
      "employee_id": "c4454f75-1cf7-4552-8573-4a14130fa8f5",
      "company_id": "8235a997-db89-4fa5-bc6a-0c1529a59c24"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/c4454f75-1cf7-4552-8573-4a14130fa8f5"
        }
      },
      "company": {
        "links": {
          "related": "api/boomerang/companies/8235a997-db89-4fa5-bc6a-0c1529a59c24"
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
    "id": "6ed7495c-388f-4e92-afd4-5060e289d037",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-01-10T13:50:00+00:00",
      "updated_at": "2022-01-10T13:50:00+00:00",
      "name": "Segment integration",
      "key": "df0820cf2634c52f5397bb881c7a328c44b345f1ed23e0c382595b793bab3794",
      "kind": "token",
      "algorithm": null,
      "employee_id": "e4ee3285-5a94-4cf2-998c-0703fbb9567f",
      "company_id": "8978a561-9783-42bd-a57f-999f3d0f2c2f"
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
    "id": "4ead36ea-ab2b-49f3-a1ef-1d6f4f4ff515",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-01-10T13:50:01+00:00",
      "updated_at": "2022-01-10T13:50:01+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256",
      "employee_id": "3df9c404-febb-4503-8486-8afe8f531549",
      "company_id": "5e8531f0-0680-431e-8ea5-e276c3b416df"
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
    "id": "a5b22d77-7f90-475d-b4b9-be5521d26df4",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-01-10T13:50:03+00:00",
      "updated_at": "2022-01-10T13:50:03+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256",
      "employee_id": "09ffa530-4c28-4d8a-b6a9-39a54688544f",
      "company_id": "dac5bb5b-f122-4c55-9210-049b7d5a8cdd"
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
    "id": "744f8050-e2c1-4f9d-9289-06edf146d315",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-01-10T13:50:04+00:00",
      "updated_at": "2022-01-10T13:50:04+00:00",
      "name": "Segment integration",
      "key": "0af684f10eb3a8e79084c1d1c437dd2d703ff2fb537ebefac28bc911cd9e2ce2",
      "kind": "single_use",
      "algorithm": "HS256",
      "employee_id": "772be67e-e0b2-4d43-b644-f6444720b1b6",
      "company_id": "0f266718-0f9e-4241-8b17-77760a399c38"
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/ce663e4b-f5cc-4671-92a9-a075aed4ce99' \
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
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
      "id": "8e40fbe1-282f-49a1-9b21-c0b1cb16346c",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2022-05-24T07:18:55+00:00",
        "updated_at": "2022-05-24T07:18:55+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "employee_id": "b6432592-90ff-4091-930f-e6c7ad229383",
        "company_id": "e8e24bb0-5ea5-41d1-8de9-515568501a55"
      },
      "relationships": {
        "employee": {
          "links": {
            "related": "api/boomerang/employees/b6432592-90ff-4091-930f-e6c7ad229383"
          }
        },
        "company": {
          "links": {
            "related": "api/boomerang/companies/e8e24bb0-5ea5-41d1-8de9-515568501a55"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-24T07:18:49Z`
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/ead13b08-e5b1-4803-8957-8ea72d977b15' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ead13b08-e5b1-4803-8957-8ea72d977b15",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-05-24T07:18:56+00:00",
      "updated_at": "2022-05-24T07:18:56+00:00",
      "name": "Segment integration",
      "key": "7ca34121c27d93f9f74e039cc334b87d58c16279bca31cb41517d09bdf5b6223",
      "kind": "token",
      "algorithm": null,
      "employee_id": "62fdec54-bd64-4e04-a78b-c6232f7fbf10",
      "company_id": "8eeebfee-f488-4b58-94b8-75fd780b4a69"
    },
    "relationships": {
      "employee": {
        "links": {
          "related": "api/boomerang/employees/62fdec54-bd64-4e04-a78b-c6232f7fbf10"
        }
      },
      "company": {
        "links": {
          "related": "api/boomerang/companies/8eeebfee-f488-4b58-94b8-75fd780b4a69"
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
    "id": "c09392ee-020f-474a-9c54-e76f2498ad0f",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-05-24T07:18:56+00:00",
      "updated_at": "2022-05-24T07:18:56+00:00",
      "name": "Segment integration",
      "key": "37c965c9aa8536f3150bb7e3ec04251f19f776e34b6d317c1b0cd0c51d81e93f",
      "kind": "token",
      "algorithm": null,
      "employee_id": "cc3024ed-2196-4029-a64a-5490b9e6460e",
      "company_id": "f4b20352-bc17-4f7b-9b8a-a7cee388bb60"
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
    "id": "431d385e-194d-4e7a-875b-8124a03c0964",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-05-24T07:18:57+00:00",
      "updated_at": "2022-05-24T07:18:57+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256",
      "employee_id": "d9485ba3-625d-4a97-bfec-e75fede0fd31",
      "company_id": "e5d78760-43c3-4d46-baea-9387bb916c85"
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
    "id": "bc516a05-1cca-4f25-b7c3-5b2faff6ed70",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-05-24T07:18:58+00:00",
      "updated_at": "2022-05-24T07:18:58+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256",
      "employee_id": "8130e86f-3130-4988-a0c8-07952d9d6291",
      "company_id": "93479242-7ea1-42b4-add5-1f4ab0b37f13"
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
    "id": "a0bf5ce9-9ac5-455d-83a9-7355b3c4f043",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2022-05-24T07:18:59+00:00",
      "updated_at": "2022-05-24T07:18:59+00:00",
      "name": "Segment integration",
      "key": "0f3d32a7b7033c1b07971a96dcbf5a674fe0d21f32963321edf61107572fc973",
      "kind": "single_use",
      "algorithm": "HS256",
      "employee_id": "036d3b14-f15b-4cb8-8707-a20828d2807c",
      "company_id": "5806dd01-808c-434b-9448-e949da5966c0"
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/962588cd-5294-465a-adcd-bb81643d2ac6' \
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
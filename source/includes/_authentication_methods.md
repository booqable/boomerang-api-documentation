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
`company` | **Companies** `readonly`<br>Associated Company
`employee` | **Employees** `readonly`<br>Associated Employee


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
      "id": "f6d420bf-65bc-4b9d-a698-be5fab9e0062",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2024-09-23T09:22:21.126590+00:00",
        "updated_at": "2024-09-23T09:22:21.126590+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "employee_id": "ab01f53f-e1ec-48ba-9c85-f76c9c29bac2",
        "company_id": "18cdaf36-4f4d-43b6-875b-df67a65a806a"
      },
      "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/e916ba2c-ee11-464c-aa6d-ed049815fa70' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e916ba2c-ee11-464c-aa6d-ed049815fa70",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-09-23T09:22:23.317907+00:00",
      "updated_at": "2024-09-23T09:22:23.317907+00:00",
      "name": "Segment integration",
      "key": "13e05dfac6a39a03ca8b267bc7a132bc97bfb67ad2fa02d64662938494076c71",
      "kind": "token",
      "algorithm": null,
      "employee_id": "8d12930a-3309-466c-9bea-b46f1a924619",
      "company_id": "e937ddb4-0324-46c1-bed6-61647b6c5df5"
    },
    "relationships": {}
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
    "id": "446d7bf0-bf50-4e96-a528-62434f17c3b8",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-09-23T09:22:24.298521+00:00",
      "updated_at": "2024-09-23T09:22:24.298521+00:00",
      "name": "Segment integration",
      "key": "5e6cf6798e9a2f4b4724195266a0db1f3a9c7df93e414a8283067011c789bae2",
      "kind": "token",
      "algorithm": null,
      "employee_id": "29cb9358-70c8-4540-9aa8-8beb761042a1",
      "company_id": "03a869eb-f302-4195-80f1-38014cd2f382"
    },
    "relationships": {}
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
    "id": "66cde7ab-bdd4-40a6-95da-605e7378ecf5",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-09-23T09:22:26.232087+00:00",
      "updated_at": "2024-09-23T09:22:26.232087+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256",
      "employee_id": "76fc59d2-0a24-4499-8ede-990deb656969",
      "company_id": "f2090cfe-bdcd-40b6-8a6d-1b865dfd6f14"
    },
    "relationships": {}
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
    "id": "9507c5b2-508c-40f2-8b93-7985394e07cb",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-09-23T09:22:27.233717+00:00",
      "updated_at": "2024-09-23T09:22:27.233717+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256",
      "employee_id": "bdd137bc-f877-4a93-bbb7-c4182cf1e4c1",
      "company_id": "201457ad-78fb-4269-b029-d409833cbe8a"
    },
    "relationships": {}
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
    "id": "8f4840f0-39a6-48bb-a807-3fe3f56a2a38",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-09-23T09:22:25.280420+00:00",
      "updated_at": "2024-09-23T09:22:25.280420+00:00",
      "name": "Segment integration",
      "key": "fcdc127b94b9f3b376534a14302dce0fac8f838dc3004030493eaddf5b82165b",
      "kind": "single_use",
      "algorithm": "HS256",
      "employee_id": "42ac4d77-ae86-440c-a4e1-bd5f68c42e04",
      "company_id": "9863727f-4fb4-47aa-ac6f-00cd7ddc494d"
    },
    "relationships": {}
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/74fdd630-86f1-4503-912e-f30b135412bc' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "74fdd630-86f1-4503-912e-f30b135412bc",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-09-23T09:22:22.338915+00:00",
      "updated_at": "2024-09-23T09:22:22.369380+00:00",
      "name": "Segment integration",
      "key": "3fe38fced15145239087ca1c8d8e7c6f944d092df615ff59d1a2cc1d984c6255",
      "kind": "token",
      "algorithm": null,
      "employee_id": "c9f39a4c-69ef-45d1-b9bf-50c5751728c1",
      "company_id": "ec0d145c-c5d9-4b02-b087-338e63490a70"
    },
    "relationships": {}
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
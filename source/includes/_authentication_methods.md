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
      "id": "7323d7d1-3a1f-4bf3-aa6a-9feb71867e73",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2024-09-16T09:25:56.153557+00:00",
        "updated_at": "2024-09-16T09:25:56.153557+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "employee_id": "651c35e1-f933-4140-a27f-bd0e8e2c1f3d",
        "company_id": "b2229261-ac33-4cea-82aa-7b7b5e85c608"
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/308bbc87-69bb-446d-a760-75db8c04799c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "308bbc87-69bb-446d-a760-75db8c04799c",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-09-16T09:25:58.082263+00:00",
      "updated_at": "2024-09-16T09:25:58.082263+00:00",
      "name": "Segment integration",
      "key": "70523a8b75a9061b81a0fbe9d383586f117cf5755a2b9914568f34e657ccbaa1",
      "kind": "token",
      "algorithm": null,
      "employee_id": "94668dd0-1d90-4f90-a548-75e15327c562",
      "company_id": "43bd2cb4-883f-465f-9f91-ed3a8efbf0b3"
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
    "id": "90dbcc9c-6fe8-48f0-a7d6-990ac682b02a",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-09-16T09:26:01.221583+00:00",
      "updated_at": "2024-09-16T09:26:01.221583+00:00",
      "name": "Segment integration",
      "key": "1205842ea93820c71b0abe8c1e7003842c59e5b50d512aefb951f34b9e7be63e",
      "kind": "token",
      "algorithm": null,
      "employee_id": "02c7cd07-318f-4864-8c0c-8567c37e8b5a",
      "company_id": "f40a57fa-5eae-4c4a-8213-29d529297a13"
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
    "id": "7e0d5437-29a6-4936-9fb1-c9e1d031e889",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-09-16T09:26:02.151987+00:00",
      "updated_at": "2024-09-16T09:26:02.151987+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256",
      "employee_id": "a411b097-2d7d-43e1-af44-36cd75c54e1e",
      "company_id": "5b025bbe-38f6-492f-a988-f4a4166e9749"
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
    "id": "91a16caf-0aa4-4ef5-a40b-5335ecd12785",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-09-16T09:25:59.105136+00:00",
      "updated_at": "2024-09-16T09:25:59.105136+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256",
      "employee_id": "4e9b1832-7e96-4422-adbe-e265468f25ab",
      "company_id": "c298c4b3-a386-4117-afca-8f72b28d2b05"
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
    "id": "849d6ff4-575c-4a80-ad4d-158944b50f34",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-09-16T09:26:00.093454+00:00",
      "updated_at": "2024-09-16T09:26:00.093454+00:00",
      "name": "Segment integration",
      "key": "459c900bca28999cd6178718d8d98d355b5619d0ac721a7c4d567228cc0c63a6",
      "kind": "single_use",
      "algorithm": "HS256",
      "employee_id": "42495d5d-f9eb-4f05-9ba8-b5f73268a9ce",
      "company_id": "47cf263f-b68d-4a5e-a15c-382dc567b881"
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/74be6df1-6581-4670-a475-8fb84037d263' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "74be6df1-6581-4670-a475-8fb84037d263",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-09-16T09:25:57.160636+00:00",
      "updated_at": "2024-09-16T09:25:57.195554+00:00",
      "name": "Segment integration",
      "key": "e24849df36195d1e2e4a62b26cebbd1af8e3900b41b7b697584aeaaa06e0953b",
      "kind": "token",
      "algorithm": null,
      "employee_id": "26d4435b-31a9-4190-bb24-9005658eed5c",
      "company_id": "3d3bda8e-9b4d-45ec-a64a-78d6582ef3a4"
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
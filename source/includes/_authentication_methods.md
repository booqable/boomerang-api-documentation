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
`employee_id` | **Uuid** `readonly`<br>Associated Employee
`company_id` | **Uuid** `readonly`<br>Associated Company
`key` | **String** <br>Key that is being used for authentication strategy


## Relationships
Authentication methods have the following relationships:

Name | Description
-- | --
`company` | **[Company](#companies)** <br>Associated Company
`employee` | **[Employee](#employees)** <br>Associated Employee


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
      "id": "2c5dc755-a49d-4152-bef5-71e025091ee1",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2024-12-02T13:03:22.882899+00:00",
        "updated_at": "2024-12-02T13:03:22.882899+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "employee_id": "2993c15c-fa26-4a4c-9787-dd1d91f8a01f",
        "company_id": "8d5eaa57-1698-4394-9272-317c43781d3e"
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/b812a928-a863-4ff4-917d-4fce92df3321' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b812a928-a863-4ff4-917d-4fce92df3321",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-12-02T13:03:25.324907+00:00",
      "updated_at": "2024-12-02T13:03:25.324907+00:00",
      "name": "Segment integration",
      "key": "f176d46a974748661f9215d20fbd395bfd25483c19b5087b7d6a1280c9ef73db",
      "kind": "token",
      "algorithm": null,
      "employee_id": "0bccccb4-3157-468a-b116-8ed4b05285ac",
      "company_id": "5697ef4c-beda-4371-8039-01e64f799aad"
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
    "id": "9e9c23d9-75b3-4e9c-ad5d-cd2eea6ea455",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-12-02T13:03:17.748568+00:00",
      "updated_at": "2024-12-02T13:03:17.748568+00:00",
      "name": "Segment integration",
      "key": "79d152a261f811b6a124e8529f170288cb41163b4ff849908db9fe4b2dfe4705",
      "kind": "token",
      "algorithm": null,
      "employee_id": "da90db0e-ceaa-41b7-96ba-6d3464438af5",
      "company_id": "23532fe7-4588-47d7-a706-04b03642f6ff"
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
    "id": "4185fbb1-5e4a-4682-9a41-b4640f65de64",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-12-02T13:03:21.912927+00:00",
      "updated_at": "2024-12-02T13:03:21.912927+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256",
      "employee_id": "933f255e-26d1-47b0-aaf6-1a41b45f90e0",
      "company_id": "8507c471-0497-47c2-9149-f78b34c74399"
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
    "id": "d3c4d27a-b224-4bda-bf31-8aa4a801fb25",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-12-02T13:03:18.861469+00:00",
      "updated_at": "2024-12-02T13:03:18.861469+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256",
      "employee_id": "940de7d8-da7f-4fbe-b48b-28ce233c3b89",
      "company_id": "ba236b58-5489-41cf-b97d-82fbbddeb595"
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
    "id": "33b2f944-092a-41dd-9e9e-d1bae1a60117",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-12-02T13:03:20.403142+00:00",
      "updated_at": "2024-12-02T13:03:20.403142+00:00",
      "name": "Segment integration",
      "key": "8adfffbfaeb1074c2fcd137fcce0b1c19d57dc5cafd904c546a9333e16275537",
      "kind": "single_use",
      "algorithm": "HS256",
      "employee_id": "c1a19a03-75b4-4704-a3ae-d7e9c2f3aaea",
      "company_id": "4c264d51-4864-4764-b61f-dd066bff34c0"
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/3bfef24a-595b-427e-8443-9ceaea6319bb' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3bfef24a-595b-427e-8443-9ceaea6319bb",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2024-12-02T13:03:24.112803+00:00",
      "updated_at": "2024-12-02T13:03:24.143460+00:00",
      "name": "Segment integration",
      "key": "797d19c2a61162a717f1afd35e53c1e42f0064594cde2fd8ff94d892e42064f3",
      "kind": "token",
      "algorithm": null,
      "employee_id": "5c4eea94-a377-4ce8-9099-ffb33fe99d62",
      "company_id": "24c1e188-6f97-470b-8076-858687490b88"
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
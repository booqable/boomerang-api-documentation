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
`key` | **String**<br>Key that is being used for authentication strategy


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
      "id": "504689e2-7013-4cea-9101-6f074f6f7f7d",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2021-11-15T07:45:30+00:00",
        "updated_at": "2021-11-15T07:45:30+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null
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
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[authentication_methods]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-15T07:45:25Z`
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
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/e72791e9-555e-432f-862b-6d488168b123' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e72791e9-555e-432f-862b-6d488168b123",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-11-15T07:45:32+00:00",
      "updated_at": "2021-11-15T07:45:32+00:00",
      "name": "Segment integration",
      "key": "5db6ec71f11320c362326adc0ba3aa94187ad8c837b77db27aa89c020ca68d78",
      "kind": "token",
      "algorithm": null
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
`include` | **String**<br>List of comma seperated relationships `?include=`
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
    "id": "bff08af4-c41c-4782-8a2d-c56956f30bf9",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-11-15T07:45:33+00:00",
      "updated_at": "2021-11-15T07:45:33+00:00",
      "name": "Segment integration",
      "key": "fe1d5e141c18298611e76ed69ad9f3392b5f96dff1aa3be89ef794a7231ecb7e",
      "kind": "token",
      "algorithm": null
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
    "id": "43d4d15b-e850-428a-b9d6-b4e897ac2459",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-11-15T07:45:34+00:00",
      "updated_at": "2021-11-15T07:45:34+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "ES256"
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
    "id": "7a86bf60-4176-47b0-979b-b3c6fed3fbb4",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-11-15T07:45:35+00:00",
      "updated_at": "2021-11-15T07:45:35+00:00",
      "name": "Segment integration",
      "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
      "kind": "single_use",
      "algorithm": "RS256"
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
    "id": "5a8748fd-40c6-4005-9d18-9b19962bf544",
    "type": "authentication_methods",
    "attributes": {
      "created_at": "2021-11-15T07:45:36+00:00",
      "updated_at": "2021-11-15T07:45:36+00:00",
      "name": "Segment integration",
      "key": "792622a1f6cbd2412f7775227bf18809bd8f551b1816dd80c920611362838464",
      "kind": "single_use",
      "algorithm": "HS256"
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
`include` | **String**<br>List of comma seperated relationships `?include=`
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

This request does not accept any includes
## Deleting an authentication method



> How to delete an authentication method:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/authentication_methods/b9c84923-d93c-4bff-8af0-de28124e811a' \
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
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[authentication_methods]=id,created_at,updated_at`


### Includes

This request does not accept any includes
# Authentication methods

Authentication methods define ways to authenticate with the API. They are always scoped to
the currently signed-in employee.

See [Authentication](#authentication) for more information on authenticating with the API.

## Relationships
Name | Description
-- | --
`company` | **[Company](#companies)** `required`<br>The company this authentication method belongs to. 
`employee` | **[Employee](#employees)** `required`<br>The employee this authentication method belongs to. 


Check matching attributes under [Fields](#authentication-methods-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`algorithm` | **enum** <br>Algorithm used for signing.<br> One of: `ES256`, `RS256`, `HS256`.
`company_id` | **uuid** `readonly`<br>The company this authentication method belongs to. 
`created_at` | **datetime** `readonly`<br>When this authentication method was created. 
`employee_id` | **uuid** `readonly`<br>The employee this authentication method belongs to. 
`id` | **uuid** `readonly`<br>Primary key.
`key` | **string** `extra`<br>Key that is being used for authentication strategy. Because this key is supposed to be kept secret (depending on `kind`), its value is only returned when explicitly requested. 
`kind` | **enum** <br>Kind of strategy used for authentication.<br> One of: `token`, `single_use`, `oauth`.
`name` | **string** <br>Name of the key (for identification by user). 


## List authentication methods


> How to fetch a list of authentication methods:

```shell
  curl --get 'https://example.booqable.com/api/4/authentication_methods'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "63e16d3e-a24d-4137-8fc5-dc94f18a5068",
        "type": "authentication_methods",
        "attributes": {
          "created_at": "2019-09-26T20:08:02.000000+00:00",
          "updated_at": "2019-09-26T20:08:02.000000+00:00",
          "name": "Segment integration",
          "kind": "single_use",
          "algorithm": "ES256",
          "employee_id": "ca0083cb-ea69-4e2b-8270-e691e0599f5e",
          "company_id": "b5c213f3-bf74-40ee-825d-3fd6219fc0a0"
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
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[authentication_methods]=key`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[authentication_methods]=created_at,name,kind`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`algorithm` | **enum** <br>`eq`
`company_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`employee_id` | **uuid** <br>`eq`, `not_eq`
`id` | **uuid** <br>`eq`, `not_eq`
`kind` | **enum** <br>`eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch an authentication method


> How to fetch an authentication method:

```shell
  curl --get 'https://example.booqable.com/api/4/authentication_methods/874482c4-c602-4605-8e8f-bdd68bc4e0fe'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "874482c4-c602-4605-8e8f-bdd68bc4e0fe",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2014-12-11T10:59:01.000000+00:00",
        "updated_at": "2014-12-11T10:59:01.000000+00:00",
        "name": "Segment integration",
        "kind": "single_use",
        "algorithm": "ES256",
        "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
        "employee_id": "24cc151b-daa4-48f0-8535-f63d7ec20fe7",
        "company_id": "84e60c43-023a-4c37-809c-a941cbac102a"
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
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[authentication_methods]=key`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[authentication_methods]=created_at,name,kind`


### Includes

This request does not accept any includes
## Create an authentication method


> How to create a token authentication method:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/authentication_methods'
       --header 'content-type: application/json'
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
      "id": "220c0989-a7b1-4962-884e-01ee74df46dc",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2027-11-18T02:17:01.000000+00:00",
        "updated_at": "2027-11-18T02:17:01.000000+00:00",
        "name": "Segment integration",
        "kind": "token",
        "algorithm": null,
        "key": "821465b1c39ad8d8584eee99c158868d986e7291281dfbedf3855cc9142c197a",
        "employee_id": "d6313cd4-52d0-4f71-87e9-0a5fbd855b19",
        "company_id": "d79aa57f-76cb-483a-8e40-c25404c26a5d"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> How to create a single_use authentication method (with ES256 strategy):

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/authentication_methods'
       --header 'content-type: application/json'
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
      "id": "e53a56a3-0f4e-4bd6-8bab-dad967b320b3",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2021-04-10T18:40:01.000000+00:00",
        "updated_at": "2021-04-10T18:40:01.000000+00:00",
        "name": "Segment integration",
        "kind": "single_use",
        "algorithm": "ES256",
        "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
        "employee_id": "75a59189-d0d6-4668-8c8b-83903cf22d08",
        "company_id": "031ece0d-d2c2-4b5a-86ac-e2eb24560de5"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> How to create a single_use authentication method (with RS256 strategy):

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/authentication_methods'
       --header 'content-type: application/json'
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
      "id": "f8a49c93-c272-4014-82f7-aaee9e656a32",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2014-10-08T04:38:01.000000+00:00",
        "updated_at": "2014-10-08T04:38:01.000000+00:00",
        "name": "Segment integration",
        "kind": "single_use",
        "algorithm": "RS256",
        "key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtRuZD4X3MhIz1ntbxpkp\njVFUTdH7mspUNXmE0bcQ3bJrgWYZmtPm64+lpo7KWqQIL28dhtNAjImJmzcr04ve\nRAxxyQT0f0uwe3zUBEqaxKim1aCJV60c71cPKJVfhXElnjhMkBW6ftIEgf7J4bwe\n7kPCK/NfdiOuFlMjfaY+5WmaA1lAZ/SSetwglSaHPPQKaix3LW4ocHtHUd7OBKNC\nIU/DO3baUDAkymF7ZCnMaf3F9Le9sGSpgUA8Fof69rH1EdagQFmIkftflj/IlJiC\nPDEoc1x7b4opEuGp287S+DsRRgr6vzVZi4CPQcJJsG+07jZQN5K3wboBlx8LW2jT\nfQIDAQAB\n-----END PUBLIC KEY-----\n",
        "employee_id": "bc3373ee-ee17-4d83-8c01-3b200bf8bdb3",
        "company_id": "faf47d6b-8d0b-4ac5-8892-c0590faa0054"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> How to create a single_use authentication method (with HS256 strategy):

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/authentication_methods'
       --header 'content-type: application/json'
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
      "id": "29c57921-3618-445f-89ac-84463b0ae952",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2028-10-03T00:29:01.000000+00:00",
        "updated_at": "2028-10-03T00:29:01.000000+00:00",
        "name": "Segment integration",
        "kind": "single_use",
        "algorithm": "HS256",
        "key": "cb991b0f11304f313a1487b2cb22a067eb4b03da8499bd2f833df79d83045110",
        "employee_id": "777ef44e-2bce-40e3-85dc-63792f9f0c22",
        "company_id": "61df6c42-088c-4fa3-8860-b75b9c114770"
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
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[authentication_methods]=key`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[authentication_methods]=created_at,name,kind`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=employee,company`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][algorithm]` | **enum** <br>Algorithm used for signing.<br> One of: `ES256`, `RS256`, `HS256`.
`data[attributes][key]` | **string** <br>Key that is being used for authentication strategy. Because this key is supposed to be kept secret (depending on `kind`), its value is only returned when explicitly requested. 
`data[attributes][kind]` | **enum** <br>Kind of strategy used for authentication.<br> One of: `token`, `single_use`, `oauth`.
`data[attributes][name]` | **string** <br>Name of the key (for identification by user). 


### Includes

This request accepts the following includes:

`employee`


`company`






## Delete an authentication method


> How to delete an authentication method:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/authentication_methods/ef2b6529-43ac-4e66-8ab9-bd2950729b50'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "ef2b6529-43ac-4e66-8ab9-bd2950729b50",
      "type": "authentication_methods",
      "attributes": {
        "created_at": "2021-11-06T06:35:01.000000+00:00",
        "updated_at": "2021-11-06T06:35:01.000000+00:00",
        "name": "Segment integration",
        "kind": "single_use",
        "algorithm": "ES256",
        "key": "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEEDRq3Sua6NyUU0WusNISEcchCLBL\nShY0rPpRLfU+Y96OcMiSWaKazYmQDKq4zyIVLlnGiHjv4lwEfhe3Psr39A==\n-----END PUBLIC KEY-----\n",
        "employee_id": "792a5596-9c55-46ab-8317-6c0651512e04",
        "company_id": "5da72e2c-3b67-4d80-88c1-6e96acba5c58"
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
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[authentication_methods]=key`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[authentication_methods]=created_at,name,kind`


### Includes

This request does not accept any includes
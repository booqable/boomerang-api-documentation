# Url redirects

URL redirects allow you to redirect visitors from one URL to another on your webshop.
This is useful when you rename pages, discontinue products, or restructure your site.

Each redirect is scoped to a company and the `from_path` must be unique within that company.
A single source path can only redirect to one destination.

## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`from_path` | **string** <br>The original URL path that should be redirected. Must be unique within the company.
`id` | **uuid** `readonly`<br>Primary key.
`to_path` | **string** <br>The destination URL path where visitors should be redirected to.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List url_redirects


> How to fetch a list of url_redirects:

```shell
  curl --get 'https://example.booqable.com/api/4/url_redirects'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "9362f528-4899-492f-81ef-c9598ff71e77",
        "type": "url_redirects",
        "attributes": {
          "created_at": "2024-06-24T21:08:01.000000+00:00",
          "updated_at": "2024-06-24T21:08:01.000000+00:00",
          "from_path": "/old-page",
          "to_path": "/new-page"
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/url_redirects`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[url_redirects]=created_at,updated_at,from_path`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`from_path` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`id` | **uuid** <br>`eq`, `not_eq`
`to_path` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch a url_redirect


> How to fetch a url_redirect:

```shell
  curl --get 'https://example.booqable.com/api/4/url_redirects/4761593f-f9b0-4c14-83dc-c7aad48d23cd'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "4761593f-f9b0-4c14-83dc-c7aad48d23cd",
      "type": "url_redirects",
      "attributes": {
        "created_at": "2024-03-08T09:30:00.000000+00:00",
        "updated_at": "2024-03-08T09:30:00.000000+00:00",
        "from_path": "/old-page",
        "to_path": "/new-page"
      }
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/url_redirects/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[url_redirects]=created_at,updated_at,from_path`


### Includes

This request does not accept any includes
## Create a url_redirect


> How to create a url_redirect:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/url_redirects'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "url_redirects",
           "attributes": {
             "from_path": "/products/old-product",
             "to_path": "/products/new-product"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "98cc0cdc-d5d2-4442-8859-cf23bded64b1",
      "type": "url_redirects",
      "attributes": {
        "created_at": "2025-06-17T01:05:00.000000+00:00",
        "updated_at": "2025-06-17T01:05:00.000000+00:00",
        "from_path": "/products/old-product",
        "to_path": "/products/new-product"
      }
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/url_redirects`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[url_redirects]=created_at,updated_at,from_path`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][from_path]` | **string** <br>The original URL path that should be redirected. Must be unique within the company.
`data[attributes][to_path]` | **string** <br>The destination URL path where visitors should be redirected to.


### Includes

This request does not accept any includes
## Update a url_redirect


> How to update a url_redirect:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/url_redirects/0edbfad6-31cf-4729-8534-02da1ae0fb92'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "0edbfad6-31cf-4729-8534-02da1ae0fb92",
           "type": "url_redirects",
           "attributes": {
             "to_path": "/updated-destination"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "0edbfad6-31cf-4729-8534-02da1ae0fb92",
      "type": "url_redirects",
      "attributes": {
        "created_at": "2027-04-21T03:25:01.000000+00:00",
        "updated_at": "2027-04-21T03:25:01.000000+00:00",
        "from_path": "/old-page",
        "to_path": "/updated-destination"
      }
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/url_redirects/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[url_redirects]=created_at,updated_at,from_path`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][from_path]` | **string** <br>The original URL path that should be redirected. Must be unique within the company.
`data[attributes][to_path]` | **string** <br>The destination URL path where visitors should be redirected to.


### Includes

This request does not accept any includes
## Destroy a url_redirect


> How to delete a url_redirect:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/url_redirects/1556c607-1a6e-4bc5-804a-fd235ed9e698'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "1556c607-1a6e-4bc5-804a-fd235ed9e698",
      "type": "url_redirects",
      "attributes": {
        "created_at": "2015-11-28T14:59:00.000000+00:00",
        "updated_at": "2015-11-28T14:59:00.000000+00:00",
        "from_path": "/old-page",
        "to_path": "/new-page"
      }
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/url_redirects/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[url_redirects]=created_at,updated_at,from_path`


### Includes

This request does not accept any includes
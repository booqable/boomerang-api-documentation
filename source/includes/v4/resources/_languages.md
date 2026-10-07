# Languages

Languages group the custom [Translations](#translations) that override Booqable's
built-in copy for a single locale.

A language is identified by its locale code (`identifier`). There can be only one
language per locale within a company, and only the locales Booqable ships store texts
for can be added. Publishing a language makes it available in the store. Removing a
language removes its custom translations with it; the default store language cannot
be removed.

## Relationships
Name | Description
-- | --
`translations` | **[Translations](#translations)** `hasmany`<br>The custom [Translations](#translations) belonging to this language. 


Check matching attributes under [Fields](#languages-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** `readonly-after-create`<br>The locale code of the language, one of the locales Booqable ships store texts for, for example `en` or `pt_BR`. Can only be set on create. 
`name` | **string** <br>The display name of the language. Defaults to the English name of the locale. 
`published` | **boolean** <br>Whether the language is available in the store. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List languages


> How to fetch a list of languages:

```shell
  curl --get 'https://example.booqable.com/api/4/languages'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "d237dff7-4ab8-4167-85da-338862a209ae",
        "type": "languages",
        "attributes": {
          "created_at": "2028-03-19T02:52:00.000000+00:00",
          "updated_at": "2028-03-19T02:52:00.000000+00:00",
          "identifier": "en",
          "name": "English",
          "published": false
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/languages`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[languages]=created_at,updated_at,identifier`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=translations`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`identifier` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`published` | **boolean** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>translations</code></li>
</ul>


## Fetch a language


> How to fetch a language with its custom translations:

```shell
  curl --get 'https://example.booqable.com/api/4/languages/4e0f3246-00ad-4449-8ba0-f86bce4f5c86'
       --header 'content-type: application/json'
       --data-urlencode 'include=translations'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "4e0f3246-00ad-4449-8ba0-f86bce4f5c86",
      "type": "languages",
      "attributes": {
        "created_at": "2022-06-17T04:06:04.000000+00:00",
        "updated_at": "2022-06-17T04:06:04.000000+00:00",
        "identifier": "en",
        "name": "English",
        "published": false
      },
      "relationships": {
        "translations": {
          "data": [
            {
              "type": "translations",
              "id": "c526b429-0f15-4fa4-891b-73b9a91de734"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "c526b429-0f15-4fa4-891b-73b9a91de734",
        "type": "translations",
        "attributes": {
          "created_at": "2022-06-17T04:06:04.000000+00:00",
          "updated_at": "2022-06-17T04:06:04.000000+00:00",
          "key": "document.date",
          "value": "Datum",
          "namespace": "user",
          "language_id": "4e0f3246-00ad-4449-8ba0-f86bce4f5c86"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/languages/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[languages]=created_at,updated_at,identifier`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=translations`


### Includes

This request accepts the following includes:

<ul>
  <li><code>translations</code></li>
</ul>


## Create a language


> How to add a language to the store:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/languages'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "languages",
           "attributes": {
             "identifier": "nl",
             "published": true
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "dd6ee5a1-d83d-4b21-881a-bc818b527823",
      "type": "languages",
      "attributes": {
        "created_at": "2014-05-14T01:55:05.000000+00:00",
        "updated_at": "2014-05-14T01:55:05.000000+00:00",
        "identifier": "nl",
        "name": "Dutch",
        "published": true
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/languages`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[languages]=created_at,updated_at,identifier`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=translations`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][identifier]` | **string** <br>The locale code of the language, one of the locales Booqable ships store texts for, for example `en` or `pt_BR`. Can only be set on create. 
`data[attributes][name]` | **string** <br>The display name of the language. Defaults to the English name of the locale. 
`data[attributes][published]` | **boolean** <br>Whether the language is available in the store. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>translations</code></li>
</ul>


## Update a language


> How to publish a language:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/languages/79c8dfc6-1edc-4335-8787-4149e74e092a'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "languages",
           "id": "79c8dfc6-1edc-4335-8787-4149e74e092a",
           "attributes": {
             "published": true
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "79c8dfc6-1edc-4335-8787-4149e74e092a",
      "type": "languages",
      "attributes": {
        "created_at": "2019-08-26T14:12:00.000000+00:00",
        "updated_at": "2019-08-26T14:12:00.000000+00:00",
        "identifier": "nl",
        "name": "Dutch",
        "published": true
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/languages/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[languages]=created_at,updated_at,identifier`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=translations`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][identifier]` | **string** <br>The locale code of the language, one of the locales Booqable ships store texts for, for example `en` or `pt_BR`. Can only be set on create. 
`data[attributes][name]` | **string** <br>The display name of the language. Defaults to the English name of the locale. 
`data[attributes][published]` | **boolean** <br>Whether the language is available in the store. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>translations</code></li>
</ul>


## Delete a language


> How to remove a language:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/languages/c2fb41a3-c650-4b23-8f35-cec39b4ef24c'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "c2fb41a3-c650-4b23-8f35-cec39b4ef24c",
      "type": "languages",
      "attributes": {
        "created_at": "2015-06-05T01:05:00.000000+00:00",
        "updated_at": "2015-06-05T01:05:00.000000+00:00",
        "identifier": "nl",
        "name": "Dutch",
        "published": false
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/languages/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[languages]=created_at,updated_at,identifier`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=translations`


### Includes

This request accepts the following includes:

<ul>
  <li><code>translations</code></li>
</ul>


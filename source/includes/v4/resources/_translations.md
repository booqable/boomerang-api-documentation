# Translations

Translations are custom overrides for Booqable's built-in copy. Each translation
belongs to a [Language](#languages) and is uniquely identified by its `key` and
`namespace` within that language.

Create a translation to override the default text for a key, update it to change the
override, and destroy it to fall back to the default text again.

## Relationships
Name | Description
-- | --
`language` | **[Language](#languages)** `required`<br>The [Language](#languages) this translation belongs to. Translations are always stored on the company's default language (`en`), which is created on first use. 


Check matching attributes under [Fields](#translations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`key` | **string** `readonly-after-create`<br>The dot-separated translation key that is overridden, for example `document.date`. Can only be set on create. 
`language_id` | **uuid** `readonly`<br>The [Language](#languages) this translation belongs to. Translations are always stored on the company's default language (`en`), which is created on first use. 
`namespace` | **string** `readonly-after-create`<br>The namespace the key lives in. Defaults to `user`. Can only be set on create. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`value` | **string** `nullable`<br>The custom text shown instead of the default translation. 


## List translations


> How to fetch a list of translations for a language:

```shell
  curl --get 'https://example.booqable.com/api/4/translations'
       --header 'content-type: application/json'
       --data-urlencode 'filter[language_id]=6729f5aa-0edd-4734-8fe8-bafaebd5272e'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "e9021ff1-437d-43f2-8bde-d1c2a3e7b9b9",
        "type": "translations",
        "attributes": {
          "created_at": "2026-02-16T15:28:00.000000+00:00",
          "updated_at": "2026-02-16T15:28:00.000000+00:00",
          "key": "document.date",
          "value": "Datum",
          "namespace": "user",
          "language_id": "6729f5aa-0edd-4734-8fe8-bafaebd5272e"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/translations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[translations]=created_at,updated_at,key`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=language`
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
`key` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`language_id` | **uuid** <br>`eq`, `not_eq`
`namespace` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`value` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>language</code></li>
</ul>


## Fetch a translation


> How to fetch a translation:

```shell
  curl --get 'https://example.booqable.com/api/4/translations/70fcff92-6fbd-4b4b-8a86-fb3809ee4b8a'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "70fcff92-6fbd-4b4b-8a86-fb3809ee4b8a",
      "type": "translations",
      "attributes": {
        "created_at": "2026-06-02T06:04:32.000000+00:00",
        "updated_at": "2026-06-02T06:04:32.000000+00:00",
        "key": "document.date",
        "value": "Datum",
        "namespace": "user",
        "language_id": "2b187c81-22c0-475e-80cf-722bc28bd134"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/translations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[translations]=created_at,updated_at,key`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=language`


### Includes

This request accepts the following includes:

<ul>
  <li><code>language</code></li>
</ul>


## Create a translation


> How to create a custom translation:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/translations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "translations",
           "attributes": {
             "key": "document.date",
             "namespace": "user",
             "value": "Datum"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "e0367ad0-6a2e-452f-8c2a-9d6deaaf7332",
      "type": "translations",
      "attributes": {
        "created_at": "2023-02-01T05:54:00.000000+00:00",
        "updated_at": "2023-02-01T05:54:00.000000+00:00",
        "key": "document.date",
        "value": "Datum",
        "namespace": "user",
        "language_id": "72dd2d6e-acd4-4e91-83eb-3b84f3c879a9"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/translations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[translations]=created_at,updated_at,key`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=language`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][key]` | **string** <br>The dot-separated translation key that is overridden, for example `document.date`. Can only be set on create. 
`data[attributes][namespace]` | **string** <br>The namespace the key lives in. Defaults to `user`. Can only be set on create. 
`data[attributes][value]` | **string** <br>The custom text shown instead of the default translation. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>language</code></li>
</ul>


## Update a translation


> How to update a custom translation:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/translations/69fe2570-6071-4bf2-852b-d011b951e340'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "translations",
           "id": "69fe2570-6071-4bf2-852b-d011b951e340",
           "attributes": {
             "value": "Verzenddatum"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "69fe2570-6071-4bf2-852b-d011b951e340",
      "type": "translations",
      "attributes": {
        "created_at": "2027-05-27T10:35:00.000000+00:00",
        "updated_at": "2027-05-27T10:35:00.000000+00:00",
        "key": "document.date",
        "value": "Verzenddatum",
        "namespace": "user",
        "language_id": "75b34be9-3d8e-4dae-8de7-e3d5b2ccf822"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/translations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[translations]=created_at,updated_at,key`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=language`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][key]` | **string** <br>The dot-separated translation key that is overridden, for example `document.date`. Can only be set on create. 
`data[attributes][namespace]` | **string** <br>The namespace the key lives in. Defaults to `user`. Can only be set on create. 
`data[attributes][value]` | **string** <br>The custom text shown instead of the default translation. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>language</code></li>
</ul>


## Delete a translation


> How to delete a custom translation:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/translations/2540687d-a4f3-436d-8519-f8f31020afa6'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "2540687d-a4f3-436d-8519-f8f31020afa6",
      "type": "translations",
      "attributes": {
        "created_at": "2019-02-16T23:02:02.000000+00:00",
        "updated_at": "2019-02-16T23:02:02.000000+00:00",
        "key": "document.date",
        "value": "Datum",
        "namespace": "user",
        "language_id": "43da6ff9-6d48-41d4-8278-0125813f2445"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/translations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[translations]=created_at,updated_at,key`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=language`


### Includes

This request accepts the following includes:

<ul>
  <li><code>language</code></li>
</ul>


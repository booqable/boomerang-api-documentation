# Languages

Languages hold the custom translations that override Booqable's built-in copy for a
single locale.
Custom translations are currently stored only against English, so the language always
resolves to `en`.

To change copy, update the language and pass `translations_attributes`. Each entry is
matched by its `key` and `namespace`: send a `value` to set or update the translation,
or send a blank `value` to reset that key back to the default.

## Relationships
Name | Description
-- | --
`translations` | **[Translations](#translations)** `hasmany`<br>The custom translations belonging to this language. 


Check matching attributes under [Fields](#languages-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** `readonly`<br>The locale code of the language, for example `en`. 
`name` | **string** `readonly`<br>The display name of the language. 
`translations_attributes` | **array** `writeonly`<br>Write-only. An array used to set, update, or remove custom translations in a single request. Each entry is matched by `key` and `namespace`: send a `value` to set or update it, or a blank `value` to reset that key back to the default. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Fetch the language


> How to fetch the language with its custom translations:

```shell
  curl --get 'https://example.booqable.com/api/4/language'
       --header 'content-type: application/json'
       --data-urlencode 'include=translations'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "4599065b-283d-4b2f-8620-361092d31a8b",
      "type": "languages",
      "attributes": {
        "created_at": "2015-01-19T16:15:01.000000+00:00",
        "updated_at": "2015-01-19T16:15:01.000000+00:00",
        "identifier": "en",
        "name": "En"
      },
      "relationships": {
        "translations": {
          "data": [
            {
              "type": "translations",
              "id": "47c30754-2e17-4759-8323-54e9fe558a89"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "47c30754-2e17-4759-8323-54e9fe558a89",
        "type": "translations",
        "attributes": {
          "created_at": "2015-01-19T16:15:01.000000+00:00",
          "updated_at": "2015-01-19T16:15:01.000000+00:00",
          "key": "document.date",
          "value": "Datum",
          "namespace": "user",
          "language_id": "4599065b-283d-4b2f-8620-361092d31a8b"
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


## Update the language


> How to add a custom translation:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/language'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "languages",
           "id": "en",
           "attributes": {
             "translations_attributes": [
               {
                 "key": "document.date",
                 "value": "Datum",
                 "namespace": "user"
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "f457c429-abc1-467f-8a99-a8f4c0248a2a",
      "type": "languages",
      "attributes": {
        "created_at": "2028-10-18T21:17:05.000000+00:00",
        "updated_at": "2028-10-18T21:17:05.000000+00:00",
        "identifier": "en",
        "name": "En"
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
`data[attributes][translations_attributes][]` | **array** <br>Write-only. An array used to set, update, or remove custom translations in a single request. Each entry is matched by `key` and `namespace`: send a `value` to set or update it, or a blank `value` to reset that key back to the default. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>translations</code></li>
</ul>


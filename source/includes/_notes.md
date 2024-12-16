# Notes

Allows you to leave notes attached to other resources.

## Relationships
Name | Description
-- | --
`employee` | **[Employee](#employees)** `required`<br>The employee who created this note.
`owner` | **[Customer](#customers), [Product](#products), [Product group](#product-groups), [Stock item](#stock-items), [Bundle](#bundles), [Order](#orders), [Document](#documents), [User](#users)** `required`<br>The resource this note is about.


Check matching attributes under [Fields](#notes-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`body` | **string** <br>The content of the note.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`employee_id` | **uuid** `readonly`<br>The employee who created this note.
`id` | **uuid** `readonly`<br>Primary key.
`owner_id` | **uuid** <br>The resource this note is about.
`owner_type` | **string** <br>The resource type of the owner.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Listing notes


> How to fetch a list of notes:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/notes'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "308f95f9-2661-4894-8d17-b4cf8fd661d2",
        "type": "notes",
        "attributes": {
          "created_at": "2022-10-23T23:24:01.000000+00:00",
          "updated_at": "2022-10-23T23:24:01.000000+00:00",
          "body": "Agreed to give this customer a 20% discount on the next order",
          "owner_id": "6e9725e6-9cd5-4743-8021-afe1b305c3f2",
          "owner_type": "customers",
          "employee_id": "4ef2de9b-a05c-49a2-8d8d-3690843a43a8"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/notes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[notes]=created_at,updated_at,body`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=employee,owner`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`employee_id` | **uuid** <br>`eq`, `not_eq`
`id` | **uuid** <br>`eq`, `not_eq`
`owner_id` | **uuid** <br>`eq`, `not_eq`
`owner_type` | **string** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`employee`


`owner`






## Fetching a note


> How to fetch a note:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/notes/629a61d1-1b50-41fd-867f-b7882b29d2f6'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "629a61d1-1b50-41fd-867f-b7882b29d2f6",
      "type": "notes",
      "attributes": {
        "created_at": "2028-07-04T15:39:01.000000+00:00",
        "updated_at": "2028-07-04T15:39:01.000000+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "8e17846d-a01b-4743-8d9b-a1ef2884c506",
        "owner_type": "customers",
        "employee_id": "e1d2d7e1-879d-4864-8f80-b42ba923ab58"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/notes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[notes]=created_at,updated_at,body`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=employee,owner`


### Includes

This request accepts the following includes:

`employee`


`owner`






## Creating a note


> How to create a note:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/notes'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "notes",
           "attributes": {
             "body": "Agreed to give this customer a 20% discount on the next order",
             "owner_id": "1a7b6819-6c11-4eee-892a-9d87bee21d50",
             "owner_type": "customers"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "40684345-0cb8-4a59-8dea-51468dffb879",
      "type": "notes",
      "attributes": {
        "created_at": "2020-07-03T13:01:01.000000+00:00",
        "updated_at": "2020-07-03T13:01:01.000000+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "1a7b6819-6c11-4eee-892a-9d87bee21d50",
        "owner_type": "customers",
        "employee_id": "1eb997c6-a419-482c-8414-606eef3b8f04"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/notes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[notes]=created_at,updated_at,body`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=employee,owner`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][body]` | **string** <br>The content of the note.
`data[attributes][owner_id]` | **uuid** <br>The resource this note is about.
`data[attributes][owner_type]` | **string** <br>The resource type of the owner.


### Includes

This request accepts the following includes:

`employee`


`owner`






## Deleting a note


> How to delete a note:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/notes/32ad49c4-5673-460c-84fd-a5852a0e4d35'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "32ad49c4-5673-460c-84fd-a5852a0e4d35",
      "type": "notes",
      "attributes": {
        "created_at": "2023-07-14T18:36:01.000000+00:00",
        "updated_at": "2023-07-14T18:36:01.000000+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "654e2ccf-f66b-4cd2-85d2-c446291c11a9",
        "owner_type": "customers",
        "employee_id": "45351704-f8df-4523-8ff0-d5d2b77ecaa4"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/boomerang/notes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[notes]=created_at,updated_at,body`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=employee,owner`


### Includes

This request accepts the following includes:

`employee`


`owner`






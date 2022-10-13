# Clusters

A cluster is a group of locations that share their inventory (and availability). Stock can move between locations within the same cluster, meaning they can be picked up at one location and returned to another.

## Endpoints
`GET /api/boomerang/clusters`

`GET /api/boomerang/clusters/{id}`

`POST /api/boomerang/clusters`

`PUT /api/boomerang/clusters/{id}`

`DELETE /api/boomerang/clusters/{id}`

## Fields
Every cluster has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>Name of the cluster
`location_ids` | **Array** <br>The locations that belong to this cluster


## Relationships
Clusters have the following relationships:

Name | Description
- | -
`locations` | **Locations** `readonly`<br>Associated Locations


## Listing clusters



> How to fetch clusters:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/clusters' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "731b09ad-5cca-4643-a567-3c49a9d8fb5c",
      "type": "clusters",
      "attributes": {
        "created_at": "2022-10-13T08:56:10+00:00",
        "updated_at": "2022-10-13T08:56:10+00:00",
        "name": "Main",
        "location_ids": []
      },
      "relationships": {
        "locations": {
          "links": {
            "related": "api/boomerang/locations?filter[cluster_id]=731b09ad-5cca-4643-a567-3c49a9d8fb5c"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/clusters`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[clusters]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T08:55:36Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`locations`






## Fetching a cluster



> How to fetch a single cluster:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/clusters/0a7b101c-6746-464e-a315-fc09a9147f72' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0a7b101c-6746-464e-a315-fc09a9147f72",
    "type": "clusters",
    "attributes": {
      "created_at": "2022-10-13T08:56:11+00:00",
      "updated_at": "2022-10-13T08:56:11+00:00",
      "name": "Main",
      "location_ids": []
    },
    "relationships": {
      "locations": {
        "links": {
          "related": "api/boomerang/locations?filter[cluster_id]=0a7b101c-6746-464e-a315-fc09a9147f72"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/clusters/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[clusters]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`locations`






## Creating a cluster



> How to create a cluster:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/clusters' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "clusters",
        "attributes": {
          "name": "Amsterdam"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2aa9ac4d-4b13-4b01-bc73-4bc67a40ff28",
    "type": "clusters",
    "attributes": {
      "created_at": "2022-10-13T08:56:11+00:00",
      "updated_at": "2022-10-13T08:56:11+00:00",
      "name": "Amsterdam",
      "location_ids": []
    },
    "relationships": {
      "locations": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/clusters`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[clusters]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String** <br>Name of the cluster
`data[attributes][location_ids][]` | **Array** <br>The locations that belong to this cluster


### Includes

This request accepts the following includes:

`locations`






## Updating a cluster



> How to update a cluster:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/clusters/962f75a6-7241-4317-9e34-183a5aee430a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "962f75a6-7241-4317-9e34-183a5aee430a",
        "type": "clusters",
        "attributes": {
          "name": "Rotterdam"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "962f75a6-7241-4317-9e34-183a5aee430a",
    "type": "clusters",
    "attributes": {
      "created_at": "2022-10-13T08:56:11+00:00",
      "updated_at": "2022-10-13T08:56:11+00:00",
      "name": "Rotterdam",
      "location_ids": []
    },
    "relationships": {
      "locations": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/clusters/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[clusters]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String** <br>Name of the cluster
`data[attributes][location_ids][]` | **Array** <br>The locations that belong to this cluster


### Includes

This request accepts the following includes:

`locations`






## Deleting a cluster

To delete a cluster make sure no active locations are associated with it anymore.


> How to delete a cluster:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/clusters/975bb3ef-1f5c-43c2-94d5-3e140563ff36' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```


> A failure due to a cluster still being assocatied with locations:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/clusters/66f9ceaa-9a14-46c9-858b-a05f74c683ab' \
    --header 'content-type: application/json' \
```

> A 422 status response looks like this:

```json
  {
  "errors": [
    {
      "code": "cluster_has_locations",
      "status": "422",
      "title": "Cluster has locations",
      "detail": "This cluster has 1 or more active locations",
      "meta": {
        "location_ids": [
          "2f9186d7-8a8b-42b1-af49-26f14a504809"
        ]
      }
    }
  ]
}
```

### HTTP Request

`DELETE /api/boomerang/clusters/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[clusters]=id,created_at,updated_at`


### Includes

This request does not accept any includes
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
      "id": "5a57a76a-5f4a-4076-8ebd-68d24c8620ec",
      "type": "clusters",
      "attributes": {
        "created_at": "2023-01-05T11:02:56+00:00",
        "updated_at": "2023-01-05T11:02:56+00:00",
        "name": "Main",
        "location_ids": []
      },
      "relationships": {
        "locations": {
          "links": {
            "related": "api/boomerang/locations?filter[cluster_id]=5a57a76a-5f4a-4076-8ebd-68d24c8620ec"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T11:02:34Z`
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
    --url 'https://example.booqable.com/api/boomerang/clusters/db9a401d-f942-4e0a-bf07-264f522309c8' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "db9a401d-f942-4e0a-bf07-264f522309c8",
    "type": "clusters",
    "attributes": {
      "created_at": "2023-01-05T11:02:57+00:00",
      "updated_at": "2023-01-05T11:02:57+00:00",
      "name": "Main",
      "location_ids": []
    },
    "relationships": {
      "locations": {
        "links": {
          "related": "api/boomerang/locations?filter[cluster_id]=db9a401d-f942-4e0a-bf07-264f522309c8"
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
    "id": "f57de594-bdb7-444a-a067-e6733f2ffb4f",
    "type": "clusters",
    "attributes": {
      "created_at": "2023-01-05T11:02:57+00:00",
      "updated_at": "2023-01-05T11:02:57+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/clusters/0bd70dda-640f-4e28-8e0a-7e256010efee' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0bd70dda-640f-4e28-8e0a-7e256010efee",
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
    "id": "0bd70dda-640f-4e28-8e0a-7e256010efee",
    "type": "clusters",
    "attributes": {
      "created_at": "2023-01-05T11:02:57+00:00",
      "updated_at": "2023-01-05T11:02:57+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/clusters/1ac8efc0-1999-4d24-b9ae-f871c20b06ff' \
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
    --url 'https://example.booqable.com/api/boomerang/clusters/214a2a6a-ddae-4250-a621-07961f338e11' \
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
          "5b6b82ba-46e3-4ad8-90c9-492994280836"
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
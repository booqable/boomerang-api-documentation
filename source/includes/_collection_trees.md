# Collection trees

Allows making multiple changes to the tree of collections at once.

## Fields

 Name | Description
-- | --
`collections` | **array** `writeonly`<br>Array of hashes, which each describe an update to make. 
`id` | **uuid** `readonly`<br>Primary key.


## Update the tree


> How to update the tree:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/collection_trees'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "collection_trees",
           "attributes": {
             "collections": [
               {
                 "id": "7ee0b635-bd10-4ade-835f-08e7a341e36d",
                 "parent_id": "786ce8ea-70d2-46b4-8a1c-f59a62784714",
                 "position": 3
               },
               {
                 "id": "be1d0d57-55e2-47ed-8bd9-7aef1ccdc47d",
                 "parent_id": "f773a180-793f-4c5e-8640-a794e8b7a3b9",
                 "position": 4
               }
             ]
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "4583bb5e-28c4-4e74-8610-06c05f98a464",
      "type": "collection_trees"
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/collection_trees`

### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][collections][]` | **array** <br>Array of hashes, which each describe an update to make. 


### Includes

This request does not accept any includes
# Currencies

The currency object encapsulates all information about a monetary unit.

## Endpoints
`GET /api/boomerang/currencies/{id}`

## Fields
Every currency has the following fields:

Name | Description
- | -
`id` | **String** `readonly`<br>The ISO code of the currency you want to fetch
`decimal_mark` | **String** `readonly`<br>Character between the whole and fraction amounts
`disambiguate_symbol` | **String** `readonly`<br>Alternative currency used if symbol is ambiguous
`html_entity` | **String** `readonly`<br>The html entity for the currency symbol
`iso_code` | **String** `readonly`<br>The international 3-letter code as defined by the ISO 4217 standard
`iso_numeric` | **String** `readonly`<br>The international 3-digit code as defined by the ISO 4217 standard
`name` | **String** `readonly`<br>The currency name
`priority` | **Integer** `readonly`<br>A numerical value you can use to sort/group the currency list
`smallest_denomination` | **Integer** `readonly`<br>Smallest amount of cash possible (in the subunit of this currency)
`subunit` | **String** `readonly`<br>The name of the fractional monetary unit
`subunit_to_unit` | **Integer** `readonly`<br>The proportion between the unit and the subunit
`symbol` | **String** `readonly`<br>The currency symbol (UTF-8 encoded)
`symbol_first` | **Boolean** `readonly`<br>States if the currency symbol should be shown before or after the moneyary value
`thousands_separator` | **String** `readonly`<br>Character between each thousands place


## Fetching a currency

> How to fetch a currency:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/currencies/eur' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eur",
    "type": "currencies",
    "attributes": {
      "decimal_mark": ",",
      "disambiguate_symbol": null,
      "html_entity": "&#x20AC;",
      "iso_code": "EUR",
      "iso_numeric": "978",
      "name": "Euro",
      "priority": 2,
      "smallest_denomination": 1,
      "subunit": "Cent",
      "subunit_to_unit": 100,
      "symbol": "€",
      "symbol_first": true,
      "thousands_separator": "."
    }
  },
  "meta": {}
}
```


### HTTP Request

`GET /api/boomerang/currencies/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[currencies]=id,created_at,updated_at`


### Includes

This request does not accept any includes
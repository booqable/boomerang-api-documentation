# Currencies

The currency object encapsulates all information about a monetary unit.

## Fields

 Name | Description
-- | --
`decimal_mark` | **string** `readonly`<br>Character between the whole and fraction amounts. 
`disambiguate_symbol` | **string** `readonly`<br>Alternative currency used if symbol is ambiguous. 
`exponent` | **integer** `readonly`<br>The number of digits after the decimal separator. 
`html_entity` | **string** `readonly`<br>The HTML entity for the currency symbol. 
`id` | **string** `readonly`<br>The ISO code of the currency you want to fetch. 
`iso_code` | **string** `readonly`<br>The international 3-letter code as defined by the ISO 4217 standard. 
`iso_numeric` | **string** `readonly`<br>The international 3-digit code as defined by the ISO 4217 standard. 
`name` | **string** `readonly`<br>The currency name. 
`priority` | **integer** `readonly`<br>A numerical value you can use to sort/group the currency list. 
`smallest_denomination` | **integer** `readonly`<br>Smallest amount of cash possible (in the subunit of this currency). 
`subunit` | **string** `readonly`<br>The name of the fractional monetary unit. 
`subunit_to_unit` | **integer** `readonly`<br>The proportion between the unit and the subunit. 
`symbol` | **string** `readonly`<br>The currency symbol (UTF-8 encoded). 
`symbol_first` | **boolean** `readonly`<br>States if the currency symbol should be shown before or after the monetary value. 
`thousands_separator` | **string** `readonly`<br>Character between each thousands place. 


## Fetch a currency


> How to fetch a currency:

```shell
  curl --get 'https://example.booqable.com/api/4/currencies/eur'
       --header 'content-type: application/json'
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
        "exponent": 2,
        "html_entity": "€",
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

`GET /api/4/currencies/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[currencies]=decimal_mark,disambiguate_symbol,exponent`


### Includes

This request does not accept any includes
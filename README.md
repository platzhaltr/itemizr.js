# README #

**itemizr** helps you to work with purchases such as line items on receipts in a natural ways by parsing it and giving you a json representation of it.

For example given `2kg Potatoes 7.59€ -7%` you get

	{
	   "quantity": 2,
	   "unit": "kg",
	   "description": "Potatoes",
	   "price": 7.59,
       "currency": "€",
	   "tax": -7
	}

## Development ##

You need

- [node.js](http://nodejs.org/)
- [npm](npmjs.org)
- [PEG.js](http://pegjs.majda.cz/)

To compile and make dist

	git clone git@github.com:platzhaltr/itemizr.git
	cd itemizr.git
	make

## Usage ##

	var core = require('../build/itemizr.core.js');
	var itemizrDefaults = {
		"defaults": {
			"quantity": 1
			"unit": "x"
			"currency": "€"
			"tax": "19"
		}
	}
	var i = new core.Itemizr(itemizrDefaults);

 	var item1 = i.parse("2kg Potatoes 7.59€")
 	var item2 = i.parse("1.5L Juice Off-Brand 12.45€")
 	var item3 = i.parse("200g Peanuts with chocolate 2.45$")
 	var item4 = i.parse("Bag of Chips 5.34€`")
 	var item5 = i.parse("Book with included tax 12.3 -7%")

### Parser ###

The parser understands statements like these

	[<quantity>[<unit>]] <description> <price>[<currency>] [<tax>]

- `quantity` Optional. Defaults to `defaults.quantity`.
- `unit` Optional. Depends on `quantity`. Right supported units are `g`, `lb`, `kg`, `m`, `ml`, `oz`, `l`, `h`, `min`, and `x`  (with `x` being a placeholder for number of items). Defaults to `defaults.unit`.
- `description` Required. Can be any character in `[a-zA-Z()äöüÄÖÜß"%&,.#+-=*]`.
- `price` Required. Decimal separator can be `.` or `,`. There is no support for a digit group separator (eg. no thousands separator).
- `currency` Optional. Can be any character in `[$€£¥]`. Defaults to `defaults.currency`.
- `tax` Optional. Can be `±x` with `x` being a decimal number (with  `.` or `,` separator). The idea is that that `+x`´ denotes that `x%` of vat must be added to the price and `-x` denotes that `x%` is already included in the price. Defaults to `defaults.tax`.

## Configuration ##

You can supply default values itemizr falls back onto.

You can change the following defaults

	"defaults": {
		"quantity": 1,
		"unit": "x",
		"currency": "€",
		"tax": "19"
	}

Constructor defaults

	var core = require('../build/itemizr.core.js');
	var i = new core.Itemizr({"defaults": {"quantity": 2, "unit": "kg" }});

Method defaults

	var core = require('../build/itemizr.core.js');
	var i = new core.Itemizr();
	i.parse("<input>", {"defaults": {"quantity": 2, "unit": "kg"}}),

You can combine constructor and method defaults. Method defaults override constructor defaults.

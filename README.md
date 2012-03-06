# README #

**Natural Purchase Parsing**

## Why ##


## Development ##

Man benötigt

- [node.js](http://nodejs.org/)
- [npm](npmjs.org)
- [PEG.js](http://pegjs.majda.cz/)

Zum kompilieren

	git clone git@github.com:platzhaltr/itemizr.git
	cd itemizr.git
	make

## Usage ##

### Purchases ###

The parser understands the following statements like these

- `[<quantity><unit>] <description> <price><currency> [<tax>]`

- `2kg Potatoes 7.59€`
- `1.5L Juice Off-Brand 12.45€`
- 200g Peanuts with chocolate 2.45$
- Bag of Chips 5.34€
- Book with included tax 12.3 -7%

## Konfiguration ##

The parser can return a *fuzzy* time field `time`. The configuration maps these to specific times:

	"times": {
		"morning": "9:00"
		"noon": "12:00"
		"afternoon": "15:00"
		"evening": "19:00"
		"night": "23:00"
	}

## Funktion ##

The parser build an object like this

	{
	   "amount": 2,
	   "unit": "kg",
	   "description": "Nüsse",
	   "price": 3.59,
	   "tax": 7
	}

- where `x,y ∈ ℕ`
- not all fields are filled
- fields with suffix `s` are for relative data/time information
- the others are for absolute data/time information
- relative and absolute fields can be mixed


## Problems ##

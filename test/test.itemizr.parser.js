var parser = require('../build/itemizr.parser.js');

exports.test = function (test) {
    test.expect(7);

	test.deepEqual(
		parser.parse("2kg Potatoes 7.59\u20AC"),
		{ "quantity": 2, "unit": "kg", "description": "Potatoes", "price": 7.59, "currency": "\u20AC"},
		"Potatoes"
	);
	
	test.deepEqual(
		parser.parse("1.5L Juice Off-Brand 12.45$"),
		{ "quantity": 1.5, "unit": "l", "description": "Juice Off-Brand", "price": 12.45, "currency": "$"},
		"Juice Off-Brand"
	);
	
	test.deepEqual(
		parser.parse("200g Peanuts with chocolate 2.45$"),
		{ "quantity": 200, "unit": "g", "description": "Peanuts with chocolate", "price": 2.45, "currency": "$"},
		"Peanuts with chocolate"
	);
	
	test.deepEqual(
		parser.parse("Bag of Chips 5.34\u20AC"),
		{ "description": "Bag of Chips", "price": 5.34, "currency": "\u20AC"},
		"Bag of Chips"
	);

	test.deepEqual(
		parser.parse("Book with included tax 12.34\u20AC -7%"),
		{ "description": "Book with included tax", "price": 12.34, "currency": "\u20AC", "tax": -7},
		"Book with included tax"
	);

	test.deepEqual(
		parser.parse("5h Computer Technician Service 600.80\u20AC +19%"),
		{ "quantity": 5, "unit": "h", "description": "Computer Technician Service", "price": 600.8, "currency": "\u20AC", "tax": 19},
		"Computer Technician Service"
	);
	
	test.deepEqual(
		parser.parse("20min Massage 30\u20AC -19%"),
		{ "quantity": 20, "unit": "min", "description": "Massage", "price": 30, "currency": "\u20AC", "tax": -19},
		"Massage"
	);

    test.done();
};
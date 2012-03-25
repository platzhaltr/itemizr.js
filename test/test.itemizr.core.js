var core = require('../build/itemizr.core.js');

exports.testNoDefaults = function (test) {
	var i = new core.Itemizr();
    test.expect(1);

	test.deepEqual(
		i.parse("Potatoes 7.59\u20AC"),
		{ "description": "Potatoes", "price": 7.59, "currency": "\u20AC"},
		"Potatoes"
	);

    test.done();
};

exports.testConstructorDefaults = function (test) {
	var i = new core.Itemizr({"defaults": {"quantity": 2, "unit": "kg" }});
	test.expect(1);

	test.deepEqual(
		i.parse("Potatoes 7.59\u20AC"),
		{ "quantity": 2, "unit": "kg", "description": "Potatoes", "price": 7.59, "currency": "\u20AC"},
		"Potatoes"
	);

    test.done();
};

exports.testMethodDefaults = function (test) {
    var i = new core.Itemizr();
    test.expect(1);

	test.deepEqual(
		i.parse("Potatoes 7.59\u20AC", {"defaults": {"quantity": 2, "unit": "kg" }}),
		{ "quantity": 2, "unit": "kg", "description": "Potatoes", "price": 7.59, "currency": "\u20AC"},
		"Potatoes"
	);

    test.done();
};

exports.testOverrideConstructorDefaults = function (test) {
	var i = new core.Itemizr({"defaults": {"quantity": 2, "unit": "kg" }});
	test.expect(1);

	test.deepEqual(
		i.parse("Potatoes 7.59\u20AC", {"defaults": {"quantity": 400, "unit": "g" }}),
		{ "quantity": 400, "unit": "g", "description": "Potatoes", "price": 7.59, "currency": "\u20AC"},
		"Potatoes"
	);

    test.done();
};
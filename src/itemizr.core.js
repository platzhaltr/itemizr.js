var parser = require('./itemizr.parser.js');

/*
 * Itemizr Core Module
 * Copyright (C) 2012 Oliver Schrenk <oliver.schrenk@gmail.com>
 */
(function (exports) {
	'use strict';

	var config = {};

	function Itemizr(defaults) {
		config.defaults = defaults;
	}

	/*
	*/
	Itemizr.prototype.get = function (lineitem, defaults) {
		if (defaults !== undefined) {
		
			if (lineitem.quantity === undefined && defaults.quantity !== undefined) {
				lineitem.quantity = defaults.quantity;
			}
			
			if (lineitem.unit === undefined && defaults.unit !== undefined) {
				lineitem.unit = defaults.unit;
			}
			
			if (lineitem.currency === undefined && defaults.currency !== undefined) {
				lineitem.currency = defaults.currency;
			}
			
			if (lineitem.tax === undefined && defaults.tax !== undefined) {
				lineitem.tax = defaults.tax;
			}
		}

		return lineitem;
	};

	Itemizr.prototype.parse =  function (input, defaults) {
		defaults = defaults !== undefined ? defaults : config.defaults;
		return this.get(parser.parse(input), defaults !== undefined ? defaults.defaults : defaults);
	};

	// expose it
	exports.Itemizr = Itemizr;

}(this));
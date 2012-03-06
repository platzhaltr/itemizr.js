{
function merge(obj1,obj2){
    var obj3 = {};
    for (var attrname in obj1) { obj3[attrname] = obj1[attrname]; }
    for (var attrname in obj2) { obj3[attrname] = obj2[attrname]; }
    return obj3;
}

function getDescription(globalItem, price) {
  globalItem.description = globalItem.description.substring(0,  globalItem.description.lastIndexOf(price.price)-1);
  return merge(globalItem, price);
}

var globalItem = {};
globalItem.description = "";
}

start
  = item:quantizedItem SPACE t:tax 		{return merge(item, {"tax": t})}
  / item:quantizedItem 					{return item;}
  / item:item SPACE t:tax 				{return merge(item, {"tax": t})}
  / item:item 							{return item;}

quantizedItem
  = quantity:quantity SPACE item:item 	{return merge (quantity, item);}

quantity
  = amount:DecimalLiteral unit:unit 	{return {"amount": amount, "unit": unit}}
  / amount:DecimalLiteral 				{return {"amount": amount}}

unit
  = symbol:[gG][rR][aA][mM][mM]? 		{return 'g';}
  / symbol:[gG][rR] 					{return 'g';}
  / symbol:[gG] 						{return 'g';}
  / symbol:[lL]							{return 'l';}
  / symbol:[xX] 						{return 'x';}
  / symbol:[kK][gG] 					{return "kg";}
  / symbol:[sS][tT][.]? 				{return "x";}

item
  = word:word space:SPACE sub:item ! (SPACE price:price EOF) {return getDescription(globalItem, sub)}
  / price:price {return price;}
  
word
  = chars:[a-zA-Z0-9()äöüÄÖÜß"%&,.#+-=*]+ 			{globalItem.description = globalItem.description + chars.join("")+ ' '; return ""; }

price
  = price:DecimalLiteral currency:currency 			{return {"price": price, "currency": currency}}
  / price:DecimalLiteral  							{ return {"price": price} }

tax
  = pm:PLUS_MINUS? t:DecimalLiteral PERCENT? 		{return parseFloat(pm + t)}

DecimalLiteral
  = b:DecimalIntegerLiteral s:SEP a:DecimalDigits? 	{return parseFloat(b + s + a); }
  / SEP a:DecimalDigits 							{return parseFloat(SEP + a);}
  / b:DecimalIntegerLiteral 						{return parseFloat(b); }

DecimalIntegerLiteral
  = ZERO / digit:NonZeroDigit digits:DecimalDigits?	{ return digit + digits; }

DecimalIntegerLiteral
  = ZERO / digit:NonZeroDigit digits:DecimalDigits?	{ return digit + digits; }

DecimalDigits
  = digits:DecimalDigit+ 							{ return digits.join(""); }

DecimalDigit
  = [0-9]

NonZeroDigit
  = [1-9]

currency
  = [$€]

PLUS_MINUS
  = PLUS
  / MINUS

PLUS
  = '+' {return ""}

MINUS
  = '-' 

PERCENT
  = '%'

SPACE
  = ' '

ZERO
  = '0'

SEP
  = '.'

EOF
  = !.
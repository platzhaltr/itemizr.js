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
  = q:DecimalLiteral u:unit 			{return {"quantity": q, "unit": u}}
  / q:DecimalLiteral 					{return {"quantity": q}}

unit
  = weight
  / length
  / volume
  / number
  / time

weight
  = [Gg][Rr][Aa][Mm][Mm]? 		{return 'g';}
  / [Gg][Rr] 					{return 'g';}
  / [Gg] 						{return 'g';}
  / [Ll][Bb]					{return 'lb';}
  / [Kk][Gg] 					{return "kg";}

/* Guard against min */
length
  = [Mm]!([Ii])[Mm]				{return 'mm';}
  / [Cc][Mm]					{return 'cm';}
  / [Mm]!([Ii])					{return 'm';}

volume
  = [Mm][Ll]					{return 'ml';}
  / [Ll]						{return 'l';}
  / [Oo][Zz]					{return 'oz';}

time
  = [Mm][Ii][Nn]				{return 'min';}
  / [Hh]						{return 'h';}

number
  = [xX] 						{return 'x';}
  / [sS][tT][.]? 				{return "x";}

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
  = [$€£¥]

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

DOT
  = '.'

COMMA
  = ','

ZERO
  = '0'

SEP
  = DOT		{return "."}
  / COMMA 	{return "."}

EOF
  = !.
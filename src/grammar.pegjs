{ function merge(o1,o2){
    for (var attrname in o2) { o1[attrname] = o2[attrname]}
    return o1;
} }

start
  = i:quantizedItem SPACES t:tax  {return merge(i, {"tax": t})}
  / i:quantizedItem               {return i}
  / i:item SPACES t:tax           {return merge(i, {"tax": t})}
  / i:item                        {return i}

quantizedItem
  = q:quantity SPACES i:item      {return merge(q, i)}

quantity
  = q:DecimalLiteral u:unit       {return {"quantity": q, "unit": u}}
  / q:DecimalLiteral              {return {"quantity": q}}

item
  = d:description SPACES p:price  {return merge({"description": d}, p)}

description
  = s:(sentence) {return s}

sentence
  = w:word ! (SPACES p:price) SPACES s:sentence  ! (p:price)  {return w + " " + s}
  / w:word ! (p:price)                                        {return w}

part
  = SPACES w:word   {return w}

word
  = c:[a-zA-Z()äöüÄÖÜß"%&,;.#+-=*]+    {return c.join("")}

price
  = p:DecimalLiteral c:currency       {return {"price": p, "currency": c}}
  / p:DecimalLiteral                  {return {"price": p}}

tax
  = pm:PLUS_MINUS? t:DecimalLiteral PERCENT?    {return parseFloat(pm+t)}

DecimalLiteral
  = b:DecimalIntegerLiteral s:SEP a:DecimalDigits?  {return parseFloat(b+s+a)}
  / SEP a:DecimalDigits                             {return parseFloat(SEP + a)}
  / b:DecimalIntegerLiteral                         {return parseFloat(b)}

DecimalIntegerLiteral
  = ZERO / d:NonZeroDigit ds:DecimalDigits?         {return d + ((!ds) ? "" : ds)}


DecimalDigits
  = d:DecimalDigit+                                 {return d.join("")}

DecimalDigit
  = [0-9]

NonZeroDigit
  = [1-9]

unit
  = weight
  / length
  / volume
  / number
  / time

weight
  = [Gg][Rr][Aa][Mm][Mm]?       {return 'g'}
  / [Gg][Rr]                    {return 'g'}
  / [Gg]                        {return 'g'}
  / [Ll][Bb]                    {return 'lb'}
  / [Kk][Gg]                    {return "kg"}

/* Guard against min */
length
  = [Mm]!([Ii])[Mm]             {return 'mm'}
  / [Cc][Mm]                    {return 'cm'}
  / [Mm]!([Ii])                 {return 'm'}

volume
  = [Mm][Ll]                    {return 'ml'}
  / [Ll]                        {return 'l'}
  / [Oo][Zz]                    {return 'oz'}

time
  = [Mm][Ii][Nn]                {return 'min'}
  / [Hh]                        {return 'h'}

number
  = [xX]                        {return 'x'}
  / [sS][tT][.]?                {return "x"}

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

SPACES
  = ' '+

DOT
  = '.'

COMMA
  = ','

ZERO
  = '0'

SEP
  = DOT    {return "."}
  / COMMA  {return "."}

EOF
  = !.

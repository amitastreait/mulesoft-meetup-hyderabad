%dw 2.0
output application/xml

import dw::core::Strings
import camelize, capitalize from dw::core::Strings
import * from dw::core::Strings

var myvar = "amit singh"

var toUpper = (aString) -> 
	if(aString=="Hot")
		"too hot"
	else
		"too Cold"
		
fun capit(rating:String) = 
	if(rating == "Hot")
		"Amit"
	else 
		"Singh"
	
---

accounts : {
	(payload map () ->{
		account @(name : $.Name) : $.Description,
		Phone : $.Phone,
		name : toUpper(myvar),
		name : capit(myvar)
	})
}
/*
accounts_1 : {
		(payload map () ->{
			accounts : {
				account : $
			}	
		})
	} */
	
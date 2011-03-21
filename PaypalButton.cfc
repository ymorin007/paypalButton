<cfcomponent output="false" mixin="controller">

	<cffunction name="init">
		<cfset this.version = "1.1">
		<cfreturn this>
	</cffunction>

	<cffunction name="showPaypalButton" hint="Display a PayPal Button using the PayPal API">

		<cfargument name="type" type="string" required="false" default="_xclick"
					hint="Choose a button type. Options available are (_cart, _xclick, _donations, _oe-gift-certificate, _xclick-subscriptions).  More detail are available on the index.cfm.">

		<cfargument name="cart" type="string" required="false" default="add"
					hint="For shopping cart purchases only; these additional variables specify the kind of shopping cart button or command: add – Add to Cart buttons, display – View Cart buttons, upload – The Cart Upload command ">

		<cfargument name="shoppingUrl" type="string" required="false" default=""
					hint="Enter the URL where recipients can shop and redeem this gift certificate.">

		<cfargument name="environment" type="string" required="false" default="testing"
					hint="What environment you want to use? Choose between testing and production.">

		<cfargument name="environmentActive" type="boolean" required="false" default="0"
					hint="You can let your active environment setting manage witch environment to use.">

		<cfargument name="business" type="string" required="true"
					hint="Your PayPal ID or an email address associated with your PayPal account to receive payments. Email addresses must be confirmed. ">

		<cfargument name="lc" type="string" required="false" default="US"
					hint="Sets the payer's language for the billing information/log-in page only. For allowable values, see https://cms.paypal.com/us/cgi-bin/?&cmd=_render-content&content_ID=developer/e_howto_api_nvp_country_codes.">

		<cfargument name="amount" type="string" required="false"
					hint="The price or amount of the product, service, or contribution, not including shipping, handling, or tax. More detail are available on the index.cfm.">

		<cfargument name="taxRate" type="string" required="false"
					hint="Transaction-based tax override variable. Set this to a percentage that will be applied to amount multiplied the quantity selected during checkout. This value overrides any tax settings set in your account profile. Allowable values are numbers 0.001 through 100. Valid only for Buy Now and Add to Cart buttons. ">

		<cfargument name="quantity" type="numeric" required="false"
					hint="Number of items.">

		<cfargument name="shipping" type="string" required="false"
					hint="The cost of shipping this item.">

		<cfargument name="currency" type="string" required="false" default="USD"
					hint="The currency of the payment. For allowable values, see https://cms.paypal.com/us/cgi-bin/?&cmd=_render-content&content_ID=developer/e_howto_api_nvp_currency_codes">

		<cfargument name="noNote" type="boolean" required="false" default="1"
					hint="Do not prompt payers to include a note with their payments">

		<cfargument name="itemName" type="string" required="false"
					hint="Description of item.">

		<cfargument name="itemNumber" type="string" required="false"
					hint="Pass-through variable for you to track product or service purchased or the contribution made. The value you specify passed back to you upon payment completion.">

		<cfargument name="showCreditCard" type="boolean" required="false" default="1"
					hint="Display credit card logos under the submit button">

		<cfargument name="lang" type="string" required="false" default="en"
					hint="Language for the submit button. Options available are (en, fr, es, de, nl, zh, ja, pt).  More detail are available on the index.cfm.">

		<cfargument name="headerImage" type="string" required="false"
					hint="The image at the top left of the checkout page. The image’s maximum size is 750 pixels wide by 90 pixels high. PayPal recommends that you provide an image that is stored only on a secure (https) server. More detail are available on the index.cfm.">

		<cfargument name="return" type="string" required="false"
					hint="The URL to which the payer’s browser is redirected after completing the payment; for example, a URL on your site that displays a 'Thank you for your payment' page.">

		<cfargument name="notifyUrl" type="string" required="false"
					hint="The URL to which PayPal posts information about the transaction, in the form of Instant Payment Notification messages.">

		<cfargument name="cancelReturn" type="string" required="false"
					hint="A URL to which the payer’s browser is redirected if payment is cancelled; for example, a URL on your website that displays a “Payment Canceled” page.">

		<cfargument name="cbt" type="string" required="false"
					hint="Sets the text for the Return to Merchant button on the PayPal Payment Complete page. For Business accounts, the return button displays your business name in place of the word “Merchant” by default. For Donate buttons, the text reads “Return to donations coordinator” by default.">

		<cfargument name="custom" type="string" required="false"
					hint="Custom value as passed by you, the merchant. These are pass-through variables that are never presented to your customer. Length: 255 characters.">

		<cfargument name="firstName" type="string" required="false"
					hint="first name of payer">

		<cfargument name="lastName" type="string" required="false"
					hint="last name of payer">

		<cfargument name="a3" type="string" required="false"
					hint="Regular subscription price.">

		<cfargument name="p3" type="string" required="false"
					hint="Subscription duration. Specify an integer value in the allowable range for the units of duration that you specify with t3. ">

		<cfargument name="t3" type="string" required="false"
					hint="Regular subscription units of duration. Allowable values:D – for days; allowable range for p3 is 1 to 90,W – for weeks; allowable range for p3 is 1 to 52,M – for months; allowable range for p3 is 1 to 24,Y – for years; allowable range for p3 is 1 to 5">

		<cfargument name="buttonImage" type="string" required="false"
					hint="Use custom button images that match the look of your website. Enter the url for the image.">

		<cfargument name="sameWindow" type="boolean" required="false" default="1"
					hint="Target the click event to open on the same window. If false it PayPal will open in a new window.">

		<cfargument name="debug" type="boolean" required="false" default="0"
					hint="The debug will show you what to do if you miss some of the specific parameter requirements. Since some parameter only applies to some type of button. Try it you will see what I mean it won't hurt.">

		<cfargument name="onLoadSubmit" type="boolean" required="false" default="0" 
				   	hint="Should it submit onLoad or not?">

		<cfargument name="onLoadSubmitMessage" type="string" required="false" default="<p>You Are Being Automatically Redirected to PayPal</p>" 
				   	hint="Message to appear if you use the onLoadSubmit">

		<cfset var loc = {}>

		<cfset loc.submitImage = "">
		<cfset loc.imageSource = "">
		<cfset loc.langButtonDir = arguments.lang>
		<cfset loc.showCreditCard = "CC"><!--- By Default we are showing the credit card logo on the submit button --->
		<cfset loc.environment = "https://www.sandbox.paypal.com/cgi-bin/webscr"><!--- By Default we are using the testing environment --->
		<cfset loc.sameWindow = "">

		<cfif arguments.environmentActive>
			<cfif get("environment") EQ "production">
				<cfset loc.environment = "https://www.paypal.com/cgi-bin/webscr">
			<cfelse>
				<cfset loc.environment = "https://www.sandbox.paypal.com/cgi-bin/webscr">
			</cfif>
		<cfelse>
			<cfif arguments.environment EQ "production">
				<cfset loc.environment = "https://www.paypal.com/cgi-bin/webscr">
			<cfelse>
				<cfset loc.environment = "https://www.sandbox.paypal.com/cgi-bin/webscr">
			</cfif>
		</cfif>

		<!--- Open in same window or not? That is the question --->
		<cfif arguments.sameWindow EQ 0>
			<cfset loc.sameWindow = "target='paypal'">
		</cfif>

		<!--- submit onLoad --->
		<cfif arguments.onLoadSubmit EQ 1>
			<cfset loc.onLoadSubmit = "onLoad=""document.paypalform.submit();""">
		</cfif>

		<!--- If we dont want to show the credit card or that its of type "_cart" then  --->
		<cfif arguments.showCreditCard EQ 0 OR arguments.type EQ "_cart">
			<cfset loc.showCreditCard = "">
		</cfif>

		<!--- If they want to show their own button then make it happen otherwise choose the one related to the "type" parameter --->
		<cfif StructKeyExists(arguments, "buttonImage")>
			<cfset loc.imageSource = arguments.buttonImage>
		<cfelse>
			<!--- Lets choose the right image from the selected type of button --->
			<cfswitch expression = #arguments.type#>
				<cfcase value = "_cart">
					<cfif arguments.cart EQ "add">
			        	<cfset loc.submitImage = "btn_cart_LG.gif">
			        <cfelseif arguments.cart EQ "display">
			        	<cfset loc.submitImage = "view_cart_new.gif">
					</cfif>
			    </cfcase>
				<cfcase value = "_xclick">
			        <cfset loc.submitImage = "btn_buynow#loc.showCreditCard#_LG.gif">
			    </cfcase>
				<cfcase value = "_donations">
			        <cfset loc.submitImage = "btn_donate#loc.showCreditCard#_LG.gif">
			    </cfcase>
				<cfcase value = "_oe-gift-certificate">
			        <cfset loc.submitImage = "btn_gift#loc.showCreditCard#_LG.gif">
			    </cfcase>
				<cfcase value = "_xclick-subscriptions">
			        <cfset loc.submitImage = "btn_subscribe#loc.showCreditCard#_LG.gif">
			    </cfcase>
			</cfswitch>

			<!--- Lets choose the language for the submit button (en, fr, es, de, nl, zh, ja, pt) --->
			<cfswitch expression = #arguments.lang#>
				<cfcase value = "en">
			        <cfset loc.langButtonDir = "en_US">
			        <cfset loc.langButtonAlt = "PayPal - The safer, easier way to pay online!">
			    </cfcase>
				<cfcase value = "fr">
			        <cfset loc.langButtonDir = "fr_XC">
			        <cfset loc.langButtonAlt = "PayPal - la solution de paiement en ligne la plus simple et la plus sécurisée !">
			    </cfcase>
				<cfcase value = "es">
			        <cfset loc.langButtonDir = "es_XC">
			        <cfset loc.langButtonAlt = "PayPal. La forma rápida y segura de pagar en línea.">
			    </cfcase>
				<cfcase value = "de">
			        <cfset loc.langButtonDir = "de_DE/DE">
			        <cfset loc.langButtonAlt = "Jetzt einfach, schnell und sicher online bezahlen – mit PayPal.">
			    </cfcase>
				<cfcase value = "nl">
			        <cfset loc.langButtonDir = "nl_NL/BE">
			        <cfset loc.langButtonAlt = "PayPal, de veilige en complete manier van online betalen.">
			    </cfcase>
				<cfcase value = "zh">
			        <cfset loc.langButtonDir = "zh_XC">
			        <cfset loc.langButtonAlt = "PayPal － 更安全、更簡單的網上付款方式！">
			    </cfcase>
				<cfcase value = "ja">
			        <cfset loc.langButtonDir = "ja_JP/JP">
			        <cfset loc.langButtonAlt = "PayPal- オンラインで安全・簡単にお支払い">
			    </cfcase>
				<cfcase value = "pt">
			        <cfset loc.langButtonDir = "pt_BR/BR">
			        <cfset loc.langButtonAlt = "PayPal - A maneira mais fácil e segura de efetuar pagamentos on-line!">
			    </cfcase>
			</cfswitch>

			<cfset loc.imageSource = "https://www.paypal.com/#loc.langButtonDir#/i/btn/#loc.submitImage#">

		</cfif>

		<cfoutput>

		<cfif StructKeyExists(arguments, "business")><!--- Don't show the form if no paypal id or email has been provided --->

			<cfsavecontent variable="paypalform">
				<form action="#loc.environment#" method="post" name="paypalform" #loc.sameWindow# target="_top">

					<input type="hidden" name="cmd" value="#arguments.type#">
					<input type="hidden" name="business" value="#arguments.business#">
					<input type="hidden" name="lc" value="#arguments.lc#">
					<input type="hidden" name="no_note" value="#arguments.noNote#">
					<input type="hidden" name="currency_code" value="#arguments.currency#">

					<cfif arguments.type EQ "_cart">
						<cfswitch expression = #arguments.cart#>
							<cfcase value = "add">
		        				<cfset loc.cart = "add">
						    </cfcase>
							<cfcase value = "display">
		        				<cfset loc.cart = "display">
						    </cfcase>
						</cfswitch>

						<input type="hidden" name="#loc.cart#" value="1">

					<cfelseif arguments.type EQ "_oe-gift-certificate" AND StructKeyExists(arguments, "shoppingUrl")>
						<input type="hidden" name="shopping_url" value="#arguments.shoppingUrl#">

					<cfelseif arguments.type EQ "_xclick-subscriptions">
						<input type="hidden" name="a3" value="#arguments.a3#">
						<input type="hidden" name="p3" value="#arguments.p3#">
						<input type="hidden" name="t3" value="#arguments.t3#">
					</cfif>

					<cfif StructKeyExists(arguments, "amount")>
						<input type="hidden" name="amount" value="#arguments.amount#">
					</cfif>

					<cfif StructKeyExists(arguments, "itemName")>
						<input type="hidden" name="item_name" value="#arguments.itemName#">
					</cfif>

					<cfif StructKeyExists(arguments, "itemNumber")>
						<input type="hidden" name="item_number" value="#arguments.itemNumber#">
					</cfif>

					<cfif StructKeyExists(arguments, "quantity")>
						<input type="hidden" name="quantity" value="#arguments.quantity#">
					</cfif>

					<cfif StructKeyExists(arguments, "shipping")>
						<input type="hidden" name="shipping" value="#arguments.shipping#">
					</cfif>

					<cfif StructKeyExists(arguments, "taxRate")>
						<input type="hidden" name="tax_rate" value="#arguments.taxRate#">
					</cfif>

					<cfif StructKeyExists(arguments, "return")>
						<input type="hidden" name="return" value="#arguments.return#">
					</cfif>

					<cfif StructKeyExists(arguments, "notifyUrl")>
						<input type="hidden" name="notify_url" value="#arguments.notifyUrl#">
					</cfif>

					<cfif StructKeyExists(arguments, "cancelReturn")>
						<input type="hidden" name="cancel_return" value="#arguments.cancelReturn#">
					</cfif>

					<cfif StructKeyExists(arguments, "cbt")>
						<input type="hidden" name="cbt" value="#arguments.cbt#">
					</cfif>

					<cfif StructKeyExists(arguments, "firstName")>
						<input type="hidden" name="first_name" value="#arguments.firstName#">
					</cfif>

					<cfif StructKeyExists(arguments, "lastName")>
						<input type="hidden" name="last_name" value="#arguments.lastName#">
					</cfif>

					<cfif StructKeyExists(arguments, "custom")>
						<input type="hidden" name="custom" value="#arguments.custom#">
					</cfif>

					<cfif StructKeyExists(arguments, "headerImage")>
						<input type="hidden" name="cpp_header_image" value="#arguments.headerImage#">
					</cfif>

					<cfif arguments.onLoadSubmit EQ 0>
						<input type="image" src="#loc.imageSource#" border="0" name="submit" alt="#loc.langButtonAlt#">
						<img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
					<cfelse>				
						#arguments.onLoadSubmitMessage#
							
						<script>document.paypalform.submit();</script>	
					</cfif>
				</form>
			</cfsavecontent>

			#paypalform#

		</cfif>

		<cfif arguments.debug AND get("environment") NEQ "production"><!--- to prevent in case you forgot to put back the debug off in prod--->

			<div style="border: 1px black solid;">

			<cfset loc.error = false>

			<p>Just to let you know that:</p>

			<ul>
			<cfif NOT StructKeyExists(arguments, "business")>
				<cfset loc.error = true>
				<li>You need to at least provide your PayPal ID or an email address associated with your PayPal account to receive payments.</li>
			</cfif>

			<!--- Since 'amount' is:
					- Required for Add to Cart buttons
					- Optional for Buy Now and Donate buttons
					- Not used with Subscribe or Buy Gift Certificate buttons
			 --->
			 <cfif arguments.type EQ "_cart" AND arguments.amount EQ "">
			 	<cfset loc.error = true>
			 	<li>You have selected the Button of type "_cart" and in that case the parameter "amount" is required.</li>
			 </cfif>

			 <cfif arguments.type EQ "_oe-gift-certificate" AND NOT StructKeyExists(arguments, "shoppingUrl")>
			 	<cfset loc.error = true>
			 	<li>You have selected the Button of type "_oe-gift-certificate" and in that case the parameter "shoppingUrl" is required.</li>
			 </cfif>

			<!--- Since 'itemName' is:
					- Optional for Buy Now, Donate, Subscribe and Add to Cart buttons
					- Not used with Buy Gift Certificate buttons
			 --->
			<cfif arguments.type EQ "_oe-gift-certificate" and arguments.itemName NEQ "">
				<cfset loc.error = true>
				<li>You can't add a item name for a button of type "_oe-gift-certificate"</li>
			</cfif>

			<cfif StructKeyExists(arguments, "cbt") AND NOT StructKeyExists(arguments, "return")>
				<cfset loc.error = true>
				<li>The return variable must also be set if you change the text for the Return to Merchant button (cbt).</li>
			</cfif>

			<cfif StructKeyExists(arguments, "headerImage")>
				<cfset loc.error = true>
				<li>Just a reminder that the image at the top left of the checkout page (headerImage) will only be available if the email receiver is a business account.</li>
			</cfif>

			<cfif StructKeyExists(arguments, "notifyUrl")>
				<cfset loc.error = true>
				<li>Try the <a href="https://cms.paypal.com/us/cgi-bin/?cmd=_render-content&amp;content_ID=developer/e_howto_admin_IPNTesting##id089BD0L50PF">IPN simulator</a></li>
			</cfif>

			</ul>

			<cfif NOT loc.error>
				<p>Everything looks ok.</p>
			</cfif>

			<p>Your paypal form source code:</p>
			<textarea style="width:350px; height:100px;">#paypalform#</textarea>

			</div>
		</cfif>

		</cfoutput>

	</cffunction>

	<cffunction name="verifyPaypalPayment" hint="Using Instant Payment Notification (IPN) postback method it will verify that the transaction is valid.
												To activate Instant Payment Notification, you will need to enter the URL (notifyUrl from showPaypalButton())
												at which you would like to receive the notification posts from your Profile. You need to use this function
												inside the action of the notifyUrl.">

		<cfargument name="environment" type="string" required="false" default="testing"
					hint="What environment you want to use? Choose between testing and production.">

		<cfargument name="environmentActive" type="boolean" required="false" default="0"
					hint="You can let your active environment setting manage witch environment to use.">

		<cfargument name="price" type="string" required="false"
					hint="Enter the price that you want to compare. If not identical it return 5.">

		<cfargument name="itemNumber" type="string" required="false"
					hint="Enter the item number that you want to compare. If not identical it return 6.">

		<cfargument name="currency" type="string" required="false" default="USD"
					hint="Enter the currency that you want to compare. If not identical it return 7.">

		<cfargument name="receiverEmail" type="string" required="true"
					hint="Primary email address of the payment recipient (that is, the merchant). If the payment is sent to a non-primary email address on your PayPal account, the receiverEmail is still your primary email.">

		<!---

		Returns

		0, if response from PayPal equal INVALID
		1, if response from PayPal equal VERIFIED and PAYMENT STATUS return "Completed" and it meets all your checks (price, itemNumber, currency, receiverEmail)
		2, if response from PayPal equal VERIFIED and RECEIVER EMAIL not equal to arguments.receiverEmail
		3, if response from PayPal equal VERIFIED and PRICE not equal to arguments.price
		4, if response from PayPal equal VERIFIED and ITEM NUMBER not equal to arguments.itemNumber
		5, if response from PayPal equal VERIFIED and CURRENCY not equal to arguments.currency
		6, if response from PayPal equal VERIFIED and PAYMENT STATUS return "Canceled_Reversal"
		7, if response from PayPal equal VERIFIED and PAYMENT STATUS return "Completed"
		8, if response from PayPal equal VERIFIED and PAYMENT STATUS return "Denied"
		9, if response from PayPal equal VERIFIED and PAYMENT STATUS return "Expired"
		10, if response from PayPal equal VERIFIED and PAYMENT STATUS return "Failed"
		11, if response from PayPal equal VERIFIED and PAYMENT STATUS return "In-Progress"
		12, if response from PayPal equal VERIFIED and PAYMENT STATUS return "Partially_Refunded"
		13, if response from PayPal equal VERIFIED and PAYMENT STATUS return "Pending"
		14, if response from PayPal equal VERIFIED and PAYMENT STATUS return "Processed"
		15, if response from PayPal equal VERIFIED and PAYMENT STATUS return "Refunded"
		16, if response from PayPal equal VERIFIED and PAYMENT STATUS return "Reversed"
		17, if response from PayPal equal VERIFIED and PAYMENT STATUS return "Voided"

		Note that the function can return more then 1 value. Ex. the payment status could be pending and also the price, currency, item number and receiver email could have been modified

		 --->

		<cfset var loc = {}>
		<cfset loc.returnValue = "0">
		<cfset loc.parameters="cmd=_notify-validate"><!---  The postback to PayPal must include the variable cmd with the value _notify-validat --->

		<!--- The postback must include exactly the same variables and values that you receive in the
		IPN from PayPal, and they must be in the same order otherwise it will return "INVALID"  --->
		<cfloop list="#structKeyList(params)#" index="key">
			<cfset loc.parameters = loc.parameters & "&#LCase(key)#=#URLEncodedFormat(params[key])#">
		</cfloop>

		<cfif StructKeyExists(form, "payment_date")>
		    <cfset loc.parameters = loc.parameters & "&payment_date=#URLEncodedFormat(Form.payment_date)#">
		</cfif>

		<cfif StructKeyExists(form, "subscr_date")>
		    <cfset loc.parameters = loc.parameters & "&subscr_date=#URLEncodedFormat(Form.subscr_date)#">
		</cfif>

		<cfif arguments.environmentActive>
			<cfif get("environment") EQ "production">
				<!--- PayPal will respond to the post with a single word, "VERIFIED" or "INVALID", in the body of the response. --->
				<cfhttp url="https://www.paypal.com/cgi-bin/webscr?#loc.parameters#" method="get" resolveURL="false"></cfhttp>
			<cfelse>
				<cfhttp url="https://www.sandbox.paypal.com/cgi-bin/webscr?#loc.loc.parameters#" method="get" resolveURL="false"></cfhttp>
			</cfif>
		<cfelse>
			<cfif arguments.environment EQ "production">
				<cfhttp url="https://www.paypal.com/cgi-bin/webscr?#loc.parameters#" method="get" resolveURL="false"></cfhttp>
			<cfelse>
				<cfhttp url="https://www.sandbox.paypal.com/cgi-bin/webscr?#loc.parameters#" method="get" resolveURL="false"></cfhttp>
			</cfif>
		</cfif>

		<!--- check notification validation
			When you receive a VERIFIED response, you need to perform several checks before fulfilling the order:
			Confirm that the "payment_status" is "Completed," since IPNs are also sent for other results such as "Pending" or "Failed"
			Validate that the "receiver_email" is an email address registered in your PayPal account, to prevent the payment from being sent to a fraudster's account
			Check other transaction details such as the item number and price to confirm that the value has not been changed
		--->
		<cfif StructKeyExists(form, "payment_status") AND cfhttp.fileContent is "VERIFIED">

			<cfset loc.returnValue = ""><!--- Since we know the return value is VERIFIED we can reset it.  Now lets perfom some other validation --->

			<!--- check that receiver_email is your email address (arguments.business) --->
			<cfif StructKeyExists(arguments, "receiverEmail") AND compare(form.receiver_email, arguments.receiverEmail) NEQ 0>
				<cfset loc.returnValue = listAppend(loc.returnValue, "2")>
			</cfif>

			<!--- check that form.mc_gross provided by PayPal is identical to the (arguments.price) --->
			<cfif StructKeyExists(arguments, "price") AND compare(form.mc_gross, arguments.price) NEQ 0>
				<cfset loc.returnValue = listAppend(loc.returnValue, "3")>
			</cfif>

			<!--- check that form.item_number provided by PayPal is identical to the (arguments.itemNumber) --->
			<cfif StructKeyExists(arguments, "itemNumber") AND StructKeyExists(form, "item_number") AND compare(form.item_number, arguments.itemNumber) NEQ 0>
				<cfset loc.returnValue = listAppend(loc.returnValue, "4")>
			</cfif>

			<!--- check that form.mc_currency provided by PayPal is identical to the (arguments.currency) --->
			<cfif compare(form.mc_currency, arguments.currency) NEQ 0>
				<cfset loc.returnValue = listAppend(loc.returnValue, "5")>
			</cfif>

			<!--- check the payment_status --->
			<cfswitch expression = "#form.payment_status#">
				<cfcase value = "Canceled_Reversal">
					<cfset loc.returnValue = listAppend(loc.returnValue, "6")>
			    </cfcase>
				<cfcase value = "Completed">
					<cfset loc.returnValue = listAppend(loc.returnValue, "7")>
			    </cfcase>
				<cfcase value = "Denied">
					<cfset loc.returnValue = listAppend(loc.returnValue, "8")>
			    </cfcase>
				<cfcase value = "Expired">
					<cfset loc.returnValue = listAppend(loc.returnValue, "9")>
			    </cfcase>
				<cfcase value = "Failed">
					<cfset loc.returnValue = listAppend(loc.returnValue, "10")>
			    </cfcase>
				<cfcase value = "In-Progress">
					<cfset loc.returnValue = listAppend(loc.returnValue, "11")>
			    </cfcase>
				<cfcase value = "Partially_Refunded">
					<cfset loc.returnValue = listAppend(loc.returnValue, "12")>
			    </cfcase>
				<cfcase value = "Pending">
					<cfset loc.returnValue = listAppend(loc.returnValue, "13")>
			    </cfcase>
				<cfcase value = "Processed">
					<cfset loc.returnValue = listAppend(loc.returnValue, "14")>
			    </cfcase>
				<cfcase value = "Refunded">
					<cfset loc.returnValue = listAppend(loc.returnValue, "15")>
			    </cfcase>
				<cfcase value = "Reversed">
					<cfset loc.returnValue = listAppend(loc.returnValue, "16")>
			    </cfcase>
				<cfcase value = "Voided">
					<cfset loc.returnValue = listAppend(loc.returnValue, "17")>
			    </cfcase>
			</cfswitch>

			<!--- Now if it pass all the previous checks and the payment status is Completed (7) then we can update the return value to 1  --->
			<cfif loc.returnValue EQ "7">
				<cfset loc.returnValue = "1">
			</cfif>

		</cfif>

		<cfreturn loc.returnValue>

	</cffunction>

	<cffunction name="paypalCurrencyToLocale" hint="Convert the PayPal 3-character ISO-4217 currency codes to a locale for ColdFusion processing">

		<cfargument name="currency" type="string" required="false" default="USD"
					hint="Enter the PayPal 3-character ISO-4217 currency code that you want to convert">

		<cfset var loc = {}>
		<cfset loc.returnValue = "0">

		<cfswitch expression = "#arguments.currency#">
			<cfcase value = "AUD"><!--- Australian Dollar --->
				<cfset loc.returnValue = "en_AU">
		    </cfcase>
			<cfcase value = "CAD"><!--- Canadian Dollar --->
				<cfset loc.returnValue = "en_CA">
		    </cfcase>
			<cfcase value = "CZK"><!--- Czech Koruna --->
				<cfset loc.returnValue = "cs_CZ">
		    </cfcase>
			<cfcase value = "DKK"><!--- Danish Krone --->
				<cfset loc.returnValue = "da_DK">
		    </cfcase>
			<cfcase value = "EUR"><!--- Euro --->
				<cfset loc.returnValue = "fr_FR">
		    </cfcase>
			<cfcase value = "HKD"><!--- Hong Kong Dollar --->
				<cfset loc.returnValue = "zh_HK">
		    </cfcase>
			<cfcase value = "HUF"><!--- Hungarian Forint --->
				<cfset loc.returnValue = "hu_HU">
		    </cfcase>
			<cfcase value = "ILS"><!--- Israeli New Sheqel --->
				<cfset loc.returnValue = "iw_IL">
		    </cfcase>
			<cfcase value = "JPY"><!--- Japanese Yen --->
				<cfset loc.returnValue = "ja_JP">
		    </cfcase>
			<cfcase value = "MXN"><!--- Mexican Peso --->
				<cfset loc.returnValue = "es_MX">
		    </cfcase>
			<cfcase value = "NOK"><!--- Norwegian Krone --->
				<cfset loc.returnValue = "no_NO">
		    </cfcase>
			<cfcase value = "NZD"><!--- New Zealand Dollar --->
				<cfset loc.returnValue = "en_NZ">
		    </cfcase>
			<cfcase value = "PHP"><!--- Philippine Peso --->
				<cfset loc.returnValue = "en_PH">
		    </cfcase>
			<cfcase value = "PLN"><!--- Polish Zloty --->
				<cfset loc.returnValue = "pl_PL">
		    </cfcase>
			<cfcase value = "GBP"><!--- Pound Sterling --->
				<cfset loc.returnValue = "en_GB">
		    </cfcase>
			<cfcase value = "SGD"><!--- Singapore Dollar --->
				<cfset loc.returnValue = "en_SG">
		    </cfcase>
			<cfcase value = "SEK"><!--- Swedish Krona --->
				<cfset loc.returnValue = "sv_SE">
		    </cfcase>
			<cfcase value = "CHF"><!--- Swiss Franc --->
				<cfset loc.returnValue = "it_CH">
		    </cfcase>
			<cfcase value = "TWD"><!--- Taiwan New Dollar --->
				<cfset loc.returnValue = "zh_TW">
		    </cfcase>
			<cfcase value = "THB"><!--- Thai Baht --->
				<cfset loc.returnValue = "th_TH">
		    </cfcase>
			<cfcase value = "USD"><!--- U.S. Dollar --->
				<cfset loc.returnValue = "en_US">
		    </cfcase>

		</cfswitch>

		<cfreturn loc.returnValue>

	</cffunction>

</cfcomponent>
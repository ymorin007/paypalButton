<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<h1>paypalButton Plugin</h1>
<h2>Description</h2>
<p>Let you create a paypal button and also validate transaction using Instant Payment Notification (IPN).</p>
<p>Functions available are:</p>
<ul>
  <li><code><a href="#showPaypalButton">showPaypalButton()</a></code></li>
  <li><code><a href="#verifyPaypalPayment">verifyPaypalPayment()</a></code></li>
</ul>
<hr />
<a name="showPaypalButton"></a><h2><code>showPaypalButton()</code></h2> 
			
 
<h3>Description</h3> 
<p>  Builds and returns a form using the <a href="https://cms.paypal.com/us/cgi-bin/?cmd=_render-content&amp;content_ID=developer/e_howto_html_Appx_websitestandard_htmlvariables">PayPal HTML Variables for the Website Payments Standard.</a></p> 
 
<h3>Parameters</h3> 
 
<table border="1"> 
		<thead> 
			<tr> 
				<th width="108">Parameter</th> 
				<th width="48">Type</th> 
				<th width="83">Required</th> 
				<th width="184">Default</th> 
				<th width="771">Description</th>
				<th width="771">Type of button that can use this parameter</th>
			</tr> 
		</thead> 
		<tbody> 
			
		  <tr > 
					<td valign="top"><code>type</code></td> 
					<td valign="top"><code>string</code></td> 
			  <td valign="top" class="required">No</td> 
					<td valign="top">_xclick</td> 
			  <td valign="top">  <p>The type of button to display. Those <code></code> are the options available for you:</p>
		        <ul>
				        <li> <strong>_cart</strong>  (for the shopping cart)</li>
				        <li> <strong>_xclick</strong>  (for the Buy Now)</li>
				        <li> <strong>_donations</strong>  (for the Donations)</li>
				        <li>   <strong>_oe-gift-certificate </strong>(  for Gift certificates)</li>
				        <li><strong>   _xclick-subscriptions</strong> (for Subscriptions)</li>
	          </ul></td>
			  <td valign="top">N/A</td>
	      </tr> 
			
				<tr>
				  <td valign="top">cart</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">add</td>
				  <td valign="top"><p>For shopping cart purchases; these additional variables specify the kind of shopping cart button or command:</p>
				    <ul>
				      <li>				        <strong>add</strong> – Add to Cart buttons </li>
				      <li>				        <strong>display</strong> – View Cart buttons </li>
		          </ul></td>
				  <td valign="top"><strong>_cart</strong> (for the shopping cart)</td>
          </tr>
				<tr>
				  <td valign="top">shoppingUrl</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"> Enter the URL where recipients can shop and redeem this gift certificate.</td>
				  <td valign="top"><strong>_oe-gift-certificate </strong>(  for Gift certificates)</td>
          </tr>
				<tr>
				  <td valign="top">environment</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">testing</td>
				  <td valign="top"><p>What paypal environment you want to use? Choose between <strong>:</strong></p>
			        <ul>
			          <li><strong>testing</strong> (for https://www.sandbox.paypal.com/cgi-bin/webscr)</li>
			          <li><strong>production</strong> (for https://www.paypal.com/cgi-bin/webscr)</li>
		            </ul>
		          <p><strong>Note:</strong> to use testing you need to create a account under the <a href="https://developer.paypal.com/">Sandbox</a>.</p></td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top">environnentActive</td>
				  <td valign="top">boolean</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">0</td>
				  <td valign="top"><p>You can let your cfwheels active environment setting manage witch environment to use.</p>
			        <ul>
			          <li>Design, Development, Testing, Maintenance will use the PayPal <strong>testing</strong> environment (https://www.sandbox.paypal.com/cgi-bin/webscr) url.</li>
			          <li>production will use the PayPal <strong>  production</strong> environment (https://www.paypal.com/cgi-bin/webscr)</li>
                  </ul></td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top">business</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required"><strong>Yes</strong></td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"> Your PayPal ID or an email address associated with your PayPal account  to receive payments. Email addresses must be confirmed.   </td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top">lc</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">US</td>
				  <td valign="top"><p>Sets the payer’s language for the billing information/log-in page only. For allowable values, see <a href="https://cms.paypal.com/us/cgi-bin/?&amp;cmd=_render-content&amp;content_ID=developer/e_howto_api_nvp_country_codes" title="PayPal uses 2-character IS0-3166-1 codes for specifying countries and regions that are supported in fields and variables.">Countries and Regions Supported by PayPal</a>.</p></td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top"> amount</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required"> See description</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"><p>The price or amount of the product, service, or contribution, not including shipping, handling, or tax. If omitted from Buy Now or Donate buttons, payers enter their own amount at the time of payment.</p>
				    <ul>
				      <li>
				        Required for Add to Cart buttons
			          </li>
				      <li>
				        Optional for Buy Now and Donate buttons
			          </li>
				      <li>
				        Not used with Subscribe or Buy Gift Certificate buttons
			          </li>
		          </ul></td>
				  <td valign="top"><ul>
				    <li><strong>_cart</strong> (for the shopping cart)</li>
				    <li> <strong>_xclick</strong> (for the Buy Now)</li>
				    <li> <strong>_donations</strong> (for the Donations)</li>
			      </ul></td>
          </tr>
				<tr>
				  <td valign="top">taxRate</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"> Transaction-based tax override variable. Set this to a percentage that will be applied to amount multiplied the quantity selected during checkout. This value overrides any tax settings set in your account profile. Allowable values are numbers 0.001 through 100. </td>
				  <td valign="top"><ul>
				    <li><strong>_cart</strong> (for the shopping cart)</li>
				    <li> <strong>_xclick</strong> (for the Buy Now)</li>
			      </ul></td>
          </tr>
				<tr>
				  <td valign="top"> quantity</td>
				  <td valign="top">numeric</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"><p>Number of items. </p>
			      <p><strong>Note:</strong> The value for quantity must be a positive integer. Null, zero, or negative numbers are not allowed.</p></td>
				  <td valign="top"><ul>
				    <li><strong>_cart</strong> (for the shopping cart)</li>
				    <li> <strong>_xclick</strong> (for the Buy Now)</li>
			      </ul></td>
          </tr>
				<tr>
				  <td valign="top"> shipping</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"> The cost of shipping this item.</td>
				  <td valign="top"><ul>
				    <li><strong>_cart</strong> (for the shopping cart)</li>
				    <li> <strong>_xclick</strong> (for the Buy Now)</li>
			      </ul></td>
          </tr>
				<tr>
				  <td height="24" valign="top"> currency</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">USD</td>
				  <td valign="top"> The currency of the payment.   For allowable values, see <a href="https://cms.paypal.com/us/cgi-bin/?&amp;cmd=_render-content&amp;content_ID=developer/e_howto_api_nvp_currency_codes">Currency Codes</a>.</td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top">noNote</td>
				  <td valign="top">boolean</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">1</td>
				  <td valign="top"><p>Do not prompt payers to include a note with their payments. Allowable values for Subscribe buttons:</p>
				    <ul>
				      <li>
				        <p>1 – hide the text box and the prompt</p>
			          </li>
			        </ul>
			      <p>For Subscribe buttons, always include no_note and set it to 1.</p></td>
				  <td valign="top">All</td>
          </tr>
				<tr> 
					<td valign="top">itemName</td> 
					<td valign="top">string</td> 
					<td valign="top" class="required"> See description.</td> 
					<td valign="top">&nbsp;</td> 
					<td valign="top"><p>Description of item. If omitted, payers enter their own name at the time of payment.</p>
					  <ul>
					    <li>Optional for Buy Now, Donate, Subscribe and Add to Cart buttons</li>
					    <li>Not used with Buy Gift Certificate buttons </li>
	                </ul></td>
					<td valign="top"><ul>
					  <li><strong>_xclick</strong> (for the Buy Now)</li>
					  <li> <strong>_donations</strong> (for the Donations)</li>
					  <li><strong> _xclick-subscriptions</strong> (for Subscriptions)</li>
				    </ul></td>
				</tr>
				<tr>
				  <td valign="top">itemNumber</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"> Pass-through variable for you to track product or service purchased or the contribution made. The value you specify passed back to you upon payment completion. </td>
				  <td valign="top"><ul>
				    <li><strong>_cart</strong> (for the shopping cart)</li>
				    <li> <strong>_xclick</strong> (for the Buy Now)</li>
				    <li> <strong>_donations</strong> (for the Donations)</li>
			      </ul></td>
          </tr>
				<tr>
				  <td valign="top">showCreditCard</td>
				  <td valign="top">boolean</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">1</td>
				  <td valign="top"> Display credit card logos under the submit button</td>
				  <td valign="top"><ul>
				    <li><strong>_xclick</strong> (for the Buy Now)</li>
				    <li> <strong>_donations</strong> (for the Donations)</li>
				    <li> <strong>_oe-gift-certificate </strong>(  for Gift certificates)</li>
				    <li><strong> _xclick-subscriptions</strong> (for Subscriptions)</li>
			      </ul></td>
          </tr>
				<tr>
				  <td valign="top">lang</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">en</td>
				  <td valign="top"> <p>Language for the submit button (include also the alt tag text). Choose between:</p>
			        <ul>
			          <li><strong>en</strong> (for english)</li>
			          <li><strong>fr</strong> (for french)</li>
			          <li><strong>es</strong> (for spanich)</li>
			          <li><strong>de</strong> (for german)</li>
			          <li><strong>nl</strong> (for dutch)</li>
			          <li><strong>zh</strong> (for chinese)</li>
			          <li><strong>ja</strong> (for japanese)</li>
			          <li><strong>pt</strong> (for portuguese)</li>
                  </ul></td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top">headerImage</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"> <p>The image at the top left of the checkout page. The image’s maximum size is 750 pixels wide by 90 pixels high. PayPal recommends that you provide an image that is stored only on a secure (https) server. </p>
			      <p><strong>Note: </strong>will only work for paypal business account.</p></td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top">return</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">The browser is redirected to a PayPal web page.</td>
				  <td valign="top">The URL to which the payer’s browser is redirected after completing the payment; for example, a URL on your site that displays a “Thank you for your payment” page.</td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top">notifyUrl</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"> <p>The URL to which PayPal posts information about the transaction, in the form of Instant Payment Notification (IPN) messages. </p>
			      <p>The first level of testing is to ensure that your IPN listener receives messages and handles them appropriately. Try the <a href="https://cms.paypal.com/us/cgi-bin/?cmd=_render-content&amp;content_ID=developer/e_howto_admin_IPNTesting#id089BD0L50PF">IPN simulator</a></p></td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top">cancelReturn</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">The browser is redirected to a PayPal web page.</td>
				  <td valign="top"><p>A URL to which the payer’s browser is redirected if payment is cancelled; for example, a URL on your website that displays a “Payment Canceled” page</p></td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top">cbt</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"><p>Sets the text for the Return to Merchant button on the PayPal Payment Complete page. For Business accounts, the return button displays your business name in place of the word “Merchant” by default. For Donate buttons, the text reads “Return to donations coordinator” by default.</p>
		          <strong>Note:</strong> The return variable must also be set.</td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top"> custom</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"><p>Custom value as passed by you, the merchant. These are pass-through variables that are never presented to your customer</p>
			      <p><strong>Length:</strong> 255 characters</p></td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top">firstName</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"><p>First name of payer</p>
			      <p><strong>Length:</strong> 32 characters</p></td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top">lastName</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"><p>Last name of payer</p>
			      <p><strong>Length:</strong> 64 characters</p></td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top">a3</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"> Regular subscription price. </td>
				  <td valign="top"><strong>_xclick-subscriptions</strong> (for Subscriptions)</td>
		  </tr>
				<tr>
				  <td valign="top"> p3 </td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"> Subscription duration. Specify an integer value in the allowable range for the units of duration that you specify with t3. </td>
				  <td valign="top"><strong>_xclick-subscriptions</strong> (for Subscriptions)</td>
		  </tr>
				<tr>
				  <td valign="top"> t3</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"><p>Regular subscription units of duration. Allowable values:</p>
				    <ul>
				      <li>				        D – for days; allowable range for p3 is 1 to 90			          </li>
				      <li>				        W – for weeks; allowable range for p3 is 1 to 52			          </li>
				      <li>				        M – for months; allowable range for p3 is 1 to 24			          </li>
				      <li>				        Y – for years; allowable range for p3 is 1 to 5			          </li>
		          </ul></td>
				  <td valign="top"><strong>_xclick-subscriptions</strong> (for Subscriptions)</td>
		  </tr>
				<tr>
				  <td valign="top">buttonImage</td>
				  <td valign="top">string</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top"> Use custom button images that match the look of your website. Enter the url for the image.</td>
				  <td valign="top">All</td>
		  </tr>
				<tr>
				  <td valign="top">sameWindow</td>
				  <td valign="top">boolean</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">1</td>
				  <td valign="top">Target the click event to open on the same window. If false it PayPal will open in a new window.</td>
				  <td valign="top">All</td>
          </tr>
				<tr>
				  <td valign="top">debug</td>
				  <td valign="top">boolean</td>
				  <td valign="top" class="required">No</td>
				  <td valign="top">0</td>
				  <td valign="top">The debug will show you what to do if  you miss  some of the specific parameter requirements. Since some parameter only applies to some type of button. Try it you will see what I mean it won't hurt.</td>
				  <td valign="top">All</td>
          </tr> 
			
		</tbody> 
	</table> 
 
 
<p>&nbsp;</p>
<h3>Examples</h3>
<p><code class="block"><span id='formatted_code_CD41E3D5A3E27DD31EC1DEAB4ED' style='color:#000'><span style='color:#676767; background-color: #fff;'>&lt;!---&#32;view&#32;code&#32;---&gt;</span><br />
  <span style='color:#990033'>&lt;cfoutput&gt;</span><br />
  &#32;&#32;&#32;#showPaypalButton(type=&quot;_cart&quot;,<br />
  cart=&quot;add&quot;,<br />
  business=&quot;seller_1292691516_biz@hotmail.com&quot;,<br />
  amount=&quot;10&quot;,<br />
  itemName=&quot;my item&quot;,<br />
  itemNumber=&quot;10&quot;,<br />
  debug=&quot;1&quot;)#<br />
  <span style='color:#990033'>&lt;/cfoutput&gt;</span></span></code></p>
<a name="verifyPaypalPayment"></a><h2><code>verifyPaypalPayment()</code></h2></a>
<h3>Description</h3>
    <p> Using Instant Payment Notification (IPN) Method it will verify that the transaction is valid.   To activate Instant Payment Notification, you will need to enter the URL (<strong>notifyUrl</strong> from <code>showPaypalButton()</code>) at which you would like to receive the notification posts from your Profile.  You need to use this function  inside the action of the <strong>notifyUrl</strong>.</p>
    <p>IPN consists of 2 main steps:</p>
<table width="100%" border="1">
      <tr>
        <td><strong>Steps</strong></td>
        <td><strong>Function</strong></td>
      </tr>
      <tr>
        <td>1- Once the customer click on the PayPal Button PayPal POSTs the form variables to a URL (<strong>notifyUrl</strong>) you specify that runs a program to process the <br />
variables</td>
        <td>showPaypalButton ()</td>
      </tr>
      <tr>
        <td>2- You validate the notification.</td>
        <td>verifyPaypalPayment ()</td>
      </tr>
    </table>
    <h3>Returns</h3>
<p> 0, if response from PayPal equal INVALID<br />
1, if response from PayPal equal VERIFIED and PAYMENT STATUS return &quot;Completed&quot; and it meets all your checks (price, itemNumber, currency, receiverEmail)<br />
2, if response from PayPal equal VERIFIED and RECEIVER EMAIL not equal to arguments.receiverEmail<br />
3, if response from PayPal equal VERIFIED and PRICE not equal to arguments.price<br />
4, if response from PayPal equal VERIFIED and ITEM NUMBER not equal to arguments.itemNumber<br />
5, if response from PayPal equal VERIFIED and CURRENCY not equal to arguments.currency<br />
6, if response from PayPal equal VERIFIED and PAYMENT STATUS return &quot;Canceled_Reversal&quot;<br />
7, if response from PayPal equal VERIFIED and PAYMENT STATUS return &quot;Completed&quot;<br />
8, if response from PayPal equal VERIFIED and PAYMENT STATUS return &quot;Denied&quot;<br />
9, if response from PayPal equal VERIFIED and PAYMENT STATUS return &quot;Expired&quot;<br />
10, if response from PayPal equal VERIFIED and PAYMENT STATUS return &quot;Failed&quot;<br />
11, if response from PayPal equal VERIFIED and PAYMENT STATUS return &quot;In-Progress&quot;<br />
12, if response from PayPal equal VERIFIED and PAYMENT STATUS return &quot;Partially_Refunded&quot;<br />
13, if response from PayPal equal VERIFIED and PAYMENT STATUS return &quot;Pending&quot;<br />
14, if response from PayPal equal VERIFIED and PAYMENT STATUS return &quot;Processed&quot;<br />
15, if response from PayPal equal VERIFIED and PAYMENT STATUS return &quot;Refunded&quot;<br />
16, if response from PayPal equal VERIFIED and PAYMENT STATUS return &quot;Reversed&quot;<br />
17, if response from PayPal equal VERIFIED and PAYMENT STATUS return &quot;Voided&quot;</p>
<p><strong>Note</strong> that the function can return more then 1 value. Ex. the payment status could be pending and also the  price, currency, item number and receiver email could have been modified</p>
<h3>Parameters</h3>
<table border="1">
      <thead>
        <tr>
          <th width="108">Parameter</th>
          <th width="48">Type</th>
          <th width="83">Required</th>
          <th width="184">Default</th>
          <th width="771">Description</th>
        </tr>
  </thead>
      <tbody>
        <tr>
          <td valign="top">environment</td>
          <td valign="top">string</td>
          <td valign="top" class="required">No</td>
          <td valign="top">testing</td>
          <td valign="top"><p>What paypal environment you want to use to post back to PayPal system to validate? Choose between <strong>:</strong></p>
            <ul>
              <li><strong>testing</strong> (for https://www.sandbox.paypal.com/cgi-bin/webscr)</li>
              <li><strong>production</strong> (for https://www.paypal.com/cgi-bin/webscr)</li>
            </ul>
            <p><strong>Note:</strong> to use testing you need to create a account under the <a href="https://developer.paypal.com/">Sandbox</a>.</p></td>
        </tr>
        <tr>
          <td valign="top">environnentActive</td>
          <td valign="top">boolean</td>
          <td valign="top" class="required">No</td>
          <td valign="top">0</td>
          <td valign="top"><p>You can let your cfwheels active environment setting manage witch environment to use.</p>
            <ul>
              <li>Design, Development, Testing, Maintenance will use the PayPal <strong>testing</strong> environment (https://www.sandbox.paypal.com/cgi-bin/webscr) url.</li>
              <li>production will use the PayPal <strong> production</strong> environment (https://www.paypal.com/cgi-bin/webscr)</li>
            </ul></td>
        </tr>
        <tr>
          <td valign="top">price</td>
          <td valign="top">string</td>
          <td valign="top" class="required">No</td>
          <td valign="top">&nbsp;</td>
          <td valign="top">Enter the price  that you want to compare. If not identical it return 5.</td>
        </tr>
        <tr>
          <td valign="top">itemNumber</td>
          <td valign="top">string</td>
          <td valign="top" class="required">No</td>
          <td valign="top">&nbsp;</td>
          <td valign="top">Enter the item number that you want to compare. If not identical it return 6.</td>
        </tr>
        <tr>
          <td valign="top">currency</td>
          <td valign="top">string</td>
          <td valign="top" class="required">No</td>
          <td valign="top">USD</td>
          <td valign="top">Enter the currency that you want to compare.  If not identical it return 7. For allowable values, see <a href="https://cms.paypal.com/us/cgi-bin/?&amp;cmd=_render-content&amp;content_ID=developer/e_howto_api_nvp_currency_codes">Currency Codes</a>.</td>
        </tr>
        <tr>
          <td valign="top">receiverEmail</td>
          <td valign="top">string</td>
          <td valign="top" class="required"><strong>Yes</strong></td>
          <td valign="top">&nbsp;</td>
          <td valign="top"> Primary email address of the payment recipient (that is, the merchant). If the payment is sent to a non-primary email address on your PayPal account, the receiverEmail is still your primary email. </td>
        </tr>
      </tbody>
    </table>
<h3>History</h3>
<table border="1">
  <thead>
    <tr>
      <th width="108">Release</th>
      <th width="771">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td valign="top">0.2</td>
      <td valign="top"><ul>
        <li>Added the buttonImage parameter for showPaypalButton ().</li>
        <li>Added the  function verifyPaypalPayment ()</li>
      </ul></td>
    </tr>
  </tbody>
</table>
<h3>Examples</h3>
<p><code class="block"><span id='formatted_code_CD41E3D5A3E27DD31EC1DEAB4ED2' style='color:#000'><span style='color:#676767; background-color: #fff;'>&lt;!---&#32;controller&#32;code&#32;---&gt;</span><br />
  <span style='color:#990033'>&lt;cfoutput&gt;</span><br />
  &lt;cfset return = verifyPaypalPayment(receiverEmail=&quot;seller2@paypalsandbox.com&quot;, price=&quot;12.24&quot;, currency=&quot;AUD&quot;, itemNumber=&quot;1234&quot;)&gt;</span></code><code class="block"><span style='color:#000'>&#32;&#32;</span></code></p>
<p><code class="block"><span style='color:#000'>&lt;cfif listFind(return, 1)&gt;</span></code><code class="block"><span style="color:#000"><span style='color:#676767; background-color: #fff;'>&lt;!---PAYMENT STATUS return &quot;Completed&quot; and it meets all your checks (price, itemNumber, currency, receiverEmail)---&gt;</span></span></code><br />
  <code class="block"><span style='color:#000'>&lt;/cfif&gt;<br />
<span style='color:#990033'>&lt;/cfoutput&gt;</span></span></code></p>
</body>
</html>

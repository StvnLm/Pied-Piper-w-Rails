/* global $, Stripe */
//Document ready.
$(document).on('turbolinks:load', function(){
  var theForm = $('#pro_form');
  var submitBtn = $('#form-signup-btn');
  //Set Stripe public key.
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
  //When user clicks form submit btn,
  submitBtn.click(function(event){
    //prevent default submission behavior.
    event.preventDefault();
    //Change button to disabled when clicked
    submitBtn.val("Processing").prop('disabled', true);
    
    //Collect the credit card fields.
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
        
    //Use stripe JS to chceck for card errors
    var error = false;
    
    if (!Stripe.card.validateCardNumber(ccNum)){
      error = true;
      alert("Credit card number appears to be invalid");
    }
    
    if (!Stripe.card.validateCVC(cvcNum)){
      error = true;
      alert("CVC number appears to be invalid");
    }
    
    if (!Stripe.card.validateExpiry(expMonth, expYear)){
      error = true;
      alert("Expiry date appears to be invalid");
    }
    
    if (error) {
    //If there are card errors, dont send to stripe and re-enable the btn
    submitBtn.prop('disabled', false).val("Sign up");
    }
    else {
    //Send the card info to Stripe.
    Stripe.createToken({
      number: ccNum,
      cvc: cvcNum,
      exp_month: expMonth,
      exp_year: expYear
    }, stripeResponseHandler);
    }
    //Exit function
    return false;
  });
  //Stripe will return a card token.
  function stripeResponseHandler(status, response){
    //Get token from the response
    var token = response.id; 
    theForm.append( $('<input type="hidden" name="user[stripe_card_token]">').val(token) );
    //Submit form to our rails app
    theForm.get(0).submit();
  }
  //Inject card token as hidden field into form.
  //Submit form to our Rails app.
});
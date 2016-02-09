//resource.js

$( document ).ready(function() {
	resetForm()
		$("#endpoint,#method").change(function(){
			resetForm()
   		updateForm($("#endpoint").val(),$("#method").val());
    })
});

function resetForm() {
	$("div.form-group").not("#endpoint-group,#method-group,#submit-group,#accept-group").hide();
	$('select').not("#endpoint,#method,#accept").val('') 
}

function updateForm(ep,m) {
	if( ep  == "Contacts") {	
   		if( m == "GET") {
   			$("#iscustomer-group").show();  	
   		} else if ( m == "POST") {
   			$("#body-group").show();  
   		}
   	} else {

   	}
}

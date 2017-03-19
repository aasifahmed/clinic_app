$(document).ready(function(){

	$("#patient_detail_doctor").autocomplete({
	  source: $('#patient_detail_doctor').data('autocomplete-source'),
	  select: function( event, ui ) {
			this.form.action =this.form.action + '?name=' + ui.item.value
			// this.form.submit();
	  }
	});
	$("#patient_detail_payment_mode").autocomplete({
	  source: $('#patient_detail_payment_mode').data('autocomplete-source'),
	  select: function( event, ui ) {
			this.form.action =this.form.action + '?name=' + ui.item.value
			// this.form.submit();
	  }
	});
	$("#patient_detail_nationality").autocomplete({
	  source: $('#patient_detail_nationality').data('autocomplete-source'),
	  select: function( event, ui ) {
			this.form.action =this.form.action + '?name=' + ui.item.value
			// this.form.submit();
	  }
	});

$('form').on('click', '.remove_fields', function(event) {
  $(this).prev('input[type=hidden]').val('1');
  $(this).closest('fieldset').hide();
  return event.preventDefault();
});
$('form').on('click', '.remove_edit_fields', function(event) {
  $(this).prev('input[type=hidden]').val('1');
  $(this).closest('fieldset').hide();
	event.preventDefault();
});

	$('form').on('click', '.add_fields', function(event) {
		// alert('in');
	  var regexp, time;
	  time = new Date().getTime();
	  regexp = new RegExp($(this).data('id'), 'g');
	  $(this).after($(this).data('fields').replace(regexp, time));
	  return event.preventDefault();
	});

	$( "#from_date" ).datepicker({
		dateFormat: 'yy-mm-dd',
		showOtherMonths: true,
		selectOtherMonths: false,
		//isRTL:true,
	});
	$( "#to_date" ).datepicker({
		dateFormat: 'yy-mm-dd',
		showOtherMonths: true,
		selectOtherMonths: false,
		//isRTL:true,
	});

	function clean_trip_field() {
		$("#name").val('');
		$("#type").val('');
		$("#age").val('');
	}


//  Added by Aasif
	$('.add_invoice_products').submit(function(){
		var myurl = '/invoices/add_invoice_products';
		

	//	{  commented by ehti
		 $.ajax({
		 method:"POST",
		 url: myurl,
		 data: {
			services: $("#services").val(),
			quantity: $("#quantity").val(),
			price: $("#price").val()
			},
		 success:function(data){
			html = $.parseHTML( data )
			htm = html[1];

			 $('.result_invoice_product').append(data); 
				var price = $("input[id=invoice_new_invoice_product_attributes__price]").last().val();
				var tsprice = parseFloat($('#total_invoice_price').text());
				var tqty = $('#total_qty').text();
				var qty = parseFloat($("#quantity").val()) || 1;
				tqty = parseFloat(tqty) + qty;
				tsprice = parseFloat(tsprice) + parseFloat(price) * parseInt(qty);
				
				$('#total_invoice_price').empty().append(tsprice);
				$('#total_qty').empty().append(tqty);
			  			
				// calculate_total(tsprice);
			clean_product_field();
			$('#bootbox-regular').css('visibility','visible');
			$('.vat_field').removeClass('hidden');
		 },
		 error:function(data){
			alert("error");
			clean_product_field();
		 }
		});
		return false;
	});

	 function calculate_total(total) {
		// discount = sub_total * discount_percent / 100;
		// discount_sub_total = sub_total - discount;
		$('#total_excise_value').empty().append(excise_percent.toFixed(2));
		$('#sub_total_value').empty().append(sub_total.toFixed(2));
		$('#total_vat_value').empty().append(vat_percent.toFixed(2));
		
		$('#net_invoice_price').text(net_total.toFixed(2));

	 }
	 
	function clean_product_field(){
	
		$("#services").val(""); 
		$("#quantity").val(""); 
		$("#price").val(""); 
		$("#content_1").mCustomScrollbar("update");
		$("#services").focus();
	}

	$('form').on('click', '.remove_invoice_field', function(event) {
		var qty = $(this).closest('fieldset').find('#invoice_new_invoice_product_attributes__quantity').val();
		var price = $(this).closest('fieldset').find('#invoice_new_invoice_product_attributes__price').val();
		var tqty = $("#total_qty").text(); 
		var tsprice = $("#total_invoice_price").text(); 
		tqty =  parseInt(tqty) - parseInt(qty);
		tsprice =  parseFloat(tsprice) - (parseFloat(price) * parseInt(qty));
		$('#total_qty').empty().append(tqty);
		$('#total_invoice_price').empty().append(tsprice);
		// calculate_total(tsprice);
		$(this).closest('fieldset').remove();
		$("#content_1").mCustomScrollbar("update");
		event.preventDefault();
	});
});

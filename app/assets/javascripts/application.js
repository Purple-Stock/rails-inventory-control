// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require cocoon
//= require twitter/bootstrap
//= require rails-ujs
//= require_tree .
//= require serviceworker-companion

$(document).ready( function () {
    $('#list').select2();

    $('#stockTable').dataTable( {
		"language": {
            "url": "https://cdn.datatables.net/plug-ins/1.10.12/i18n/Portuguese-Brasil.json"
        },
       	columnDefs: [
	       { type: 'formatted-num', targets: 0 }
	    ],
		"order": [[ 0, "desc" ]],
		responsive: true,
     	stateSave: true
    } );

    $('#product-ajax').dataTable({
        ajax: '/products_defer',
        deferRender: true,
        columns: [
            { title: "Codigo Produto", data: 'attributes.custom_id' },
            { title: "Foto", data: 'attributes.image_url', render: function(image_url){
                if (image_url == null) {
                    return '<img src="https://purple-stock.s3-sa-east-1.amazonaws.com/images.png" width="250px" height="163px">';
                }else {
                    return '<img src="'+ image_url + '"width="250px" height="163px">';
                }
            }
            },
            { title: "Preço", data: 'attributes.price' },
            { title: "Nome", data: 'attributes.name' },
            { title: "Entrada", data: 'attributes.count_purchase_product' },
            { title: "Saída", data: 'attributes.count_sale_product' },
            { title: "Saldo", data: 'attributes.balance' },
            { title: "Categoria", data: 'attributes.category' },
            { title: "Ativo", data: 'attributes.active' },
            { title: "Ações", data: 'attributes.id', render: function(id){
                let html = '<a class="btn btn-default btn-xs" href="/products/'+ id + '">Ver</a><a class="btn btn-default btn-xs" href="/products/'+ id + '/edit">Editar</a><a data-confirm="Você tem certeza?" data-method="delete" rel="nofollow" class="btn btn-danger btn-xs" href="/products/'+ id + '">Deletar</a>';
                return html
            }}
        ],
        "language": {
            "url": "https://cdn.datatables.net/plug-ins/1.10.12/i18n/Portuguese-Brasil.json"
        },
        columnDefs: [
            { type: 'formatted-num', targets: 0 }
        ],
        "order": [[ 0, "desc" ]],
        responsive: true,
        stateSave: true
    })


	jQuery.extend( jQuery.fn.dataTableExt.oSort, {
	    "formatted-num-pre": function ( a ) {
	        a = (a === "-" || a === "") ? 0 : a.replace( /[^\d\-\.]/g, "" );
	        return parseFloat( a );
	    },
	 
	    "formatted-num-asc": function ( a, b ) {
	        return a - b;
	    },
	 
	    "formatted-num-desc": function ( a, b ) {
	        return b - a;
	    }
	} );

	jQuery.extend( jQuery.fn.dataTableExt.oSort, {
	    "date-uk-pre": function ( a ) {
	        if (a == null || a == "") {
	            return 0;
	        }
	        var ukDatea = a.split('/');
	        return (ukDatea[2] + ukDatea[1] + ukDatea[0]) * 1;
	    },
	 
	    "date-uk-asc": function ( a, b ) {
	        return ((a < b) ? -1 : ((a > b) ? 1 : 0));
	    },
	 
	    "date-uk-desc": function ( a, b ) {
	        return ((a < b) ? 1 : ((a > b) ? -1 : 0));
	    }
	} );
} );
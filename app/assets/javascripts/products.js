$(document).ready( function () {
    $('#product_category_id').select2();
    $('#product-ajax').dataTable({
	    ajax: '/products_defer',
	    deferRender: true,
	    columns: [
	        { title: "Codigo Produto", data: 'attributes.custom_id' },
	        { title: "Foto", data: 'attributes.image_url', render: function(image_url){
	                return '<img src="' + image_url + '"width="250px" height="163px">';
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
	            return html;
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
    });
} );
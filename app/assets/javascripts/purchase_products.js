$(document).ready( function () {
    $('#purchase_product_product_id').select2();
    $('#purchase_products_ajax').dataTable({
        ajax: '/purchase_products_defer',
        deferRender: true,
        columns: [
            { title: "Código Produto", data: 'attributes.custom_id' },
           	{ title: "Foto", data: 'attributes.image_url', render: function(image_url){
                    return '<img src="' + image_url + '"width="250px" height="163px">';
                }
            },
            { title: "Quantidade", data: 'attributes.quantity' },
            { title: "Valor", data: 'attributes.value' },
            { title: "Nome Produto", data: 'attributes.name' },
            { title: "Data de criação", data: 'attributes.created_at' },
            { title: "Ações", data: 'attributes.id', render: function(id){
                return '<a class="btn btn-default btn-xs" href="/purchase_products/'+ id + '">Ver</a><a class="btn btn-default btn-xs" href="/purchase_products/'+ id + '/edit">Editar</a><a data-confirm="Você tem certeza?" data-method="delete" rel="nofollow" class="btn btn-danger btn-xs" href="/purchase_products/'+ id + '">Deletar</a>';               
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
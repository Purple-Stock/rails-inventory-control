$(document).ready( function () {
    $('#sale_customer_id').select2();
    $('.form-control-sm').select2();
    $( ".add_fields" ).click(function() {
        setTimeout(function(){$('.form-control-sm').select2(); }, 1);
    });


    onScan.attachTo(document, {
        suffixKeyCodes: [13], // enter-key expected at the end of a scan
        reactToPaste: true, // Compatibility to built-in scanners in paste-mode (as opposed to keyboard-mode)
        onScan: function(sCode) { // Alternative to document.addEventListener('scan')
            fetchProducts(sCode);
        }
    });

    var product_data;

    function fetchProducts(custom_qr) {
        fetch('/api/v1/products/' + custom_qr.custom_id).then(function (res) {
            if (res.ok) {
                return res.json();
            }
        }).then(function (data) {
            product_data = data
            document.querySelector(".links > a").click();
        }).catch(function (err) {
            return console.log(err);
        });
    }

    $('.links').on('cocoon:after-insert', function(e, insertedItem, originalEvent) {
        insertedItem[0].querySelector('.form-control-sm').value = product_data.id;
        insertedItem[0].querySelectorAll('input')[0].value = 1;
        insertedItem[0].querySelectorAll('input')[1].value = product_data.price;
    });

    $('#sales-ajax').dataTable({
        ajax: '/sales_defer',
        deferRender: true,
        columns: [
            { title: "Cliente", data: 'attributes.name' },
            { title: "Desconto em R$", data: 'attributes.discount' },
            { title: "Porcentagem", data: 'attributes.percentage' },
            { title: "Online", data: 'attributes.online' },
            { title: "Valor", data: 'attributes.value' },
            { title: "Divulgação", data: 'attributes.disclosure' },
            { title: "Valor", data: 'attributes.value' },
            { title: "Data de criação", data: 'attributes.created_at' },
            { title: "Ações", data: 'attributes.id', render: function(id){
                return '<a class="btn btn-default btn-xs" href="/sales/'+ id + '">Ver</a><a class="btn btn-default btn-xs" href="/sales/'+ id + '/edit">Editar</a><a data-confirm="Você tem certeza?" data-method="delete" rel="nofollow" class="btn btn-danger btn-xs" href="/sales/'+ id + '">Deletar</a>';               
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

});
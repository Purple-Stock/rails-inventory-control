$(document).ready( function () {
    $('#sale_customer_id').select2();
    $('.form-control-sm').select2();
    $( ".add_fields" ).click(function() {
        setTimeout(function(){$('.form-control-sm').select2(); }, 1);
    });
} );

// document.querySelector("#sale_products > div.nested-fields > a").click();

onScan.attachTo(document, {
    suffixKeyCodes: [13], // enter-key expected at the end of a scan
    reactToPaste: true, // Compatibility to built-in scanners in paste-mode (as opposed to keyboard-mode)
    onScan: function(sCode) { // Alternative to document.addEventListener('scan')
        fetchProducts(sCode);
    }
});

var product_data;
var inserted;

function fetchProducts(custom_qr) {
    const custom_id = custom_qr.split('#');
    fetch('/api/v1/products/' + custom_id[3]).then(function (res) {
        if (res.ok) {
            return res.json();
        }
    }).then(function (data) {
        console.log('hey');
        product_data = data
        document.querySelector("#sale_products > .links > a").click();
    }).catch(function (err) {
        return console.log(err);
    });
}

$('#sale_products').on('cocoon:after-insert', function(e, insertedItem, originalEvent) {
    insertedItem[0].querySelector('.form-control-sm').value = product_data.id;
    insertedItem[0].querySelectorAll('input')[0].value = 1;
    insertedItem[0].querySelectorAll('input')[1].value = product_data.price;
});

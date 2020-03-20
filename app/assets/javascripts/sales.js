$(document).ready( function () {
    $('#sale_customer_id').select2();
    $('.form-control-sm').select2();
    $( ".add_fields" ).click(function() {
        setTimeout(function(){$('.form-control-sm').select2(); }, 1);
    });
} );

onScan.attachTo(document, {
    suffixKeyCodes: [13], // enter-key expected at the end of a scan
    reactToPaste: true, // Compatibility to built-in scanners in paste-mode (as opposed to keyboard-mode)
    onScan: function(sCode, iQty) { // Alternative to document.addEventListener('scan')
        console.log('Scanned: ' + iQty + 'x ' + sCode); 
    }
});

$(document).ready(function () {
    $('#ContentPlaceHolder1_filePhoto').change(function () {
        $("#frames").html('');
        for (var i = 0; i < $(this)[0].files.length; i++) {
            $("#frames").append('<img src="' + window.URL.createObjectURL(this.files[i]) + '"width="200px" height="200px" style="border:8px solid transparent" alt="Not an image, please change."/>');
        }
    });
});
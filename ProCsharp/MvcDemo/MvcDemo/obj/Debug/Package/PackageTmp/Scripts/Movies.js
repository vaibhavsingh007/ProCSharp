/// <reference path="jquery-1.5.1-vsdoc.js" />
/// <reference path="jquery-ui-1.8.11.js" />
/// <reference path="jQuery.tmpl.js" />


$(document).ready(function () {

    $(":input[data-autocomplete]").each(function () {
        $(this).autocomplete({ source: $(this).attr("data-autocomplete") });
    });

    // Now, for implementing a date picker, just look for the attribute defined in DateTime.cshtml,
    // viz. data-datepicker and wire up a datepicker() to it.
    $(":input[data-datepicker]").datepicker();

    $("#searchForm").submit(function () {
        $.getJSON($(this).attr("action"),       // The URL to get Json from.
                    $(this).serialize(),
                    function (data) {       // What to do with the response.
                        var result = $("#searchTemplate").tmpl(data);
                        $("#searchResults").empty().append(result);
                    }
            );
            return false;
    });
})

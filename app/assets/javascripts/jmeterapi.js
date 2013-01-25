/* 
 * This JavaScript-Class holds all specific functionality for the JMeter-Client-Application
 */

// Disable drop-down when default-template checkbox is selected
$("#jmx_default_template").live("click", function() {
    if($("#jmeter_run_jmx_definition_file_id").is(":disabled")) {
        $("#jmeter_run_jmx_definition_file_id").attr("disabled", false)
    } else {
        $("#jmeter_run_jmx_definition_file_id").attr("disabled", "disabled")
    }
});

$("tr.jmeter_runs_table_row").live("click", function() {
    var href = $(this).data("link");
    console.log(href);
    window.location.href = href;
});
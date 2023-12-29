$(document).ready(function(){
  $("#setting_scheme").on("change",function(){
    var scheme =  $(this).val();
    if (scheme == 'file'){
      $('#setting_host').val('');
      $('#setting_host').prop('readOnly',true);
      $('#setting_username').val('');
      $('#setting_username').prop('readOnly',true);
      $('#setting_password').val('');
      $('#setting_password').prop('readOnly',true);
    }
    else{
      $('#setting_host').prop('readOnly',false);
      $('#setting_username').prop('readOnly',false);
      $('#setting_password').prop('readOnly',false);
    }
  });

  if ($('#setting_scheme').val() == 'file'){
    $('#setting_host').val('');
    $('#setting_host').prop('readOnly',true);
    $('#setting_username').val('');
    $('#setting_username').prop('readOnly',true);
    $('#setting_password').val('');
    $('#setting_password').prop('readOnly',true);
  }
  else{
    $('#setting_host').prop('readOnly',false);
    $('#setting_username').prop('readOnly',false);
    $('#setting_password').prop('readOnly',false);
  }
  
  $("#available_report_mime_type").on("change",function(){
    var mime_type =  $(this).val();
    if (mime_type == 'text/csv'){
      $('#available_report_delimiter').val(',');
      $('#available_report_delimiter').prop('readOnly',true);
      $('#available_report_escape_character').val('"');
      $('#available_report_escape_character').prop('readOnly',true);
    }
    else{
      $('#available_report_delimiter').prop('readOnly',false);
      $('#available_report_escape_character').prop('readOnly',false);
    }
  });

  if ($("#available_report_mime_type").val() == 'text/csv'){
    $('#available_report_delimiter').val(',');
    $('#available_report_delimiter').prop('readOnly',true);
    $('#available_report_escape_character').val('"');
    $('#available_report_escape_character').prop('readOnly',true);
  }
  else{
    $('#available_report_delimiter').prop('readOnly',false);
    $('#available_report_escape_character').prop('readOnly',false);
  }
});

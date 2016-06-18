# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery -> $('#crews').dataTable();
jQuery -> $('#crews').removeClass('display').addClass('table table-striped table-bordered');
jQuery -> $('.dataTables_filter input[type="search"]').attr('class', 'form-control').attr('placeholder','Введіть інформацію для пошуку').css({'width':'450px', 'height':'45px', 'display':'inline-block', 'border-radius':'0px'});

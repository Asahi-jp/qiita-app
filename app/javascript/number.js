$(function() {
  let counter = 1;
  $(".number-icon").each(function(){
    $(this).text(`No.${counter}`)
    counter++;
  });
});
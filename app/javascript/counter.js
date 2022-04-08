// カウンターを追加
$(function() {
  let counter = 1;
  $(".number-icon--today").each(function(){
    $(this).text(`No.${counter}`)
    counter++;
  });
});
$(function() {
  let counter = 1;
  $(".number-icon--three_days").each(function(){
    $(this).text(`No.${counter}`)
    counter++;
  });
});
$(function() {
  let counter = 1;
  $(".number-icon--all").each(function(){
    $(this).text(`No.${counter}`)
    counter++;
  });
});
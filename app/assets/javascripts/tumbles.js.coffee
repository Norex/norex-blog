$ ->
  $('#centerbutton').click (e) ->
    e.preventDefault
    $('.circles li a').toggleClass 'out' 
    $(this).toggleClass 'centerbuttonon'
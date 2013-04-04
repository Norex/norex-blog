$ ->
  $('#centerbutton').click (e) ->
    e.preventDefault
    $('.circles li a').toggleClass 'out' 
    $(this).toggleClass 'centerbuttonon'

  $('#main-nav-btn').click (e) ->
    e.preventDefault
    $('#main-nav').toggleClass 'open'
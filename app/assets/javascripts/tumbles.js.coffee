$.ajaxSetup({ cache: true });
$ ->
  $('#centerbutton').click (e) ->
    e.preventDefault
    $('.circles li a').toggleClass 'out' 
    $(this).toggleClass 'centerbuttonon'

  $('#main-nav-btn').click (e) ->
    e.preventDefault
    $('#main-nav').toggleClass 'open'

  $(document).on 'click', '#category-list a', (e) ->
    $.getScript($(this).attr('href'))
    false

  $(document).on 'click', '#types-list a', (e) ->
    $.getScript($(this).attr('href'))
    #console.log('type clicked')
    false
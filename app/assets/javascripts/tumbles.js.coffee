$.ajaxSetup({ cache: true });
$ ->
  $(".content-container").fitVids()

  $('#centerbutton').click (e) ->
    e.preventDefault
    $('.circles li a').toggleClass 'out' 
    $(this).toggleClass 'centerbuttonon'

  $('#main-nav-btn').click (e) ->
    e.preventDefault
    $('#main-nav').toggleClass 'open'

  $(document).on 'click', '#category-list a', (e) ->
    $('#post-loader').removeClass 'hidden'
    $('#posts').html ''
    $.getScript $(this).attr('href')
   
    false

  $(document).on 'click', '#types-list a', (e) ->
    $('#post-loader').removeClass 'hidden'
    $('#posts').html ''
    $.getScript $(this).attr('href')

    false

  $(document).on 'click', '#author-list a', (e) ->
    $('#post-loader').removeClass 'hidden'
    $('#posts').html ''
    $.getScript $(this).attr('href')

    false
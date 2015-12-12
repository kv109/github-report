class AjaxLoader
  constructor: ->
    $('[data-load-ajax]').each ->
      $this = $(this)
      $.ajax(
        url: $this.data('load-ajax')
        beforeSend: -> $this.text('Loading data from Github...')
      ).done(
        (html) ->
          $this.replaceWith(html)
      )

$ ->
  new AjaxLoader
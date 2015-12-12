class AjaxLoader
  constructor: ->
    $('[data-load-ajax]').each ->
      $this = $(this)
      $.ajax(
        url: $this.data('load-ajax')
        data: $this.data('load-ajax-data')
        beforeSend: -> $this.append('<div class="loading">Loading&#8230;</div>')
      ).done(
        (html) ->
          $this.replaceWith(html)
      )

$ ->
  new AjaxLoader
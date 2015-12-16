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
          $this.append(html)
      ).error(
        -> $this.append('Something went wrong')
      ).complete(
        -> $('.loading').remove()
      )

$ ->
  new AjaxLoader
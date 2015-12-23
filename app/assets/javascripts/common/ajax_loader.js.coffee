class AjaxLoader
  constructor: ->
    $('[data-ajaxify]').each ->
      $this = $(this)
      params = $.extend(
        { partial: true },
        $this.data('load-ajax-data')
      )
      $.ajax(
        data: params
        beforeSend: -> $this.append('<div class="loading">Loading&#8230;</div>')
      ).done(
        (html) ->
          $this.append(html)
          $this.trigger('ajax-content-loaded')
      ).error(
        -> $this.append('Something went wrong')
      ).complete(
        -> $('.loading').remove()
      )

$ ->
  new AjaxLoader
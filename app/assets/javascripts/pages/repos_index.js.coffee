class ReposIndex
  constructor :->
    $('#repos-index').on('click', '[data-ajax-source]', ->
      $this = $(this)
      $target = $($this.data('ajax-target'))
      $targetAlreadyLoaded = !$target.is(':empty')
      $('#repos-index').find('.contributors').hide()
      $('#repos-index').find('[data-ajax-source]').removeClass('focus')
      $this.addClass('focus')

      if $targetAlreadyLoaded
        $target.show()
      else
        url = $this.data('ajax-source')
        $.ajax(
          url: url
          beforeSend: ->
            $this.append('<div class="loading">Loading&#8230;</div>')
        ).done(
          (html) ->
            $('.loading').remove()
            $target.show().html(html)
        ))

$ ->
  new ReposIndex()
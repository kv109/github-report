class @ReposIndex
  constructor :->
    $('#repos-index').on('click', '[data-ajax-source]', ->
      $this = $(this)
      url = $this.data('ajax-source')
      console.log 'url', url
      $.ajax(
        url: url
        beforeSend: -> $this.append('<div class="loading">Loading&#8230;</div>')
      ).done(
        (html) ->
          $('.loading').remove()
          $('#repos-index').find('[data-ajax-source]').removeClass('focus')
          $this.addClass('focus')
          $($this.data('ajax-target')).html(html)
      ))

$ ->
  new ReposIndex()
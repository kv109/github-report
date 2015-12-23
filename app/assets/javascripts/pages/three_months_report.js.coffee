class @UsersWeeklyReport
  constructor: ->
    data = {
      labels : @getWeeks()
      datasets : [
        {
          fillColor : "#00a8ba",
          strokeColor : "#003e45",
          pointColor : "#003e45",
          pointStrokeColor : "#fff",
          data : @getCommitsNumber()
        }
      ]
    }

    myNewChart = new Chart(@getCanvas().get(0).getContext("2d")).Line(data)

  getCanvas: ->
    $("#canvas")

  getWeeks: ->
    $.map(@getStats(), (weekData) ->
      new Date(weekData[0][1] * 1000).toLocaleDateString()
    )

  getCommitsNumber: ->
    $.map(@getStats(), (weekData) ->
      weekData[3][1]
    )

  getStats: ->
    @getCanvas().data('stats')[0].weeks.slice(-10)
$ ->
  new UsersWeeklyReport()
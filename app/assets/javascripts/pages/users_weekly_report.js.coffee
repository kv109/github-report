class @UsersWeeklyReport
  constructor: ->
    data = {
      labels : @getWeeks()
      datasets : [
        {
          fillColor : "#00DBED",
          strokeColor : "#00a8ba",
          pointColor : "#00a8ba",
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
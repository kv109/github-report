class Event
  class Item < Sawyer::Resource
    include Decorator

    def issues_event?
      type == 'IssuesEvent'
    end
  end
end
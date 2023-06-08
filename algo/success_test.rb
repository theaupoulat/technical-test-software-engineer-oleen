require_relative "calendlo"
require_relative "algo"
require "test/unit"
require "time"

class TestSuccess < Test::Unit::TestCase
  # def test_easy_test_case
  #   from = "2021-03-01T00:00:00Z"
  #   to = "2021-03-02T00:00:00Z"
  #   meeting_duration = 30
  #   preparation_duration = 0
  #   disponibility_list = [
  #     { day: 1, start: "08:00", end: "12:00" },
  #     { day: 1, start: "14:00", end: "18:00" },
  #     { day: 2, start: "08:00", end: "12:00" },
  #     { day: 2, start: "14:00", end: "18:00" },
  #     { day: 3, start: "08:00", end: "12:00" },
  #     { day: 3, start: "14:00", end: "18:00" },
  #     { day: 4, start: "08:00", end: "12:00" },
  #     { day: 4, start: "14:00", end: "18:00" },
  #     { day: 5, start: "08:00", end: "12:00" },
  #   ]

  #   unavailable_slots = [
  #     { start: "2021-03-01T08:00:00Z", end: "2021-03-01T09:00:00Z" },
  #     { start: "2021-03-01T14:00:00Z", end: "2021-03-01T19:15:00Z" },
  #   ]
  #   saturdays = []
  #   holidays = []

  #   calendlo = Calendlo.new(disponibility_list, unavailable_slots, saturdays, holidays)
  #   availability = calendlo.get_available_slots(from, to, meeting_duration, preparation_duration)
  #   assert_equal(2, availability.keys.length)
  #   assert_equal(11, availability["2021/03/01"].length)
  # end

  # def test_medium_test_case
  #   from = "2021-03-01T00:00:00Z"
  #   to = "2021-03-04T00:00:00Z"
  #   meeting_duration = 30
  #   preparation_duration = 5
  #   disponibility_list = [
  #     { day: 1, start: "08:00", end: "12:00" },
  #     { day: 1, start: "13:00", end: "17:30" },
  #     { day: 2, start: "08:00", end: "12:00" },
  #     { day: 2, start: "13:00", end: "17:30" },
  #     { day: 3, start: "08:00", end: "12:00" },
  #     { day: 3, start: "13:00", end: "17:30" },
  #   ]

  #   unavailable_slots =
  #     [{ name: "RDV #1",
  #        start: "2021-03-01T08:00:00Z",
  #        end: "2021-03-01T09:00:00Z" },
  #      { name: "RDV #2",
  #        start: "2021-03-01T15:00:00Z",
  #        end: "2021-03-01T16:00:00Z" },
  #      { name: "RDV #3",
  #        start: "2021-03-03T10:00:00Z",
  #        end: "2021-03-03T10:30:00Z" },
  #      { name: "RDV #4",
  #        start: "2021-03-03T11:10:00Z",
  #        end: "2021-03-03T12:00:00Z" },
  #      { name: "RDV #5",
  #        start: "2021-03-03T13:00:00Z",
  #        end: "2021-03-03T14:00:00Z" },
  #      { name: "RDV #6",
  #        start: "2021-03-03T14:45:00Z",
  #        end: "2021-03-03T17:00:00Z" }]

  #   saturdays = []
  #   holidays = [{ start: "2021-03-02", end: "2021-03-02" }]

  #   calendlo = Calendlo.new(disponibility_list, unavailable_slots, saturdays, holidays)
  #   availability =calendlo.get_available_slots(from, to, meeting_duration, preparation_duration)
  #   puts availability
  #   assert_equal(3, availability.keys.length)
  #   assert_equal(19, availability["2021/03/01"].length)
  # end

  def test_hard_test_case
    from = "2021-03-01T00:00:00Z"
    to = "2021-03-08T00:00:00Z"
    meeting_duration = 30
    preparation_duration = 5
    disponibility_list = [
      { day: 1, start: "08:00", end: "12:00" },
      { day: 1, start: "13:00", end: "17:30" },
      { day: 2, start: "08:00", end: "12:00" },
      { day: 2, start: "13:00", end: "17:30" },
      { day: 3, start: "08:00", end: "12:00" },
      { day: 3, start: "13:00", end: "17:30" },
      { day: 4, start: "08:00", end: "12:00" },
      { day: 4, start: "13:00", end: "17:30" },
    ]

    unavailable_slots =
      { name: "RDV #1",
        start: "2021-03-01T08:00:00Z",
        end: "2021-03-01T09:00:00Z" },
      { name: "RDV #2",
        start: "2021-03-01T15:00:00Z",
        end: "2021-03-01T16:00:00Z" },
      { name: "RDV #3",
        start: "2021-03-03T10:00:00Z",
        end: "2021-03-03T10:30:00Z" },
      { name: "RDV #4",
        start: "2021-03-03T11:10:00Z",
        end: "2021-03-03T12:00:00Z" },
      { name: "RDV #5",
        start: "2021-03-03T13:00:00Z",
        end: "2021-03-03T14:00:00Z" },
      { name: "RDV #6",
        start: "2021-03-03T14:45:00Z",
        end: "2021-03-03T17:00:00Z" },
      { name: "RDV #7",
        start: "2021-03-04T08:00:00Z",
        end: "2021-03-04T09:00:00Z" },
      { name: "RDV #8",
        start: "2021-03-04T08:30:00Z",
        end: "2021-03-04T10:00:00Z" },
      { name: "RDV #9",
        start: "2021-03-04T14:00:00Z",
        end: "2021-03-04T16:00:00Z" },
      { name: "RDV #10",
        start: "2021-03-04T15:00:00Z",
        end: "2021-03-04T15:30:00Z" }
    saturdays = [{
      start: "2021-03-06T08:00:00Z",
      end: "2021-03-06T16:00:00Z",
    }]
    holidays = [{ start: "2021-03-02", end: "2021-03-02" }]

    calendlo = Calendlo.new(disponibility_list, unavailable_slots, saturdays, holidays)
    availability = calendlo.get_available_slots(from, to, meeting_duration, preparation_duration)

    assert_equal(8, availability.keys.length)
    assert_equal("2021-03-01T09:15:00+00:00", availability["2021-03-01"][0])
    assert_equal("2021-03-04T10:15:00+00:00", availability["2021-03-04"][0])
    assert_equal(30, availability["2021-03-06"].length)
    assert_equal(0, availability["2021-03-07"].length)
    assert_equal(0, availability["2021-03-02"].length)
    assert_equal(0, availability["2021-03-05"].length)
  end
end

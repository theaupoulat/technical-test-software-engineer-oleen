require_relative "algo"
require "test/unit"
require "time"

class TestAlgo < Test::Unit::TestCase

  def test_same_day
    d_parsed = Time.parse("2020-07-11")
    d_not_parsed = "2020-07-11"

    dt_not_parsed = "2020-08-11T14:00:00Z"
    dt_parsed = Time.parse("2020-08-11T14:00:00Z")

    assert_equal(true, same_day?(d_parsed, d_not_parsed))
    assert_equal(true, same_day?(dt_parsed, dt_not_parsed))

    assert_equal(false, same_day?(dt_parsed, d_not_parsed))
    assert_equal(false, same_day?(d_parsed, dt_not_parsed))
  end

  def test_increments
    pointers = { p: 0 }
    increment_pointer(:p, pointers)
    assert_equal(1, pointers[:p])
  end

  def test_ensure_unavailable_slot_in_future
    pointers = { unavailable_slots: 0 }
    ref_time = Time.parse("2020-08-11T12:00:00Z")
    list_start_future = [{ start: "2020-08-11T14:00:00Z", end: "2020-08-11T14:03:00Z" }]
    list_end_future = [{ start: "2020-08-11T10:00:00Z", end: "2020-08-11T14:00:00Z" }]
    list_past = [{ start: "2020-08-11T10:00:00Z", end: "2020-08-11T11:00:00Z" }]

    ensure_unavailable_slot_in_the_future(ref_time, pointers, list_start_future)
    assert_equal(0, pointers[:unavailable_slots])
    ensure_unavailable_slot_in_the_future(ref_time, pointers, list_end_future)
    assert_equal(0, pointers[:unavailable_slots])
    ensure_unavailable_slot_in_the_future(ref_time, pointers, list_past)
    assert_equal(1, pointers[:unavailable_slots])
  end

  def test_ensure_saturday_in_future
    pointers = { saturdays: 0 }
    ref_time = Time.parse("2020-08-11T12:00:00Z")
    list_future = [{ start: "2021-03-06T08:00:00Z", end: "2021-03-06T16:00:00Z" }]
    list_past = [{ start: "2020-03-06T08:00:00Z", end: "2020-03-06T16:00:00Z" }]

    ensure_next_saturday_in_the_future(ref_time, pointers, list_future)
    assert_equal(0, pointers[:saturdays])
    ensure_next_saturday_in_the_future(ref_time, pointers, list_past)
    assert_equal(1, pointers[:saturdays])
  end

  def test_ensure_holiday_in_future
    pointers = { holidays: 0 }
    ref_time = Time.parse("2020-08-11T12:00:00Z")
    list_future = [{ start: "2020-06-01", end: "2020-07-07" }, { start: "2020-06-01", end: "2020-07-07" }, { start: "2020-09-01", end: "2020-10-07" }]
    list_past = [{ start: "2020-06-01", end: "2020-07-07" }]

    ensure_next_holiday_in_the_future(ref_time, pointers, list_future)
    assert_equal(2, pointers[:holidays])
    pointers[:holidays] = 0
    ensure_next_holiday_in_the_future(ref_time, pointers, list_past)
    assert_equal(1, pointers[:holidays])
  end

  def test_build_timetable
    disponibility_list = [
      { day: 1, start: "08:00", end: "12:00" },
      { day: 1, start: "14:00", end: "18:00" },
      { day: 2, start: "08:00", end: "12:00" },
      { day: 2, start: "14:00", end: "18:00" },
      { day: 3, start: "08:00", end: "12:00" },
      { day: 3, start: "14:00", end: "18:00" },
      { day: 4, start: "08:00", end: "12:00" },
      { day: 4, start: "14:00", end: "18:00" },
      { day: 5, start: "08:00", end: "12:00" },
    ]

    timetable = build_working_timetable(disponibility_list)
    assert_equal(5, timetable.keys.length)
    assert_equal(2, timetable[1].length)
    assert_equal(1, timetable[5].length)
  end

  def test_get_available_spots_with_preparation
    from = "2021-03-01T00:00:00Z"
    to = "2021-03-02T00:00:00Z"
    meeting_duration = 30
    preparation_duration = 15
    disponibility_list = [
      { day: 1, start: "08:00", end: "12:00" },
      { day: 1, start: "14:00", end: "18:00" },
      { day: 2, start: "08:00", end: "12:00" },
      { day: 2, start: "14:00", end: "18:00" },
      { day: 3, start: "08:00", end: "12:00" },
      { day: 3, start: "14:00", end: "18:00" },
      { day: 4, start: "08:00", end: "12:00" },
      { day: 4, start: "14:00", end: "18:00" },
      { day: 5, start: "08:00", end: "12:00" },
    ]

    unavailable_slots = [
      { start: "2021-03-01T08:00:00Z", end: "2021-03-01T09:00:00Z" },
      { start: "2021-03-01T14:00:00Z", end: "2021-03-01T19:15:00Z" },
    ]

    saturdays = [{ start: "2020-08-15T08:00:00Z", end: "2020-08-15T16:00:00Z" }]
    holidays = [{ start: "2020-08-11", end: "2020-08-11" }]

    availability = get_available_slots(from, to, meeting_duration, preparation_duration, disponibility_list, unavailable_slots, saturdays, holidays)
    puts availability
    assert_equal(10, availability["2021/03/01"].length)
  end

  def test_get_available_spots_with_holidays
    from = "2021-03-01T00:00:00Z"
    to = "2021-03-02T00:00:00Z"
    meeting_duration = 30
    preparation_duration = 0
    disponibility_list = [
      { day: 1, start: "08:00", end: "12:00" },
      { day: 1, start: "14:00", end: "18:00" },
      { day: 2, start: "08:00", end: "12:00" },
      { day: 2, start: "14:00", end: "18:00" },
      { day: 3, start: "08:00", end: "12:00" },
      { day: 3, start: "14:00", end: "18:00" },
      { day: 4, start: "08:00", end: "12:00" },
      { day: 4, start: "14:00", end: "18:00" },
      { day: 5, start: "08:00", end: "12:00" },
    ]

    unavailable_slots = [
      { start: "2021-03-01T08:00:00Z", end: "2021-03-01T09:00:00Z" },
      { start: "2021-03-01T14:00:00Z", end: "2021-03-01T19:15:00Z" },
    ]
    saturdays = [{ start: "2020-08-15T08:00:00Z", end: "2020-08-15T16:00:00Z" }]
    holidays = [{ start: "2021-02-11", end: "2021-03-11" }]

    availability = get_available_slots(from, to, meeting_duration, preparation_duration, disponibility_list, unavailable_slots, saturdays, holidays)
    puts availability
    assert_equal(0, availability.keys.length)
  end

  def test_get_available_spots_with_saturdays
    from = "2021-03-05T00:00:00Z"
    to = "2021-03-08T00:00:00Z"
    meeting_duration = 30
    preparation_duration = 0
    disponibility_list = [
      { day: 1, start: "08:00", end: "12:00" },
      { day: 1, start: "14:00", end: "18:00" },
      { day: 2, start: "08:00", end: "12:00" },
      { day: 2, start: "14:00", end: "18:00" },
      { day: 3, start: "08:00", end: "12:00" },
      { day: 3, start: "14:00", end: "18:00" },
      { day: 4, start: "08:00", end: "12:00" },
      { day: 4, start: "14:00", end: "18:00" },
      { day: 5, start: "08:00", end: "12:00" },
    ]

    unavailable_slots = [
      { start: "2021-03-01T08:00:00Z", end: "2021-03-01T09:00:00Z" },
      { start: "2021-03-01T14:00:00Z", end: "2021-03-01T19:15:00Z" },
    ]
    saturdays = [{ start: "2021-03-06T08:00:00Z", end: "2021-03-06T12:00:00Z" }]
    holidays = []

    availability = get_available_slots(from, to, meeting_duration, preparation_duration, disponibility_list, unavailable_slots, saturdays, holidays)
    puts availability
    assert_equal(3, availability.keys.length)
  end


end

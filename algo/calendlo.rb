require "time"
require "date"

class Calendlo
  @@slot_gap_constant = 15 * 60

  def initialize(disponibility, unavailable_slots, saturdays, holidays)
    @disponibilities = disponibility
    @unavailable_slots = unavailable_slots
    @saturdays = saturdays
    @holidays = holidays
    @pointers = {
      :holidays => 0,
      :saturdays => 0,
      :unavailable_slots => 0,
    }
  end

  def current_value_at_pointer(field)
    if field == :unavailable_slots
      return @unavailable_slots[@pointers[field]]
    end

    if field == :saturdays
      return @saturdays[@pointers[field]]
    end

    if field == :holidays
      return @holidays[@pointers[field]]
    end
  end

  def increment_pointer(field)
    if (@pointers[field])
      @pointers[field] += 1
    end
  end

  def is_time?(object)
    object.is_a?(Time)
  end

  def same_day?(date1, date2)
    if !date1 or !date2
      return false
    end
    # dates come as Time object or iso8601 date and time or date
    datetime1 = is_time?(date1) ? date1.to_date : Date.parse(date1)
    datetime2 = is_time?(date2) ? date2.to_date : Date.parse(date2)

    # maybe something better exists
    datetime1 == datetime2
  end

  def ensure_unavailable_slot_in_the_future(ref_time)
    # At slot allocation time, we assume that the pointer points to:
    curr = current_value_at_pointer(:unavailable_slots)

    # 1. Nothing: there are no available slots in the future
    if !curr
      return
    end

    # 2. An unavailable slot that starts in the future
    curr_start_after = Time.parse(curr[:start]) > ref_time

    # 3. An unavailable slot that ends in the future
    curr_end_after = Time.parse(curr[:end]) > ref_time
    if curr_start_after or curr_end_after
      return
    end

    @pointers[:unavailable_slots] += 1
    ensure_unavailable_slot_in_the_future(ref_time)
  end

  def ensure_next_saturday_in_the_future(ref_time)
    # At slot allocation time, we assume that the pointer points to:
    curr = current_value_at_pointer(:saturdays)

    # 1. Nothing: there are no worked saturdays in the future
    if !curr
      return
    end

    # 2. A worked saturday that starts in the future
    curr_start = Date.parse(curr[:start])

    if curr_start >= ref_time.to_date
      return
    end

    @pointers[:saturdays] += 1
    ensure_next_saturday_in_the_future(ref_time)
  end

  def ensure_next_holiday_in_the_future(ref_time)
    # At slot allocation time, we assume that the pointer points to:
    curr = current_value_at_pointer(:holidays)

    # 1. Nothing: there are no holidays in the future
    if !curr
      return
    end

    # 2. A holiday that ends in the future
    curr_end = Date.parse(curr[:end])

    if curr_end >= ref_time.to_date
      return
    end

    @pointers[:holidays] += 1
    ensure_next_holiday_in_the_future(ref_time)
  end

  def date_between?(date, from, to)
    date >= from && date <= to
  end

  def build_working_timetable()
    timetable = {}

    for disponibility in @disponibilities
      if timetable[disponibility[:day]]
        timetable[disponibility[:day]].append(disponibility)
      else
        timetable[disponibility[:day]] = [disponibility]
      end
    end

    timetable
  end

  def format_saturday_hours(saturday)
    [
      {
        start: Time.parse(saturday[:start]).strftime("%H:%M"),
        end: Time.parse(saturday[:end]).strftime("%H:%M"),
      },

    ]
  end

  def get_available_slots(from, to, meeting_duration, preparation_duration)
    working_timetable = build_working_timetable()
    start_dt = Date.parse(from)
    end_dt = Date.parse(to)

    available_slots = {}
    available_slots_arr = []

    (start_dt..end_dt).each do |date_to_parse|
      next if date_to_parse == start_dt && date_to_parse == end_dt

      # algo does not handle well different timezones
      date = Time.new(date_to_parse.year, date_to_parse.month, date_to_parse.day, 0, 0, 0, 0)

      # set pointers to closest dates in the future
      ensure_next_holiday_in_the_future(date)
      ensure_next_saturday_in_the_future(date)
      ensure_unavailable_slot_in_the_future(date)

      # create slots array for date
      date_formatted = date.strftime("%Y-%m-%d")
      slots_of_the_day = []

      closest_holidays_in_future = current_value_at_pointer(:holidays)
      closest_sat_in_future = current_value_at_pointer(:saturdays)

      # check if day is in a holiday spot
      # TODO implement date_between?
      # binding.pry if date_formatted == "2021-03-02"
      if closest_holidays_in_future && date_between?(date_to_parse, Date.parse(closest_holidays_in_future[:start]), Date.parse(closest_holidays_in_future[:end]))
        available_slots[date_formatted] = slots_of_the_day
        next
      end

      # check if day is worked

      # we suppose they do not work on sundays
      if date.sunday?
        available_slots[date_formatted] = slots_of_the_day
        next
      end

      # check if it is a worked saturday
      workable_saturday = date.saturday? && closest_sat_in_future && same_day?(date, closest_sat_in_future[:start])
      if date.saturday? && (!closest_sat_in_future || !workable_saturday)
        available_slots[date_formatted] = slots_of_the_day
        next
      end

      working_hours = workable_saturday ? format_saturday_hours(closest_sat_in_future) : working_timetable[date.wday]

      # check that there are working hours
      if !working_hours or working_hours.length == 0
        available_slots[date_formatted] = slots_of_the_day
        next
      end

      # iterate through each block
      for working_period in working_hours
        start_hour, start_minute = working_period[:start].split(":").map(&:to_i)
        end_hour, end_minute = working_period[:end].split(":").map(&:to_i)
        slot = date + start_hour * 3600 + start_minute * 60

        in_period = true
        first_slot = true

        while (in_period)
          start_out_of_period = slot.hour > end_hour || (slot.hour == end_hour && slot.min > end_minute)
          end_time_of_slot = slot + (meeting_duration * 60)
          end_out_of_period = end_time_of_slot.hour > end_hour || (end_time_of_slot.hour == end_hour && end_time_of_slot.min > end_minute)

          if start_out_of_period || end_out_of_period
            in_period = false
            break
          end

          # check if preparation_duration needed
          if preparation_duration > 0 && first_slot
            first_slot = false
            slot += @@slot_gap_constant
            next
          end

          start_of_slot_with_preparation = slot - preparation_duration * 60
          ensure_unavailable_slot_in_the_future(start_of_slot_with_preparation)
          next_unavailable = current_value_at_pointer(:unavailable_slots)

          formatted_slot = slot.round(0).iso8601
          # if no unavailability in the future, add availability directly
          if !next_unavailable
            slots_of_the_day.append(formatted_slot)
            slot += @@slot_gap_constant
            next
          end

          next_unavailable_start = Time.parse(next_unavailable[:start])
          next_unavailable_end = Time.parse(next_unavailable[:end])

          slot_starts_in_middle_of_next_unavailable = start_of_slot_with_preparation >= next_unavailable_start && start_of_slot_with_preparation < next_unavailable_end
          if slot_starts_in_middle_of_next_unavailable
            slot += @@slot_gap_constant
            next
          end

          end_of_slot = slot + (meeting_duration * 60)
          slot_ends_in_middle_of_next_unavailable = end_of_slot >= next_unavailable_start && end_of_slot < next_unavailable_end
          if slot_ends_in_middle_of_next_unavailable
            slot += @@slot_gap_constant
            next
          end

          # add slot to list of availables for the day
          slots_of_the_day.append(formatted_slot)

          # increment to check next slot
          slot += @@slot_gap_constant
        end
      end

      available_slots[date_formatted] = slots_of_the_day
    end
    return available_slots
  end
end

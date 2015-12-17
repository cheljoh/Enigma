

class Offsets

  attr_reader :a_key_rotation, :b_key_rotation, :c_key_rotation, :d_key_rotation,
  :a_offset, :b_offset, :c_offset, :d_offset

  def initialize(key, date, scale)
    @key = key.to_s
    @date = date
    init_key_rotations(scale)
    init_date_offsets(scale)
  end

  def init_key_rotations(scale)
    @a_key_rotation = scale * @key[0..1].to_i
    @b_key_rotation = scale * @key[1..2].to_i
    @c_key_rotation = scale * @key[2..3].to_i
    @d_key_rotation = scale * @key[3..4].to_i
  end

  def date_calculation
    formatted_date = @date.strftime("%d%m%y").to_i
    string_date = (formatted_date ** 2).to_s
    string_date[-4..-1]
  end

  def init_date_offsets(scale)
    date_offset = date_calculation
    @a_offset = scale * date_offset[0].to_i
    @b_offset = scale * date_offset[1].to_i
    @c_offset = scale * date_offset[2].to_i
    @d_offset = scale * date_offset[3].to_i
  end
end

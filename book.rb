class Book
  @@on_shelf = []
  @@on_loan = []

  LOAN_TERM = 21 * (24 * 60 * 60)

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  def isbn
    return @isbn
  end

  def due_date
    return @due_date
  end

  def on_hold?
    return @on_hold
  end

  def due_date=(due_date)
    return @due_date = due_date
  end

  def borrow
    if !self.lent_out?
      self.due_date = Book.current_due_date
      @@on_loan << self
      @@on_shelf.delete(self)
      return true
    else
      return false
    end
  end

  def renew
    if self.lent_out? && !self.on_hold?
      self.due_date = self.due_date + LOAN_TERM
      return true
    else
      return false
    end
  end

  def hold
    if self.lent_out?
      @on_hold = true
      return true
    else
      return false
    end
  end

  def return_to_library
    if self.lent_out?
      self.update_due_date(nil)
      @@on_shelf << self
      @@on_loan.delete(self)
      return true
    else
      return false
    end
  end

  def lent_out?
    @@on_loan.each do |loan_x|
      if @isbn == loan_x.isbn
        return true
      end
    end
    return false
  end

  def update_due_date(new_due_date)
    @due_date = new_due_date
  end

  def self.create(title, author, isbn)
    new_book = Book.new(title, author, isbn)
    @@on_shelf << new_book
    return new_book
  end

  def self.current_due_date
    Time.now + LOAN_TERM
  end

  def self.overdue
    overdue_list = []
    current_date = Time.now
    @@on_loan.each do |loan_x|
      if loan_x.due_date < current_date
        overdue_list << loan_x
      end
    end
    return overdue_list
  end

  def self.browse
    number_of_book = @@on_shelf.length
    item_pick = Random.rand(number_of_book - 1)
    return @@on_shelf[item_pick]
  end

  def self.available
    return @@on_shelf
  end

  def self.borrowed
    return @@on_loan
  end

end

sister_outsider = Book.create("Sister Outsider", "Audre Lorde", "9781515905431")
aint_i = Book.create("Ain't I a Woman?", "Bell Hooks", "9780896081307")
if_they_come = Book.create("If They Come in the Morning", "Angela Y. Davis", "0893880221")
puts Book.browse.inspect # #<Book:0x00555e82acdab0 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221"> (this value may be different for you)
puts Book.browse.inspect # #<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307"> (this value may be different for you)
puts Book.browse.inspect # #<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307"> (this value may be different for you)
puts Book.available.inspect # [#<Book:0x00555e82acde20 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431">, #<Book:0x00555e82acdce0 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00555e82acdab0 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">]
puts Book.borrowed.inspect # []
puts sister_outsider.lent_out? # false
puts sister_outsider.borrow # true
puts sister_outsider.lent_out? # true
puts sister_outsider.borrow # false
puts sister_outsider.due_date # 2017-02-25 20:52:20 -0500 (this value will be different for you)

puts sister_outsider.renew # Stretch goals: 1
puts sister_outsider.due_date # renewed due date

puts sister_outsider.hold # Stretch goals: 2
puts sister_outsider.renew #
puts sister_outsider.due_date # renewed due date

puts Book.available.inspect # [#<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00562314675fd8 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">]
puts Book.borrowed.inspect # [#<Book:0x00562314676208 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431", @due_date=2017-02-25 20:55:17 -0500>]
puts Book.overdue.inspect # []
puts sister_outsider.return_to_library # true
puts sister_outsider.lent_out? # false
puts Book.available.inspect # [#<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00562314675fd8 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">, #<Book:0x00562314676208 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431", @due_date=nil>]
puts Book.borrowed.inspect # []

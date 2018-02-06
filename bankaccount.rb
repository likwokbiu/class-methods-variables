class BankAccount
  @@interest_rate = 1.0
  @@accounts = []

  def initialize
    @balance = 0
  end

  def balance
    return @balance
  end

  def interest_rate
    return @@interest_rate
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    if @balance >= amount
      @balance -= amount
    else
      puts "Not enough money in this account!"
    end
  end

  def self.create
    new_account = BankAccount.new
    @@accounts << new_account
    return new_account
  end

  def self.total_funds
    total = 0.0
    @@accounts.each do |account_x|
      total += account_x.balance
    end
    return total
  end

  def self.interest_time
    @@accounts.each do |account_x|
      account_x.get_interest
    end
  end

  def get_interest
    @balance += @balance * (@@interest_rate / 100)
  end

end

my_account = BankAccount.create
your_account = BankAccount.create
puts my_account.balance # 0
puts BankAccount.total_funds # 0
my_account.deposit(200)
your_account.deposit(1000)
puts my_account.balance # 200
puts your_account.balance # 1000
puts BankAccount.total_funds # 1200
BankAccount.interest_time
puts my_account.balance # 202.0
puts your_account.balance # 1010.0
puts BankAccount.total_funds # 1212.0
my_account.withdraw(50)
puts my_account.balance # 152.0
puts BankAccount.total_funds # 1162.0

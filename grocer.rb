require "pry"

def consolidate_cart(cart)
  new_hash = Hash.new(0)
  array = []
  cart.each {|h| new_hash[h] += 1}
  new_hash.each do |key, value|
    key.each do |x,y|
      y[:count] = new_hash[key]
    end
    array << key
  end
  array = array.inject(:merge!)
  #binding.pry
end

def apply_coupons(cart, coupons)
  coupons.map do |couphash|
    if cart.has_key?("#{couphash[:item]} W/COUPON")
      cart["#{couphash[:item]} W/COUPON"][:count] += 1
      cart[couphash[:item]][:count] -= couphash[:num]
    elsif cart.has_key? couphash[:item]
      cart[couphash[:item]][:count] -= couphash[:num]
      cart["#{couphash[:item]} W/COUPON"] = {
        :price => couphash[:cost],
        :clearance => cart[couphash[:item]][:clearance],
        :count => 1
      }
      #binding.pry
    end
  end
  cart
end

def apply_clearance(cart)
  cart.map do |x|
    if x[1][:clearance] then x[1][:price] += x[1][:price] * .20
  end
end

def checkout(cart, coupons)
  # code here
end

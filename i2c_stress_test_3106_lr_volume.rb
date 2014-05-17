#0x1b 0x2b 0x01
$BUS=1
$REG=0x1b
$ADD=0x2b

def write bus=$BUS, reg=$reg, add=$ADD, val=0
	`i2cset -f -y #{bus} #{reg} #{add} #{val}`
	$?.to_i == 0	
end

def read bus=$BUS, reg=$reg, add=$ADD
	(`i2cget -f -y #{bus} #{reg} #{add}`).strip.to_i(16)
end


999999.times do |i|
	rand_val1 = rand(256)
	rand_val2 = rand(256)
	write 1, 0x1b, 0x2b, rand_val1  #left ch
	write 1, 0x1b, 0x2c, rand_val2 #right ch
	read_val1 = read 1, 0x1b, 0x2b 
	read_val2 = read 1, 0x1b, 0x2c 
	if read_val1 == rand_val1  and read_val2 == rand_val2
		puts "#{i} times i2c IO success"
	else
		puts "#{i}th time i2c IO failed, written #{rand_val1} #{rand_val2}, read is #{read_val1} #{read_val2}"
		exit 1
	end

end

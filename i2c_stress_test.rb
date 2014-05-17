$BUS=1
$REG=0x50
$ADD=0x04

def write val
	`i2cset -f -y #{$BUS} #{$REG} #{$ADD} #{val}`
	$?.to_i == 0	
end

def read
	(`i2cget -f -y #{$BUS} #{$REG} #{$ADD}`).strip.to_i(16)
end


999999.times do |i|
	rand_val = rand(256)
	write rand_val
	read_val = read 
	if read_val == rand_val
		puts "#{i} times i2c IO success"
	else
		puts "#{i}th time i2c IO failed, written #{rand_val}, read is #{read_val}"
		exit 1
	end

end

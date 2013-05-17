class MassObject

	def self.new(p = {})
		super
	end

	def initialize(p = {})
		p.each do |attr, val|
			if self.class.attributes.include?(attr.to_sym)
				self.send("#{attr}=", val)
			else
				raise "mass assignment to unregistered attribute #{attr}"
			end
		end
	end

	def self.set_attrs(*attributes)
		@attributes = attributes

		attributes.each do |attr|
			self.send(:attr_accessor, attr)
		end
	end

	def self.attributes
		@attributes
	end

end

class MyClass < MassObject
	set_attrs :x, :y
end



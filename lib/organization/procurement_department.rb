#Represents an operational division in an organization 
class Organization::ProcurementDepartment
	attr_reader :cash, :inventory
	def initialize(name, cash, inventory, categories)
		@name = name
		@cash = cash
		@inventory = inventory
		@categories = categories
	end

	def inventory_by_colour(colour)
		if @categories && @categories["colour"] == colour
			@inventory
		else
			0
		end
	end

	def inventory_of_black_and_not_jeans_or_t_shirts
		if @categories && @categories["colour"] == "black" && @categories["garment_subtype"] != "jeans" && @categories["garment_subtype"] != "t_shirt"
			@inventory
		else
			0
		end
	end


	def inventory_of_less_funding_dept_of_given_colour(colour, funding)
		if @categories && @categories["colour"] == colour && @cash < funding
			@inventory
		else
			0
		end
	end


end
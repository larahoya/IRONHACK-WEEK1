
class DataStructure

	def self.data_array
		arr = [
			{:arr => [1,2,3]},
			{:arr => [4,5,6]},
			{:arr => [7,8,9]}
		]
	end

end

da = DataStructure.data_array

arr = [[0,1,2,3,4,{:secret=>{:unlock=>[0,"Hola"]}}],1]

puts arr[0][5][:secret][:unlock][1]
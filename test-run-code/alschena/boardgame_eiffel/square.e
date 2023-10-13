note
	description: "This class handles the representation of squares in the board."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SQUARE

create
	set_id

feature -- Access

	id: INTEGER
			-- `id'
feature -- Element change

	set_id (new_id: like id)
			-- `make'
		require
			id_positive: new_id > 0
		do
			id := new_id
		ensure
			id_assigned: id = new_id
		end

invariant
	id_positive: id > 0

end

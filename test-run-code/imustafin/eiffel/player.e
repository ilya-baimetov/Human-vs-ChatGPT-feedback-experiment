class
	PLAYER

create
	make

feature
	make (a_hp, a_max_hp: INTEGER; a_name: STRING)
		do
			hp := a_hp
			max_hp := a_max_hp
			name := a_name
		end

feature
	hp: INTEGER
	max_hp: INTEGER
	name: STRING

feature
	heal (amount: INTEGER)
		do
			hp := max_hp.min (hp + amount)
		end

	damage (amount: INTEGER)
		do
			hp := hp - amount
		end

invariant
	hp <= max_hp
end

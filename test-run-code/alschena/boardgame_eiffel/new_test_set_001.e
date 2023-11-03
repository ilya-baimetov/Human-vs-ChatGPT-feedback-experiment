note
	description: "Generated tests created by AutoTest."
	author: "Testing tool"

class
	NEW_TEST_SET_001
	
inherit
	EQA_GENERATED_TEST_SET

feature -- Test routines

	generated_test_1
		note
			testing: "type/generated"
			testing: "covers/{GAME}.roll_dice"
		local
			v_2: GAME
		do
			execute_safe (agent: GAME
				do
					create {GAME} Result.make
				end)
			check attached {GAME} last_object as l_ot1 then
				v_2 := l_ot1
			end
			execute_safe (agent v_2.make)

				-- Final routine call
			set_is_recovery_enabled (False)
			execute_safe (agent v_2.roll_dice)
		end

end


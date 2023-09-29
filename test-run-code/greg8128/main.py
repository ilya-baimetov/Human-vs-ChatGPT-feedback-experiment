from collections import namedtuple
from random import randrange

## Notes

# We want to be able to test:
# Correctness of game states (and transitions)
# Correctness of RNG
# We separate RNG to facilitate testing

class player:
    name = ""
    hp = 15
    posn = 1
    def __init__(self, nname):
        self.name = nname
    def __init__(self, nname, npos = 1, nhp = 15):
        self.name = nname
        self.posn = npos
        self.hp = nhp
    def __str__(self):
        return f'{self.name} (position: {self.posn}, hp: {self.hp})'

class game_state:
    alive = []
    dead = []
    cpidx = 0
    def __init__(self, plrs):
        self.alive = plrs
        self.dead = []
        self.cpidx = 0
        
newgame = lambda pns: game_state([player(pn) for pn in pns])

ALL_DEAD = 'All dead'
WON = 'Someone won'
CONT = 'Continue'

rolld6 = lambda:  randrange(6) + 1
roll2d6 = lambda:  rolld6() + rolld6()

def transition(gs, roll):
    plr = gs.alive[gs.cpidx]
    plr.posn += roll
    if plr.posn % 10 == 0:
        plr.hp -= 5
    if plr.posn % 10 == 5:
        plr.hp += 5
        plr.hp = min(plr.hp, 15)
    if plr.hp <= 0:
        del gs.alive[gs.cpidx]
        gs.dead.append(plr)
        if len(gs.alive) == 0:
            return ALL_DEAD
    else:
        gs.cpidx += 1
    gs.cpidx %= len(gs.alive)
    if plr.posn > 50:
        return WON 
    return CONT
    
def printgame(gs):
    print ('Alive:')
    for plr in gs.alive:
        print (f'  {plr}')
    print('Dead:')
    for plr in gs.dead:
        print (f'  {plr}')
        
        
## tests 

testgame = game_state([player("a", 47, 10)])
assert(transition(testgame, 6) == WON)

testgame = game_state([player("a", 37, 5)])
assert(transition(testgame, 3) == ALL_DEAD)

testgame = game_state([player("a", 37, 5), player("b", 20, 10)])
transition(testgame, 3)
assert(testgame.alive[testgame.cpidx].name == "b")

## Check distribution. it should look something like 
# {2: 1000, 3:2000, 4:3000, 5:4000, 6:5000, 7:6000, 8:5000,9:4000, 10:3000, 11:2000, 12:1000}
# allowing for variation due to randomness
# this test takes time so it's commented out by default
# rolls = 36_000
# d = {}
# for i in range(rolls):
#     roll = roll2d6()
#     try:
#         d[roll2d6()] += 1
#     except:
#         d[roll2d6()] = 1
# print(d)


game = newgame(["Alice", "Bob", "Carl"])
end = False
while not end:
    roll = roll2d6()
    res = transition(game, roll)
    if res != CONT:
        end = True
printgame(game)
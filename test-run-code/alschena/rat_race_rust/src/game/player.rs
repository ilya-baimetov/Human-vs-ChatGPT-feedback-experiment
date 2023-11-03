#[derive(Debug, PartialEq, Eq, Hash, Clone)]
pub struct Player {
    hp: u32,
    alive: bool,
    name: String,
}

impl Player {
    pub fn new(name: String) -> Player {
        Player {
            hp: 15,
            alive: true,
            name,
        }
    }
    pub fn is_alive(&self) -> bool {
        self.alive
    }
    pub fn get_hp(&self) -> u32 {
        self.hp
    }
    pub fn get_name(&self) -> &String {
        &self.name
    }

    pub fn fall_in_trap(&mut self) {
        if self.hp < 5 {
            self.alive = false;
            return;
        } else {
            self.hp = self.hp - 5;
        }
    }
    pub fn heal(&mut self) {
        if self.hp >= 10 {
            self.hp = 15
        } else {
            self.hp = self.hp + 5;
        }
    }
}

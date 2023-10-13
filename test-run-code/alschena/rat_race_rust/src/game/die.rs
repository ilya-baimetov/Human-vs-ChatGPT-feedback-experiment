use rand;
use rand::Rng;
#[derive(Debug)]
pub struct Die {
    pub last_roll: usize,
}

impl Die {
    pub fn new() -> Die {
        let last_roll = 0;
        Die { last_roll }
    }
    pub fn roll_die(&mut self) {
        let random_extraction: usize = rand::thread_rng().gen_range(1..7);
        self.last_roll = random_extraction;
    }
}

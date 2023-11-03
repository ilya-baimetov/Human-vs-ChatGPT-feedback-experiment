mod square;
use crate::game::die::Die;
use crate::game::player::Player;
use square::Square;
use std::fmt;
#[derive(Debug)]
pub struct Board {
    pub placement: Vec<(Player, Option<Square>)>,
    dice: Vec<Die>,
}

impl Board {
    pub fn new() -> Board {
        let placement = Vec::new();
        let dice = Vec::new();
        Board { placement, dice }
    }
    pub fn init_placement(&mut self, players: Vec<Player>) {
        self.placement = players
            .into_iter()
            .map(|player| (player, Some(Square::new(0))))
            .collect();
    }
    pub fn init_dice(&mut self) {
        let num_dice = 2;
        self.dice = (0..num_dice).map(|_| Die::new()).collect();
    }
}

impl Board {
    pub fn move_players(&mut self) {
        self.placement
            .iter_mut()
            .filter(|(player, _)| player.is_alive())
            .for_each(|(_, square)| {
                let position = square.expect("Player already beyond board").get_id();
                let steps: usize = self
                    .dice
                    .iter_mut()
                    .map(|die| {
                        die.roll_die();
                        die.last_roll
                    })
                    .sum();
                let new_position = position + steps;
                if new_position > 0 && new_position < 50 {
                    *square = Some(Square::new(new_position));
                } else {
                    *square = None;
                }
            });
    }
    pub fn execute_effect_squares(&mut self) {
        self.placement
            .iter_mut()
            .filter(|(player, position)| player.is_alive() && position.is_some())
            .for_each(|(player, square)| {
                match square.expect("Player already beyond board").get_id() {
                    5 | 15 | 25 | 35 | 45 => player.heal(),
                    10 | 20 | 30 | 40 | 50 => player.fall_in_trap(),
                    _ => {}
                };
            });
    }
}

impl fmt::Display for Board {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        for (player, position) in self.placement.iter() {
            match player.is_alive() {
                true => match position {
                    None => write!(
                        f,
                        "{}:\n\t{}\n\tThe player is beyond the board.\n",
                        player.get_name(),
                        player.get_hp()
                    )?,
                    Some(position) => write!(
                        f,
                        "{}\n\t{}\n\t{}\n",
                        player.get_name(),
                        player.get_hp(),
                        position.id
                    )?,
                },
                false => write!(
                    f,
                    "{}:\n\tDied in during the rat race.\n",
                    player.get_name()
                )?,
            }
        }
        Ok(())
    }
}

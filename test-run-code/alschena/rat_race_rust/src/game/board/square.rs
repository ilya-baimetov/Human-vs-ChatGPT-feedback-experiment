#[derive(Debug, Clone, Copy)]
pub struct Square {
    pub id: usize,
}

impl Square {
    pub fn new(id: usize) -> Square {
        Square { id }
    }
    pub fn get_id(&self) -> usize {
        self.id
    }
}

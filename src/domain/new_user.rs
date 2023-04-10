use crate::domain::UserEmail;
use crate::domain::UserName;

pub struct NewUser {
    pub email: UserEmail,
    pub username: UserName,
}

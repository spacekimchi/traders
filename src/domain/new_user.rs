use crate::domain::UserEmail;
use crate::domain::UserName;

pub struct NewUser {
    // We are not using `String` anymore!
    pub email: UserEmail,
    pub username: UserName,
}

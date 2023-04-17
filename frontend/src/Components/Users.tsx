import React from 'react'
import UserTable from './UserTable'

const Users = () => {
  const displayedUsers = [
    { username: 'Tobit Jessup', email: 'tjessup0@w3.org' },
    { username: 'Debby Aucourte', email: 'daucourte1@mail.ru' },
    { username: 'Phyllys Yurivtsev', email: 'pyurivtsev2@soup.io' },
    { username: 'Gal Sheirlaw', email: 'gsheirlaw3@harvard.edu' },
    { username: 'Warner Iamittii', email: 'wiamittii4@yahoo.co.jp' },
    { username: 'Lillis McGorley', email: 'lmcgorley5@hibu.com' },
    { username: 'Twila Mugg', email: 'tmugg6@howstuffworks.com' },
    { username: 'Geralda Lammie', email: 'glammie7@yale.edu' },
    { username: 'Julio Anster', email: 'janster8@blogs.com' },
    { username: 'Francyne Petrolli', email: 'fpetrolli9@constantcontact.com' }
  ]

  return <UserTable users={displayedUsers} />
}

export default Users

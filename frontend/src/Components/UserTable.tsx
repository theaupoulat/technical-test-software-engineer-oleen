import React from 'react'
import styled from 'styled-components'
import tw from 'twin.macro'

const Table = styled.table`
  ${tw`table-auto text-left`}
  & {
    tr {
      ${tw`font-light`}
    }
  }
`

interface User {
  username: string
  email: string
}

interface UserTableProps {
  users: Array<User>
}

const UserTable = ({ users }: UserTableProps) => (
  <Table>
    <thead>
      <tr>
        <th>Nom</th>
        <th>Email</th>
      </tr>
    </thead>
    <tbody>
      {users.map((user, index) => (
        <tr key={index}>
          <td>{user.username}</td>
          <td>{user.email}</td>
        </tr>
      ))}
    </tbody>
  </Table>
)

export default UserTable

import React, { useState, useEffect } from 'react'
import { grpc } from '@improbable-eng/grpc-web'
import { NodeHttpTransport } from '@improbable-eng/grpc-web-node-http-transport'
import { UserServiceClient } from '../proto/pretto/v1/user_pb_service'
import { FetchAllRequest, User } from '../proto/pretto/v1/user_pb'
import TextField from './TextField'
import UserTable from './UserTable'

grpc.setDefaultTransport(NodeHttpTransport())
const userService = new UserServiceClient('http://localhost:3000/grpc')

const Users = () => {
  const [users, setUsers] = useState([] as User.AsObject[])
  const [displayedUsers, setDisplayedUsers] = useState([] as User.AsObject[])
  const [textFieldValue, setTextFieldValue] = useState('')

  const fetchUsers = () => {
    const fetchAllRequest = new FetchAllRequest()
    userService.fetchAll(fetchAllRequest, (err, res) => {
      if (err !== null) {
        console.log(err)
      }
      if (res !== null) {
        setUsers(res.getUsersList().map((user) => user.toObject()))
      }
    })
  }

  useEffect(() => {
    fetchUsers()
  }, [])

  useEffect(() => {
    setDisplayedUsers(users)
  }, [users])

  useEffect(() => {
    if (textFieldValue === '') {
      setDisplayedUsers(users)
    }
    setDisplayedUsers(users.filter((u) => u.username.includes(textFieldValue)))
  }, [textFieldValue])

  const handleTextFieldChange = (
    event: React.ChangeEvent<HTMLInputElement>
  ) => {
    setTextFieldValue(event.currentTarget.value)
  }

  return (
    <div>
      <TextField
        onChange={handleTextFieldChange}
        value={textFieldValue}
        placeholder="Search..."
        subClassName="bg-black"
      />
      <UserTable users={displayedUsers} />
    </div>
  )
}

export default Users

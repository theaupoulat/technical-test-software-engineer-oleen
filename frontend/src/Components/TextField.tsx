// import { MagnifyingGlassLeft } from '@pretto/picto'
import React from 'react'
import styled from 'styled-components'
import tw from 'twin.macro'

const TextFieldContainer = styled.span``

const TextFieldInput = styled.input``

interface TextFieldProps extends React.InputHTMLAttributes<HTMLInputElement> {
  onChange: React.ChangeEventHandler
  value: string
  subClassName: string
}

const TextField = ({ className, subClassName, ...props }: TextFieldProps) => (
  <TextFieldContainer className={className}>
    <TextFieldInput className={subClassName} {...props} />
  </TextFieldContainer>
)

export default TextField

import React from 'react'
import { SlotsTable } from './Components/SlotsTable'
import './index.css'
function App() {
  return (
    <div className="flex align-middle justify-items-center h-full w-full absolute  font-sans  text-neutral-1">
      <div className=" m-auto w-3/5 mt-52 bg-white rounded-lg py-8 px-16">
        <p className="text-3xl font-extrabold">Prenez rendez-vous</p>
        <p>
          Choisissez une heure de rendez-vous pour echanger par telephone avec
          un expert.
          <br />
          L&apos;echange durera
          <span className="font-bold"> 30 minutes.</span>
        </p>
        <SlotsTable />
      </div>
    </div>
  )
}

export default App

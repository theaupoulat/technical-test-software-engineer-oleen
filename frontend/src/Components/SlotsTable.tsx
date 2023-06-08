import * as React from 'react'
import './SlotsTable.css'
import {
  ColumnDef,
  createColumnHelper,
  flexRender,
  getCoreRowModel,
  useReactTable
} from '@tanstack/react-table'
import {
  Column,
  dataSample,
  dataSampleHard,
  transformData
} from '../utils/format'
import { useMemo } from 'react'

export type Slot = {
  time?: string
  data: any[]
}

const columnHelper = createColumnHelper<Slot>()

const slotComp = (pers: Slot) => {
  return (
    <div className="bg-green-2 hover:bg-green-1 px-6 py-2 rounded-md mx-3 w-16 flex align-middle justify-center">
      {pers.time}
    </div>
  )
}

const noSlotComp = () => {
  return (
    <div className="400 px-6 py-2 rounded-md mx-3 w-16 flex align-middle justify-center  text-xl text-neutral-2">
      -
    </div>
  )
}

const createColumnObject = (columnsData: Column[]) => {
  return columnsData.map((column) => {
    return columnHelper.accessor((row) => row.data, {
      id: 'col' + column.accessor,
      cell: (info) =>
        info.getValue()[column.accessor]
          ? slotComp(info.row.original)
          : noSlotComp(),
      header: () => (
        <span className="text-sm">
          {column.header.dow} <br /> {column.header.date}
        </span>
      )
    })
  })
}

export const SlotsTable = () => {
  const { rows: rowsData, columns: columnsData } = useMemo(
    () => transformData(dataSampleHard),
    [dataSampleHard]
  )
  const [data, setData] = React.useState(() => [...rowsData])
  const [visbibleRowsRandge, setVisibleRowsRange] = React.useState([0, 10])

  const table = useReactTable({
    data,
    columns: createColumnObject(columnsData),
    getCoreRowModel: getCoreRowModel()
  })

  const getVisibleRows = () => {
    return table.getRowModel().rows.slice(...visbibleRowsRandge)
  }

  const incrementVisibleRows = () => {
    setVisibleRowsRange((prev) => {
      if (prev[1] === data.length) {
        return prev
      }

      if (prev[1] + 10 > data.length) {
        return [prev[0], data.length]
      }

      return [prev[0], prev[1] + 10]
    })
  }

  return (
    <div className="mt-4">
      <table className="border-neutral-2 border-separate border-spacing-0 rounded-md overflow-hidden">
        <thead className="bg-neutral-3 border-none">
          {table.getHeaderGroups().map((headerGroup) => (
            <tr key={headerGroup.id} className=" ">
              {headerGroup.headers.map((header) => (
                <th key={header.id} className="border-x-0 py-2">
                  {header.isPlaceholder
                    ? null
                    : flexRender(
                        header.column.columnDef.header,
                        header.getContext()
                      )}
                </th>
              ))}
            </tr>
          ))}
        </thead>

        <tbody>
          {}
          {getVisibleRows().map((row) => (
            <tr key={row.id} className="py-4">
              {row.getVisibleCells().map((cell) => (
                <td key={cell.id} className="">
                  {flexRender(cell.column.columnDef.cell, cell.getContext())}
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
      <div className="h-4" />

      <button
        onClick={() => incrementVisibleRows()}
        className="border border-blue-1  hover:bg-blue-2 rounded-lg px-2 py-1"
      >
        <span className="text-blue-1 text-sm">Afficher plus de creneaux</span>
      </button>
    </div>
  )
}

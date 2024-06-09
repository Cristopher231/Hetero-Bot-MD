let handler = async (m, { conn, usedPrefix, command, text }) => {

/*const messages = [
['Descripción 1', 'Footer 1', 'https://telegra.ph/file/b31cd03f716d362b33716.jpg', [], '', [], []],
['Descripción 2', 'Footer 2', 'https://telegra.ph/file/98c672926fbc35a4b9948.jpg', [], '', [], []],
['Descripción 3', 'Footer 3', 'https://telegra.ph/file/f689a972cfc1c5efff189.jpg', [], '', [], []],
]*/

const messages = [
  [
    'Descripción 1',
    'Footer 1',
    'https://telegra.ph/file/b31cd03f716d362b33716.jpg',
    [['Botón A', 'idA'], ['Botón B', 'idB']],
    'Texto para copiar 1',
    [['Enlace 1', 'https://example.com/link1'], ['Enlace 2', 'https://example.com/link2']],
    [
      'Lista 1', // Título de la lista
      [ // Sección de la lista
        { // Elemento de la lista
          'Header opción 1', // Título del elemento
          [ // Filas del elemento
            {
              'Header opción 1', // Encabezado de la fila
              'Opción 1', // Título de la fila
              'Descripción opción 1', // Descripción de la fila
              'id_opcion_1' // ID de la fila
            }
          ]
        },
        { // Otro elemento de la lista
          'Header opción 2', // Título del elemento
          [ // Filas del elemento
            {
              'Header opción 2', // Encabezado de la fila
              'Opción 2', // Título de la fila
              'Descripción opción 2', // Descripción de la fila
              'id_opcion_2' // ID de la fila
            }
          ]
        }
      ]
    ]
  ],
  [
    'Descripción 2',
    'Footer 2',
    'https://telegra.ph/file/98c672926fbc35a4b9948.jpg',
    [['Botón C', 'idC'], ['Botón D', 'idD']],
    'Texto para copiar 2',
    [['Enlace 3', 'https://example.com/link3'], ['Enlace 4', 'https://example.com/link4']],
    [
      'Lista 2', // Título de la lista
      [ // Sección de la lista
        { // Elemento de la lista
          'Header opción 3', // Título del elemento
          [ // Filas del elemento
            {
              'Header opción 3', // Encabezado de la fila
              'Opción 3', // Título de la fila
              'Descripción opción 3', // Descripción de la fila
              'id_opcion_3' // ID de la fila
            }
          ]
        },
        { // Otro elemento de la lista
          'Header opción 4', // Título del elemento
          [ // Filas del elemento
            {
              'Header opción 4', // Encabezado de la fila
              'Opción 4', // Título de la fila
              'Descripción opción 4', // Descripción de la fila
              'id_opcion_4' // ID de la fila
            }
          ]
        }
      ]
    ]
  ]
]


await conn.sendCarousel(m.chat, 'Prueba', 'SuperBot', messages, m)

}

handler.command = /^(carousel)$/i
export default handler
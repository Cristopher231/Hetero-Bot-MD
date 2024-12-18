import yaoiImages from 'module-gatadios'

let handler = async (m, { conn }) => {
  try {
    const resultJson = yaoiImages.getRandomImage()
    
    // Validar que existe la respuesta
    if (!resultJson) throw new Error('No se pudo obtener la imagen')

    // Validar propiedades necesarias
    const name = resultJson.name || 'Sin nombre'
    const author = resultJson.author || 'Autor desconocido' 
    const description = resultJson.description || 'Sin descripción'

    let txt = `
Nombre: ${name}
Autor: ${author}
Descripción: ${description}`

    // Asumiendo que sendMessage es el método correcto
    await conn.sendMessage(m.chat, {
      image: {url: resultJson.link}, 
      caption: txt.trim()
    }, {quoted: m})

  } catch (error) {
    console.error(error)
    m.reply('Ocurrió un error al procesar la solicitud')
  }
}

handler.command = /^(prueba36)$/i
export default handler

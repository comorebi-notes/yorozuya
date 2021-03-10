// テキストエリアのサイズを動的に調整

document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('.js-dynamic-textarea').forEach((textarea) => {
    adjustHeight(textarea)
    textarea.addEventListener('input', (e) => adjustHeight(e.target))
  })
})

const adjustHeight = (textarea) => {
  textarea.style.height = 'auto'
  textarea.style.height = `${textarea.scrollHeight}px`
}

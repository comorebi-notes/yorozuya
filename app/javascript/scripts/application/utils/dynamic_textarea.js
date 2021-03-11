// テキストエリアのサイズを動的に調整

document.addEventListener('turbolinks:load', () => {
  const adjustHeight = (textarea) => {
    const borderWidth = textarea.offsetHeight - textarea.clientHeight
    textarea.style.height = 'auto'
    textarea.style.height = `${textarea.scrollHeight + borderWidth}px`
  }
  document.querySelectorAll('.js-dynamic-textarea').forEach((textarea) => {
    adjustHeight(textarea)
    textarea.oninput = (e) => adjustHeight(e.target)
    textarea.onchange = (e) => adjustHeight(e.target)
  })
})

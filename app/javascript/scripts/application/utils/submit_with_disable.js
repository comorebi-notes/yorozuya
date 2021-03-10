// <button type="submit"> に data-disable-with を自動で設定

document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('button[type=submit]').forEach((button) => {
    if (!button.getAttribute('data-disable-with')) {
      button.setAttribute('data-disable-with', button.innerHTML)
    }
  })
})

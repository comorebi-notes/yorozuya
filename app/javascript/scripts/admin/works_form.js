document.addEventListener('turbolinks:load', () => {
  const workCreatorFields = document.querySelector('.js-work-creator-fields')
  if (workCreatorFields) {
    workCreatorFields.addEventListener('change', (e) => {
      const target = e.target
      if (Array.from(target.classList).includes('js-guest-checkbox')) {
        const nameField = target.closest('.js-guest-checkbox-wrapper').parentNode.querySelector('.js-name-field-wrapper .js-name-field')
        const creatorSelect = target.closest('.js-guest-checkbox-wrapper').parentNode.querySelector('.js-creator-select-wrapper .js-creator-select')
        if (target.checked) {
          nameField.removeAttribute('disabled')
          creatorSelect.setAttribute('disabled', 'disabled')
        } else {
          nameField.setAttribute('disabled', 'disabled')
          creatorSelect.removeAttribute('disabled')
        }
      }
    })
  }
})

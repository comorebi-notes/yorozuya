// https://getbootstrap.jp/docs/4.5/components/forms/#file-browser
// .custom-file を使用する場合に必要

import bsCustomFileInput from 'bs-custom-file-input'

document.addEventListener('turbolinks:load', () => bsCustomFileInput.init())

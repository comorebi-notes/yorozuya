// Polyfill
import 'core-js/stable'
import 'regenerator-runtime/runtime'
import 'fetch-polyfill'

// Rails
import Rails from '@rails/ujs'
import Turbolinks from 'turbolinks'
import * as ActiveStorage from '@rails/activestorage'
import 'channels'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Scripts
const requireContext = require.context('../scripts/application', true)
requireContext.keys().forEach(requireContext)

// 画像
require.context('../images/application', true);

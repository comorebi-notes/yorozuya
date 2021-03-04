// Polyfill
import 'core-js/stable'
import 'regenerator-runtime/runtime'
import 'fetch-polyfill'

// Libraries
import $ from 'jquery'
import 'bootstrap'
import '@fortawesome/fontawesome-free/js/all'

global.$ = $
global.jQuery = $

require('@nathanvda/cocoon')

// Sass
import '../src/stylesheets/application.sass'

// Rails
import Rails from '@rails/ujs'
import Turbolinks from 'turbolinks'
import * as ActiveStorage from '@rails/activestorage'
import 'channels'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Scripts
const requireContext = require.context('../scripts/commons', true)
requireContext.keys().forEach(requireContext)

// React
const componentRequireContext = require.context('../components', true)
const ReactRailsUJS = require('react_ujs')
ReactRailsUJS.useContext(componentRequireContext)

// 画像
require.context('../images', true);

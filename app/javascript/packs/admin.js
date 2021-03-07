// Polyfill
import 'core-js/stable'
import 'regenerator-runtime/runtime'
import 'fetch-polyfill'

// Libraries
import $ from 'jquery'
import 'bootstrap'
import '@fortawesome/fontawesome-free/js/all'

// Sass
import '../src/stylesheets/admin/index.sass'

global.$ = $
global.jQuery = $

require('@nathanvda/cocoon')

// Scripts
const requireContext = require.context('../scripts/admin', true)
requireContext.keys().forEach(requireContext)

// React
// const componentRequireContext = require.context('../components', true)
// const ReactRailsUJS = require('react_ujs')
// ReactRailsUJS.useContext(componentRequireContext)

// 画像
require.context('../images/admin', true)

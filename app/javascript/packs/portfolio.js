// Polyfill
import 'core-js/stable'
import 'regenerator-runtime/runtime'
import 'fetch-polyfill'

// Libraries
import 'bootstrap'
import '@fortawesome/fontawesome-free/js/all'

// Sass
import '../src/stylesheets/portfolio/index.sass'

// Scripts
const requireContext = require.context('../scripts/portfolio', true)
requireContext.keys().forEach(requireContext)

// React
// const componentRequireContext = require.context('../components', true)
// const ReactRailsUJS = require('react_ujs')
// ReactRailsUJS.useContext(componentRequireContext)

// 画像
require.context('../images/portfolio', true)
